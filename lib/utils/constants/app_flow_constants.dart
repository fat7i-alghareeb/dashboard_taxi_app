/// App flow and routing related constants.
class OnboardingStorageKeys {
  OnboardingStorageKeys._();

  /// Persistent flag indicating that onboarding was completed at least once.
  static const String finished = 'onboarding.finished';
}

/// Configuration for splash screen behavior.
class SplashConfig {
  SplashConfig._();

  /// Minimal time the splash screen should remain visible before
  /// navigation logic can move away from it.
  static const Duration initialDelay = Duration(seconds: 2);

  /// Maximum time allowed for map warmup during splash before falling back
  /// and continuing startup flow.
  static const Duration mapWarmupTimeout = Duration(seconds: 8);

  static Duration durationForSplashScreen =
      initialDelay - const Duration(milliseconds: 1000);
}

/// Global switches controlling which startup flows are active.
class AppFlowConfig {
  AppFlowConfig._();

  /// * Enable or disable the onboarding flow.
  static const bool onboardingEnabled = false;

  /// * Enable or disable authentication-based routing.
  static const bool authEnabled = true;

  /// * Enable or disable the permission gate flow.
  static const bool permissionGateEnabled = true;
}

/// Map related configuration and defaults.
class MapConfig {
  MapConfig._();

  /// Default starting point if no location can be found (Aleppo Center).
  static const double defaultLat = 36.2021;
  static const double defaultLng = 37.1343;

  /// Zoom level used when the map initially loads in broad view.
  static const double initialZoom = 10;

  /// Zoom level used when focused on the user's precise location.
  static const double focusZoom = 18.0;

  /// Zoom level used during the middle of a cinematic flight animation.
  /// Higher values mean less "zoom out" during recentering.
  static const double flightZoomOut = 18.0;

  /// Duration of the cinematic recentering flight.
  static const Duration flightDuration = Duration(milliseconds: 100);
}

/// Log tags for routing / flow related components.
class RouterLogTags {
  RouterLogTags._();

  static const String router = '[Router]';
  static const String redirect = '[RouterRedirect]';
}
