import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform;
// AndroidSettings / AppleSettings / ForegroundNotificationConfig are re-exported
// by the geolocator umbrella package, so no platform-specific imports are needed.
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

  /// Returns a live position stream.
  ///
  /// When [keepAliveInBackground] is true the stream is configured to survive the
  /// app being minimized: on Android it promotes the app to a foreground service
  /// (persistent notification), and on iOS it enables background location updates.
  /// Used while an active trip is being tracked so the customer keeps receiving the
  /// driver's location even when the driver app is in the background.
  Stream<Position> getPositionStream({
    LocationAccuracy accuracy = LocationAccuracy.high,
    int distanceFilter = 0,
    bool keepAliveInBackground = false,
    String foregroundNotificationTitle = 'Fat7i',
    String foregroundNotificationText = 'Sharing your live location',
  }) {
    final LocationSettings settings = _buildSettings(
      accuracy: accuracy,
      distanceFilter: distanceFilter,
      keepAliveInBackground: keepAliveInBackground,
      foregroundNotificationTitle: foregroundNotificationTitle,
      foregroundNotificationText: foregroundNotificationText,
    );

    return Geolocator.getPositionStream(locationSettings: settings);
  }

  LocationSettings _buildSettings({
    required LocationAccuracy accuracy,
    required int distanceFilter,
    required bool keepAliveInBackground,
    required String foregroundNotificationTitle,
    required String foregroundNotificationText,
  }) {
    // TRACKING DISABLED: background survival is off product-wide. The remaining
    // callers only need the driver's own position while the app is in the
    // foreground, so the foreground service and iOS background updates are not
    // requested any more — [keepAliveInBackground] is honoured only by the
    // commented-out branches, which restore the old behaviour when uncommented.
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidSettings(
        accuracy: accuracy,
        distanceFilter: distanceFilter,
        /*
        foregroundNotificationConfig: keepAliveInBackground
            ? ForegroundNotificationConfig(
                notificationTitle: foregroundNotificationTitle,
                notificationText: foregroundNotificationText,
                enableWakeLock: true,
                setOngoing: true,
              )
            : null,
        */
      );
    }

    if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      return AppleSettings(
        accuracy: accuracy,
        distanceFilter: distanceFilter,
        /*
        allowBackgroundLocationUpdates: keepAliveInBackground,
        showBackgroundLocationIndicator: keepAliveInBackground,
        */
      );
    }

    return LocationSettings(accuracy: accuracy, distanceFilter: distanceFilter);
  }
}
