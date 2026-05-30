import '../../domain/entities/trip_entity.dart';
import '../models/trip_model.dart';

extension TripStopModelMapper on TripStopModel {
  TripStopEntity get toEntity => TripStopEntity(
    latitude: latitude,
    longitude: longitude,
    label: label,
    sequence: sequence,
    isCompleted: isCompleted,
    completedAtUtc: completedAtUtc,
  );
}

extension TripModelMapper on TripModel {
  TripEntity get toEntity => TripEntity(
    id: id,
    referenceCode: referenceCode,
    passengerId: passengerId,
    driverId: driverId,
    vehicleTypeId: vehicleTypeId,
    status: _mapStatus(status),
    quotedFare: quotedFare,
    currencyCode: currencyCode,
    createdAtUtc: createdAtUtc,
    scheduledAtUtc: scheduledAtUtc,
    stops: stops.map((e) => e.toEntity).toList(),
    driverLatitude: driverLatitude,
    driverLongitude: driverLongitude,
    vehicleTypeName: vehicleTypeName,
    cancellation: cancellation?.toEntity,
    compensationClaim: compensationClaim?.toEntity,
    activeWaitingSession: activeWaitingSession?.toEntity,
    passengerName: passengerName,
    passengerPhone: passengerPhone,
    routeSegments: routeSegments.map((e) => e.toEntity).toList(),
    encodedOverviewPolyline: encodedOverviewPolyline,
  );
}

extension TripCancellationModelMapper on TripCancellationModel {
  TripCancellationEntity get toEntity => TripCancellationEntity(
    actor: actor,
    reason: reason,
    refundPercent: refundPercent,
    refundAmount: refundAmount,
    currencyCode: currencyCode,
    note: note,
  );
}

extension TripCompensationClaimModelMapper on TripCompensationClaimModel {
  TripCompensationClaimEntity get toEntity => TripCompensationClaimEntity(
    id: id,
    status: status,
    requestedAmount: requestedAmount,
    currencyCode: currencyCode,
    note: note,
  );
}

extension TripWaitingSessionModelMapper on TripWaitingSessionModel {
  TripWaitingSessionEntity get toEntity => TripWaitingSessionEntity(
    id: id,
    minutes: minutes,
    estimatedFee: estimatedFee,
    isActive: isActive,
  );
}

extension TripRouteSegmentModelMapper on TripRouteSegmentModel {
  TripRouteSegmentEntity get toEntity => TripRouteSegmentEntity(
    distanceMeters: distanceMeters,
    durationSeconds: durationSeconds,
    encodedPolyline: encodedPolyline,
    startLatitude: startLatitude,
    startLongitude: startLongitude,
    endLatitude: endLatitude,
    endLongitude: endLongitude,
  );
}

TripStatus _mapStatus(String value) {
  final normalized = value.trim().toLowerCase();
  return switch (normalized) {
    'pendingquote' => TripStatus.pendingQuote,
    'awaitingpayment' => TripStatus.awaitingPayment,
    'scheduled' => TripStatus.scheduled,
    'pendingdriver' => TripStatus.pendingDriver,
    'driverassigned' => TripStatus.driverAssigned,
    'driverenroute' => TripStatus.driverEnRoute,
    'driverarrived' => TripStatus.driverArrived,
    'inprogress' => TripStatus.inProgress,
    'completed' => TripStatus.completed,
    'cancelled' => TripStatus.cancelled,
    'paymentfailed' => TripStatus.paymentFailed,
    'refunded' => TripStatus.refunded,
    _ => TripStatus.unknown,
  };
}
