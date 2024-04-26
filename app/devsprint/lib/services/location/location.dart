import 'dart:math';
import 'package:devsprint/services/location/location_state.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class LocationRepository {
  Future<LocationState> getLocation() async {
    LocationPermission permission;

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    // if service is not enabled then ask the user to enable it
    if (!serviceEnabled) {
      final v = await Geolocator.openLocationSettings();
      if (!v) {
        return LocationState.fromError(LocationStateError.serviceDisabled);
      }

      bool k = await Geolocator.isLocationServiceEnabled();

      if (!k) {
        return LocationState.fromError(LocationStateError.serviceDisabled);
      }
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      try {
        permission = await Geolocator.requestPermission();
      } catch (e) {
        if (e is PermissionRequestInProgressException) {
          // Handle the exception here, such as returning a pending state
          // You can also wait for a while and then try again
          // Remember to handle any other exceptions that might occur
          return LocationState.fromError(LocationStateError.permissionDenied);
        }
      }

      if (permission == LocationPermission.denied) {
        return LocationState.fromError(LocationStateError.permissionDenied);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return LocationState.fromError(
          LocationStateError.permissionDeniedForever);
    }

    Position postion = await Geolocator.getCurrentPosition();

    // // TODO: Check if user is logged in and has access to location,
    // if (user != null &&
    //     user?.uid != null &&
    //     user?.userLocationPermission == UserLocationPermission.access) {
    //   await _userLocationRepository.updateLocation(
    //     userId: user!.uid,
    //     geoPoint: GeoPoint(
    //       postion.latitude,
    //       postion.longitude,
    //     ),
    //   );
    // }

    return LocationState.fromPosition(postion);
  }

  static double calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    var p = 0.017453292519943295; // Math.PI / 180
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;

    double disInKm = 12742 * asin(sqrt(a)); // 2 * R; R = 6371 km
    return disInKm.roundToDouble();
  }
}