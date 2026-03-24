import 'dart:io';

import 'package:clothing_ecommerce/core/app_constants.dart';
import 'package:clothing_ecommerce/core/common/common_services/firestore_services.dart';
import 'package:clothing_ecommerce/features/profile/model/user_assets_model.dart';
import 'package:clothing_ecommerce/features/profile/model/user_details_model.dart';
import 'package:clothing_ecommerce/main.dart';
import 'package:cloudinary_api/uploader/cloudinary_uploader.dart';
import 'package:cloudinary_api/src/request/model/uploader_params.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'profile_details_state.dart';

class ProfileDetailsCubit extends Cubit<ProfileDetailsState> {
  ProfileDetailsCubit() : super(ProfileDetailsInitial());
  final firestoreServices = FirestoreServices.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<void> fetchProfileDetails() async {
    emit(ProfileDetailsLoading());
    try {
      final String userId = firebaseAuth.currentUser!.uid;
      final List<String> fieldsName = ["name", "email"];
      final UserDetailsModel fields = await firestoreServices.getFields(
        path: FirestoreApiPathes.user(userId),
        fieldsName: fieldsName,
        builder: (fields) => UserDetailsModel.fromMap(fields),
      );
      emit(ProfileDetailsLoaded(fields));
    } catch (e) {
      emit(ProfileDetailsError(e.toString()));
    }
  }

  Future<String?> syncProfileImageToCloudinary(File? image) async {
    if (image == null) return null;
    final response = await cloudinary.uploader().upload(
      image,
      params: UploadParams(
        publicId: "profile_image",
        overwrite: true,
        uniqueFilename: false,
      ),
    );
    return response?.data?.secureUrl;
  }

  Future<File?> pickImage() async {
    File _image;
    // String? imageUrl;
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      // imageUrl = _image.path;
      // return imageUrl;
      return _image;
    }
    return null;
  }

  Future<void> uploadImageToFirestore() async {
    File? image = await pickImage();
    if (image == null) {
      return;
    }
    emit(ProfileImageUploading());
    String? networkImage = await syncProfileImageToCloudinary(image);
    final String imageId = networkImage!.split("/").last;
    final String userId = firebaseAuth.currentUser!.uid;
    try {
      await firestoreServices.setDocument(
        path: FirestoreApiPathes.userImage(userId, "imageId"),
        data: UserAssetsModel(id: imageId).toMap(),
      );
      await firestoreServices.setDocument(
        path: FirestoreApiPathes.userImage(userId, imageId),
        data: UserAssetsModel(profileImage: networkImage).toMap(),
      );
      emit(ProfileImageUploaded());
    } catch (e) {
      emit(ProfileImageUploadError(e.toString()));
    }
  }

  Future<void> fetchImageFromFirestore() async {
    final String userId = firebaseAuth.currentUser!.uid;
    String? imageId = await firestoreServices.getFields(
      path: FirestoreApiPathes.userImage(userId, "imageId"),
      fieldsName: ["id"],
      builder: (imagePath) => UserAssetsModel.fromMap(imagePath).id,
    );
    if (imageId == null) {
      return;
    }
    emit(FetchingProfileImage());
    try {
      final List<String> fieldsName = ["profileImage"];
      final UserAssetsModel fields = await firestoreServices.getFields(
        path: FirestoreApiPathes.userImage(userId, imageId),
        fieldsName: fieldsName,
        builder: (fields) => UserAssetsModel.fromMap(fields),
      );
      // if (fields.profileImage == null) {
      //   return;
      // }
      emit(FetchedProfileImage(fields.profileImage));
    } catch (e) {
      emit(FetchingProfileImageError(e.toString()));
    }
  }
}
