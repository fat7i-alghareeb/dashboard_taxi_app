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
}

/// Stable list of every SignalR method name the hub will push to clients.
/// Used by [RealtimeService] implementations to register handlers.
abstract final class RealtimeMethodNames {
  static const tripRequested = 'TripRequested';
  static const driverAssigned = 'DriverAssigned';
  static const tripStarted = 'TripStarted';
  static const tripCompleted = 'TripCompleted';
  static const tripCancelled = 'TripCancelled';
  static const paymentConfirmed = 'PaymentConfirmed';
  static const paymentFailed = 'PaymentFailed';
  static const tripRefunded = 'TripRefunded';
  static const driverEnRoute = 'DriverEnRoute';
  static const driverArrived = 'DriverArrived';
  static const driverLocationUpdated = 'DriverLocationUpdated';

  static const all = <String>[
    tripRequested,
    driverAssigned,
    tripStarted,
    tripCompleted,
    tripCancelled,
    paymentConfirmed,
    paymentFailed,
    tripRefunded,
    driverEnRoute,
    driverArrived,
    driverLocationUpdated,
  ];
}

/// Extracts the trip id field common to every event variant.
extension RealtimeEventTripId on RealtimeEvent {
  String get tripId => switch (this) {
    RealtimeTripRequested(:final tripId) => tripId,
    RealtimeDriverAssigned(:final tripId) => tripId,
    RealtimeTripStarted(:final tripId) => tripId,
    RealtimeTripCompleted(:final tripId) => tripId,
    RealtimeTripCancelled(:final tripId) => tripId,
    RealtimePaymentConfirmed(:final tripId) => tripId,
    RealtimePaymentFailed(:final tripId) => tripId,
    RealtimeTripRefunded(:final tripId) => tripId,
    RealtimeDriverEnRoute(:final tripId) => tripId,
    RealtimeDriverArrived(:final tripId) => tripId,
    RealtimeDriverLocationUpdated(:final tripId) => tripId,
  };
}
