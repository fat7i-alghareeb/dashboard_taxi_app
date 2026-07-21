import 'package:freezed_annotation/freezed_annotation.dart';

part 'realtime_event.freezed.dart';

/// Sealed union of every real-time push the backend can deliver via the
/// SignalR TripHub. The union variant name matches the SignalR method
/// name on the hub (e.g. `TripRequested`, `PaymentConfirmed`).
///
/// Keep this file in sync with the records in
/// `Taxi.Contracts.Notifications.TripNotifications`.
@freezed
sealed class RealtimeEvent with _$RealtimeEvent {
  const factory RealtimeEvent.tripRequested({
    required String tripId,
    required String vehicleTypeId,
    required String passengerId,
  }) = RealtimeTripRequested;

  const factory RealtimeEvent.tripAwaitingAdminAcceptance({
    required String tripId,
    required String vehicleTypeId,
    required String passengerId,
    String? scheduledAtUtc,
  }) = RealtimeTripAwaitingAdminAcceptance;

  const factory RealtimeEvent.tripAccepted({
    required String tripId,
    required String passengerId,
    required String adminId,
  }) = RealtimeTripAccepted;

  const factory RealtimeEvent.driverAssigned({
    required String tripId,
    required String passengerId,
    required String driverId,
  }) = RealtimeDriverAssigned;

  const factory RealtimeEvent.tripStarted({
    required String tripId,
    required String passengerId,
  }) = RealtimeTripStarted;

  const factory RealtimeEvent.tripCompleted({
    required String tripId,
    required String passengerId,
  }) = RealtimeTripCompleted;

  const factory RealtimeEvent.tripCancelled({
    required String tripId,
    required String passengerId,
  }) = RealtimeTripCancelled;

  const factory RealtimeEvent.paymentConfirmed({
    required String tripId,
    required String passengerId,
  }) = RealtimePaymentConfirmed;

  const factory RealtimeEvent.paymentFailed({
    required String tripId,
    required String passengerId,
    required String reason,
  }) = RealtimePaymentFailed;

  const factory RealtimeEvent.tripRefunded({
    required String tripId,
    required String passengerId,
    required double amount,
  }) = RealtimeTripRefunded;

  const factory RealtimeEvent.refundLifecycleChanged({
    required String refundId,
    required String paymentId,
    String? tripId,
    String? passengerId,
    required String status,
    required double amount,
    required String currency,
    required bool requiresAdminAction,
    required bool canRetry,
    required String sourceType,
  }) = RealtimeRefundLifecycleChanged;

  const factory RealtimeEvent.refundIssueCreated({
    required String refundIssueId,
    required String tripId,
    required String passengerId,
    String? paymentId,
    required String requestType,
    required String reviewStatus,
  }) = RealtimeRefundIssueCreated;

  const factory RealtimeEvent.driverEnRoute({
    required String tripId,
    required String passengerId,
    required String driverId,
  }) = RealtimeDriverEnRoute;

  const factory RealtimeEvent.driverArrived({
    required String tripId,
    required String passengerId,
    required String driverId,
  }) = RealtimeDriverArrived;

  const factory RealtimeEvent.driverLocationUpdated({
    required String tripId,
    required String driverId,
    required double latitude,
    required double longitude,
  }) = RealtimeDriverLocationUpdated;

  const factory RealtimeEvent.tripStopCompleted({
    required String tripId,
    required String passengerId,
    String? driverId,
    required int sequence,
  }) = RealtimeTripStopCompleted;

  /// A new in-trip chat message arrived. [sentAtUtc] is an ISO-8601 string.
  const factory RealtimeEvent.tripMessageReceived({
    required String tripId,
    required String messageId,
    required String senderId,
    required String senderRole,
    String? content,
    String? photoUrl,
    required String sentAtUtc,
  }) = RealtimeTripMessageReceived;

  /// The trip's chat was closed (trip completed or cancelled).
  const factory RealtimeEvent.chatClosed({required String tripId}) =
      RealtimeChatClosed;

  /// A new customer incident was recorded (admins-only feed). [tripId] is empty
  /// when the incident is not tied to a trip.
  const factory RealtimeEvent.customerIncidentRaised({
    required String incidentId,
    required String passengerId,
    required String tripId,
    required String type,
    required String severity,
  }) = RealtimeCustomerIncidentRaised;

  /// The trip's drop-off changed mid-trip. The driver app re-fetches the active
  /// trip (new drop-off + route polyline) so the map/nav re-routes.
  const factory RealtimeEvent.tripDestinationChanged({
    required String tripId,
    required String passengerId,
    String? driverId,
    required double newDropoffLatitude,
    required double newDropoffLongitude,
    String? newDropoffLabel,
  }) = RealtimeTripDestinationChanged;

  /// A re-priced customer edit was committed — new route, party size, vehicle or all
  /// three, with the fare difference already settled. Broader than
  /// [RealtimeTripDestinationChanged], which only fires when the drop-off itself moved
  /// and carries no fare, so passenger-count and van upgrades never reached the admin.
  const factory RealtimeEvent.tripEditApplied({
    required String tripId,
    required String passengerId,
    required double newFare,
    required String currency,
    required double delta,
    required int passengerCount,
    String? vehicleTypeName,
    String? dropoffLabel,
  }) = RealtimeTripEditApplied;
}

/// Stable list of every SignalR method name the hub will push to clients.
/// Used by [RealtimeService] implementations to register handlers.
abstract final class RealtimeMethodNames {
  static const tripRequested = 'TripRequested';
  static const tripAwaitingAdminAcceptance = 'TripAwaitingAdminAcceptance';
  static const tripAccepted = 'TripAccepted';
  static const driverAssigned = 'DriverAssigned';
  static const tripStarted = 'TripStarted';
  static const tripCompleted = 'TripCompleted';
  static const tripCancelled = 'TripCancelled';
  static const paymentConfirmed = 'PaymentConfirmed';
  static const paymentFailed = 'PaymentFailed';
  static const tripRefunded = 'TripRefunded';
  static const refundLifecycleChanged = 'RefundLifecycleChanged';
  static const refundIssueCreated = 'RefundIssueCreated';
  static const driverEnRoute = 'DriverEnRoute';
  static const driverArrived = 'DriverArrived';
  static const driverLocationUpdated = 'DriverLocationUpdated';
  static const tripStopCompleted = 'TripStopCompleted';
  static const tripMessageReceived = 'TripMessageReceived';
  static const chatClosed = 'ChatClosed';
  static const customerIncidentRaised = 'CustomerIncidentRaised';
  static const tripDestinationChanged = 'TripDestinationChanged';
  static const tripEditApplied = 'TripEditApplied';

  static const all = <String>[
    tripRequested,
    tripAwaitingAdminAcceptance,
    tripAccepted,
    driverAssigned,
    tripStarted,
    tripCompleted,
    tripCancelled,
    paymentConfirmed,
    paymentFailed,
    tripRefunded,
    refundLifecycleChanged,
    refundIssueCreated,
    driverEnRoute,
    driverArrived,
    driverLocationUpdated,
    tripStopCompleted,
    tripMessageReceived,
    chatClosed,
    customerIncidentRaised,
    tripDestinationChanged,
    tripEditApplied,
  ];
}

/// Extracts the trip id field common to every event variant.
extension RealtimeEventTripId on RealtimeEvent {
  String get tripId => switch (this) {
    RealtimeTripRequested(:final tripId) => tripId,
    RealtimeTripAwaitingAdminAcceptance(:final tripId) => tripId,
    RealtimeTripAccepted(:final tripId) => tripId,
    RealtimeDriverAssigned(:final tripId) => tripId,
    RealtimeTripStarted(:final tripId) => tripId,
    RealtimeTripCompleted(:final tripId) => tripId,
    RealtimeTripCancelled(:final tripId) => tripId,
    RealtimePaymentConfirmed(:final tripId) => tripId,
    RealtimePaymentFailed(:final tripId) => tripId,
    RealtimeTripRefunded(:final tripId) => tripId,
    RealtimeRefundLifecycleChanged(:final tripId) => tripId ?? '',
    RealtimeRefundIssueCreated(:final tripId) => tripId,
    RealtimeDriverEnRoute(:final tripId) => tripId,
    RealtimeDriverArrived(:final tripId) => tripId,
    RealtimeDriverLocationUpdated(:final tripId) => tripId,
    RealtimeTripStopCompleted(:final tripId) => tripId,
    RealtimeTripMessageReceived(:final tripId) => tripId,
    RealtimeChatClosed(:final tripId) => tripId,
    RealtimeCustomerIncidentRaised(:final tripId) => tripId,
    RealtimeTripDestinationChanged(:final tripId) => tripId,
    RealtimeTripEditApplied(:final tripId) => tripId,
  };
}
