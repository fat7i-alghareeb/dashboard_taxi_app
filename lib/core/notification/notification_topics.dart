/// FCM topic names shared with the backend.
///
/// These strings must match the topics the backend publishes to (see
/// TAXI_SERVER `TripRequestedEventHandler` / `BroadcastNotificationCommandHandler`).
class NotificationTopics {
  NotificationTopics._();

  /// Receives driver-facing broadcast alerts.
  static const String drivers = 'drivers';

  /// Receives admin-facing alerts (e.g. new booking awaiting acceptance).
  ///
  /// Used as a backup delivery channel: the backend sends admin push to each
  /// admin's per-device token first, and falls back to this topic when no
  /// device token delivery succeeds (see TAXI_SERVER `FcmNotificationService`).
  static const String admins = 'admins';
}
