import 'package:clothing_ecommerce/core/app_constants.dart';
import 'package:clothing_ecommerce/core/common/common_services/firestore_services.dart';
import 'package:clothing_ecommerce/features/auth/models/create_user_model.dart';
import 'package:clothing_ecommerce/features/auth/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  final AuthServices _authServices = AuthServicesImpl();
  final _firebaseAuth = FirebaseAuth.instance;
  final FirestoreServices firestoreServices = FirestoreServices.instance;

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(SignUpLoading());
    try {
      await _authServices.registerWithEmailAndPassword(email, password);
      await saveUserToFirestore(email: email, name: name);
      emit(SignUpSuccess());
    } catch (e) {
      emit(SignUpError(e.toString()));
    }
  }

  Future<void> saveUserToFirestore({
    required String email,
    required String name,
  }) async {
    try {
      final currentUser = _firebaseAuth.currentUser;
      await firestoreServices.setData(
        path: FirestoreApiPathes.user(currentUser!.uid),
        data: CreateUserModel(
          id: currentUser.uid,
          name: name,
          email: email,
          createdAt: DateTime.now().toIso8601String(),
        ).toMap(),
      );
    } catch (e) {
      emit(SignUpError(e.toString()));
    }
  }
}
