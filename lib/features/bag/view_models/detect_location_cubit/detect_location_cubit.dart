// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:latlong2/latlong.dart';

// part 'detect_location_state.dart';

// class DetectLocationCubit extends Cubit<DetectLocationState> {
//   DetectLocationCubit() : super(DetectLocationInitial()) {
//     debugPrint("👋 DetectLocationInitial");
//   }
//   Future<void> getCurrentLocation() async {
//     emit(DetectLocationLoading());

//     try {
//       // Check if location services (GPS) are enabled
//       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) {
//         emit(
//           DetectLocationError(
//             'Location services are disabled. Please enable GPS',
//           ),
//         );
//         return;
//       }
//       // Check if location permissions are granted
//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         // Show dialog to request location permissions
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           // If permissions are still denied, show error message
//           emit(DetectLocationError('Location permissions are denied'));
//           return;
//         }
//       }
//       // if are denied forever, show error message
//       if (permission == LocationPermission.deniedForever) {
//         emit(
//           DetectLocationError(
//             'Location permissions are permanently denied, we cannot request permissions.',
//           ),
//         );
//         return;
//       }

//       const LocationSettings locationSettings = LocationSettings(
//         accuracy: LocationAccuracy.high,
//         distanceFilter: 0,
//         timeLimit: null,
//       );
//       // Get the current location
//       Position position = await Geolocator.getCurrentPosition(
//         locationSettings: locationSettings,
//       );

//       emit(
//         DetectLocationSuccess(LatLng(position.latitude, position.longitude)),
//       );
//     } catch (e) {
//       emit(DetectLocationError('Failed to check location services: $e'));
//       return;
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

part 'detect_location_state.dart';

class DetectLocationCubit extends Cubit<DetectLocationState> {
  DetectLocationCubit() : super(DetectLocationInitial()) {
    debugPrint("👋 [CUBIT] Constructor: Initial State Created");
  }

  Future<void> getCurrentLocation() async {
    debugPrint("🚀 [CUBIT] getCurrentLocation started");
    emit(DetectLocationLoading());
    debugPrint("⏳ [CUBIT] Emitted Loading State");

    try {
      // 1. Check GPS Service
      debugPrint("🛰️ [CUBIT] Checking if GPS service is enabled...");
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      debugPrint("📡 [CUBIT] GPS Service Enabled? $serviceEnabled");

      if (!serviceEnabled) {
        debugPrint("❌ [CUBIT] GPS Service Disabled -> Emitting Error");
        emit(
          DetectLocationError(
            'Location services are disabled. Please enable GPS',
          ),
        );
        return;
      }

      // 2. Check Permissions
      debugPrint("🔐 [CUBIT] Checking permissions...");
      LocationPermission permission = await Geolocator.checkPermission();
      debugPrint("🔑 [CUBIT] Current Permission: $permission");

      if (permission == LocationPermission.denied) {
        debugPrint("⚠️ [CUBIT] Permission Denied -> Requesting...");
        permission = await Geolocator.requestPermission();
        debugPrint("🔑 [CUBIT] New Permission after request: $permission");

        if (permission == LocationPermission.denied) {
          debugPrint("❌ [CUBIT] Permission Still Denied -> Emitting Error");
          emit(DetectLocationError('Location permissions are denied'));
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        debugPrint("🚫 [CUBIT] Permission Denied Forever -> Emitting Error");
        emit(
          DetectLocationError('Location permissions are permanently denied'),
        );
        return;
      }

      // 3. Get Position (هنا ممكن الوقعة تحصل)
      debugPrint("📍 [CUBIT] About to call Geolocator.getCurrentPosition...");

      const LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 0,
        timeLimit:
            null, // ⚠️ انتبه: مفيش وقت أقصى هنا، ممكن يستنى للأبد لو الإشارة ضعيفة
      );

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );

      debugPrint(
        "✅ [CUBIT] Got Position: ${position.latitude}, ${position.longitude}",
      );
      emit(
        DetectLocationSuccess(LatLng(position.latitude, position.longitude)),
      );
      debugPrint("🏁 [CUBIT] Emitted Success State");
    } catch (e) {
      debugPrint("💥 [CUBIT] CATCH BLOCK TRIGGERED: $e");
      emit(DetectLocationError('Failed to check location services: $e'));
      debugPrint("🛑 [CUBIT] Emitted Error State from Catch");
      return;
    }
  }
}
