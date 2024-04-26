import 'package:geolocator/geolocator.dart';

enum LocationStateError {
  permissionDeniedForever(
      'Location permission denied forever - please open app settings'),
  permissionDenied('Location permissions denied'),
  serviceDisabled('Location services disabled'),
  unknownError('Unknown error'),
  none('');

  final String message;

  const LocationStateError(this.message);
}

class LocationState {
  final Position? position;
  final LocationStateError error;

  LocationState({
    this.position,
    required this.error,
  });

  bool get hasError => error != LocationStateError.none;

  factory LocationState.fromPosition(Position position) {
    return LocationState(
      position: position,
      error: LocationStateError.none,
    );
  }

  factory LocationState.fromError(LocationStateError error) {
    return LocationState(position: null, error: error);
  }

  factory LocationState.copy(LocationState state) {
    return LocationState(position: state.position, error: state.error);
  }

  factory LocationState.initial() {
    return LocationState(position: null, error: LocationStateError.none);
  }
}