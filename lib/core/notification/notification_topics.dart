/// FCM topic names shared with the backend.
///
/// These strings must match the topics the backend publishes to (see
/// TAXI_SERVER `TripRequestedEventHandler` / `BroadcastNotificationCommandHandler`).
class NotificationTopics {
  NotificationTopics._();

  /// Receives driver-facing broadcast alerts.
  static const String drivers = 'drivers';

}
