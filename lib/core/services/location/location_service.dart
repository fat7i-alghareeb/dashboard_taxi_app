import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

import '../../../utils/helpers/colored_print.dart';

/// Wraps geolocator APIs behind a small service surface.
@lazySingleton
class LocationService {
  const LocationService();

  Future<bool> isLocationServiceEnabled() {
    return Geolocator.isLocationServiceEnabled();
  }

  Future<LocationPermission> checkPermission() {
    return Geolocator.checkPermission();
  }

  Future<LocationPermission> requestPermission() {
    return Geolocator.requestPermission();
  }

  Future<Position?> getLastKnownPosition() {
    return Geolocator.getLastKnownPosition();
  }

  Future<Position> getCurrentPosition({
    LocationAccuracy accuracy = LocationAccuracy.high,
  }) async {
    try {
      return await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: accuracy),
      );
    } catch (e) {
      printY('[Location] getCurrentPosition failed: $e');
      rethrow;
    }
  }

  Stream<Position> getPositionStream({
    LocationAccuracy accuracy = LocationAccuracy.high,
    int distanceFilter = 0,
  }) {
    return Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: accuracy,
        distanceFilter: distanceFilter,
      ),
    );
  }
}
