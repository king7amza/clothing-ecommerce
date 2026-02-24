part of 'detect_location_cubit.dart';

sealed class DetectLocationState {}

final class DetectLocationInitial extends DetectLocationState {}

final class DetectLocationLoading extends DetectLocationState {}

final class DetectLocationSuccess extends DetectLocationState {
  final LatLng location;
  DetectLocationSuccess(this.location);
}

final class DetectLocationError extends DetectLocationState {
  final String error;
  DetectLocationError(this.error);
}
