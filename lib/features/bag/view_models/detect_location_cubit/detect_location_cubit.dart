import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

part 'detect_location_state.dart';

class DetectLocationCubit extends Cubit<DetectLocationState> {
  DetectLocationCubit() : super(DetectLocationInitial());

  Future<void> getCurrentLocation() async {
    emit(DetectLocationLoading());
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(
          DetectLocationError(
            'Location services are disabled. Please enable GPS',
          ),
        );
        return;
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(DetectLocationError('Location permissions are denied'));
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        emit(
          DetectLocationError(
            'Location permissions are permanently denied, we cannot request permissions.',
          ),
        );
        return;
      }

      const LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high, 
        distanceFilter: 0,
        timeLimit: null,
      );

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );

      emit(
        DetectLocationSuccess(LatLng(position.latitude, position.longitude)),
      );
    } catch (e) {
      emit(DetectLocationError('Failed to check location services: $e'));
      return;
    }
  }
}
