part of 'profile_details_cubit.dart';

sealed class ProfileDetailsState {}

final class ProfileDetailsInitial extends ProfileDetailsState {}

final class ProfileDetailsLoading extends ProfileDetailsState {}

final class ProfileDetailsLoaded extends ProfileDetailsState {
  final UserDetailsModel userDetails;
  ProfileDetailsLoaded(this.userDetails);
}

final class ProfileDetailsError extends ProfileDetailsState {
  final String message;
  ProfileDetailsError(this.message);
}

final class ProfileImageUploading extends ProfileDetailsState {}

final class ProfileImageUploaded extends ProfileDetailsState {}

final class ProfileImageUploadError extends ProfileDetailsState {
  final String message;
  ProfileImageUploadError(this.message);
}



final class FetchingProfileImage extends ProfileDetailsState {}

final class FetchedProfileImage extends ProfileDetailsState {
  final String? profileImage;
  FetchedProfileImage(this.profileImage);
}

final class FetchingProfileImageError extends ProfileDetailsState {
  final String message;
  FetchingProfileImageError(this.message);
}