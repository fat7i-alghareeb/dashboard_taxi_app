/// Parameters for broadcasting a push notification to a target audience.
///
/// Audience values mirror the backend `NotificationAudience` enum:
/// Customers = 0, Drivers = 1, Admins = 2. This dashboard screen always
/// targets customers (the "customers"/users topic).
class BroadcastNotificationParams {
  const BroadcastNotificationParams({
    required this.title,
    required this.body,
    this.audience = 0,
  });

  final String title;
  final String body;
  final int audience;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'audience': audience,
    'title': title,
    'body': body,
  };
}
