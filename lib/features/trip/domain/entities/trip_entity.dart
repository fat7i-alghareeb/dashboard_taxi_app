enum TripStatus {
  pendingQuote,
  awaitingPayment,
  awaitingAdminAcceptance,
  accepted,
  enRoute,
  arrived,
  inProgress,
  completed,
  cancelled,
  paymentFailed,
  refunded,
  unknown;

  bool get isActiveDriverFlow {
    return switch (this) {
      TripStatus.accepted ||
      TripStatus.enRoute ||
      TripStatus.arrived ||
      TripStatus.inProgress => true,
      _ => false,
    };
  }

  bool get isTerminal {
    return switch (this) {
      TripStatus.completed ||
      TripStatus.cancelled ||
      TripStatus.paymentFailed ||
      TripStatus.refunded => true,
      _ => false,
    };
  }
}

class TripStopEntity {
  const TripStopEntity({
    required this.latitude,
    required this.longitude,
    this.label,
    this.sequence = 0,
    this.isCompleted = false,
    this.completedAtUtc,
  });

  final double latitude;
  final double longitude;
  final String? label;
  final int sequence;
  final bool isCompleted;
  final DateTime? completedAtUtc;

  String get coordinateLabel {
    final lat = latitude.toStringAsFixed(5);
    final lng = longitude.toStringAsFixed(5);
    return '$lat, $lng';
  }

  String get displayLabel {
    final value = label;
    if (value == null || value.trim().isEmpty) return coordinateLabel;
    return value;
  }
}

class TripEntity {
  const TripEntity({
    required this.id,
    required this.referenceCode,
    required this.passengerId,
    required this.vehicleTypeId,
    required this.status,
    required this.quotedFare,
    required this.currencyCode,
    required this.createdAtUtc,
    required this.stops,
    this.driverId,
    this.scheduledAtUtc,
    this.driverLatitude,
    this.driverLongitude,
    this.vehicleTypeName,
    this.cancellation,
    this.compensationClaim,
    this.activeWaitingSession,
    this.passengerName,
    this.passengerPhone,
    this.routeSegments = const [],
    this.encodedOverviewPolyline,
    this.isAirport = false,
    this.flightNumber,
    this.acceptedByAdminId,
    this.acceptedAdminName,
    this.acceptedAtUtc,
    this.isScheduled = false,
    this.dispatchWindowOpensAtUtc,
    this.canMarkEnRoute = false,
    this.attentionState = 'Normal',
  });

  final String id;
  final String referenceCode;
  final String passengerId;
  final String? driverId;
  final String vehicleTypeId;
  final TripStatus status;
  final double quotedFare;
  final String currencyCode;
  final DateTime createdAtUtc;
  final DateTime? scheduledAtUtc;
  final List<TripStopEntity> stops;
  final double? driverLatitude;
  final double? driverLongitude;
  final String? vehicleTypeName;
  final TripCancellationEntity? cancellation;
  final TripCompensationClaimEntity? compensationClaim;
  final TripWaitingSessionEntity? activeWaitingSession;
  final String? passengerName;
  final String? passengerPhone;
  final List<TripRouteSegmentEntity> routeSegments;
  final String? encodedOverviewPolyline;
  final bool isAirport;
  final String? flightNumber;
  final String? acceptedByAdminId;
  final String? acceptedAdminName;
  final DateTime? acceptedAtUtc;
  final bool isScheduled;
  final DateTime? dispatchWindowOpensAtUtc;
  final bool canMarkEnRoute;
  final String attentionState;

  TripStopEntity? get pickup => stops.isEmpty ? null : stops.first;
  TripStopEntity? get dropoff => stops.length < 2 ? null : stops.last;

  String get vehicleLabel {
    final typeName = vehicleTypeName;
    if (typeName != null && typeName.trim().isNotEmpty) return typeName;
    return referenceCode;
  }

  TripEntity copyWithStatus(TripStatus nextStatus) {
    return TripEntity(
      id: id,
      referenceCode: referenceCode,
      passengerId: passengerId,
      driverId: driverId,
      vehicleTypeId: vehicleTypeId,
      status: nextStatus,
      quotedFare: quotedFare,
      currencyCode: currencyCode,
      createdAtUtc: createdAtUtc,
      scheduledAtUtc: scheduledAtUtc,
      stops: stops,
      driverLatitude: driverLatitude,
      driverLongitude: driverLongitude,
      vehicleTypeName: vehicleTypeName,
      cancellation: cancellation,
      compensationClaim: compensationClaim,
      activeWaitingSession: activeWaitingSession,
      passengerName: passengerName,
      passengerPhone: passengerPhone,
      routeSegments: routeSegments,
      encodedOverviewPolyline: encodedOverviewPolyline,
      isAirport: isAirport,
      flightNumber: flightNumber,
      acceptedByAdminId: acceptedByAdminId,
      acceptedAdminName: acceptedAdminName,
      acceptedAtUtc: acceptedAtUtc,
      isScheduled: isScheduled,
      dispatchWindowOpensAtUtc: dispatchWindowOpensAtUtc,
      canMarkEnRoute: canMarkEnRoute,
      attentionState: attentionState,
    );
  }
}

class TripCancellationEntity {
  const TripCancellationEntity({
    required this.actor,
    required this.reason,
    required this.refundPercent,
    required this.refundAmount,
    required this.currencyCode,
    this.note,
  });

  final String actor;
  final String reason;
  final double refundPercent;
  final double refundAmount;
  final String currencyCode;
  final String? note;
}

class TripCompensationClaimEntity {
  const TripCompensationClaimEntity({
    required this.id,
    required this.status,
    required this.requestedAmount,
    required this.currencyCode,
    required this.note,
  });

  final String id;
  final String status;
  final double requestedAmount;
  final String currencyCode;
  final String note;
}

class TripWaitingSessionEntity {
  const TripWaitingSessionEntity({
    required this.id,
    this.minutes,
    this.estimatedFee,
    this.isActive = false,
    this.ratePerMinute = 0,
    this.graceMinutes = 10,
    this.billableMinutes,
  });

  final String id;
  final int? minutes;
  final double? estimatedFee;
  final bool isActive;
  final double ratePerMinute;
  final int graceMinutes;
  final int? billableMinutes;
}

class TripRouteSegmentEntity {
  const TripRouteSegmentEntity({
    required this.distanceMeters,
    required this.durationSeconds,
    required this.encodedPolyline,
    required this.startLatitude,
    required this.startLongitude,
    required this.endLatitude,
    required this.endLongitude,
  });

  final int distanceMeters;
  final int durationSeconds;
  final String encodedPolyline;
  final double startLatitude;
  final double startLongitude;
  final double endLatitude;
  final double endLongitude;
}
