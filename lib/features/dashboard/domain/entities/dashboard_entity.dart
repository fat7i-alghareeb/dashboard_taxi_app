class DashboardEntity {
  const DashboardEntity({
    required this.totalTrips,
    required this.activeTrips,
    required this.completedTrips,
    required this.onlineDrivers,
    required this.pendingKycDrivers,
    required this.totalDrivers,
    required this.vehicleTypes,
    required this.recentTrips,
    required this.pendingTrips,
    required this.pendingDrivers,
    required this.assignableDrivers,
    required this.auditLogs,
  });

  final int totalTrips;
  final int activeTrips;
  final int completedTrips;
  final int onlineDrivers;
  final int pendingKycDrivers;
  final int totalDrivers;
  final List<DashboardVehicleTypeEntity> vehicleTypes;
  final List<DashboardTripEntity> recentTrips;
  final List<DashboardTripEntity> pendingTrips;
  final List<DashboardDriverEntity> pendingDrivers;
  final List<DashboardDriverEntity> assignableDrivers;
  final List<DashboardAuditLogEntity> auditLogs;
}

class DashboardVehicleTypeEntity {
  const DashboardVehicleTypeEntity({
    required this.id,
    required this.code,
    required this.name,
    required this.capacity,
    required this.ratePerKm,
    required this.ratePerMin,
    required this.minFare,
    required this.sortOrder,
    required this.isActive,
  });

  final String id;
  final String code;
  final String name;
  final int capacity;
  final num ratePerKm;
  final num ratePerMin;
  final num minFare;
  final int sortOrder;
  final bool isActive;
}

class DashboardDriverEntity {
  const DashboardDriverEntity({
    required this.id,
    required this.userId,
    required this.fullName,
    required this.licenseNumber,
    required this.status,
    required this.approvalStatus,
    this.vehicleTypeId,
  });

  final String id;
  final String userId;
  final String fullName;
  final String licenseNumber;
  final String status;
  final String approvalStatus;
  final String? vehicleTypeId;
}

class DashboardUserEntity {
  const DashboardUserEntity({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.role,
    required this.isActive,
    required this.createdAt,
  });

  final String id;
  final String name;
  final String phone;
  final String? email;
  final String role;
  final bool isActive;
  final DateTime? createdAt;
}

class DashboardSystemConfigEntity {
  const DashboardSystemConfigEntity({
    required this.tripDiscountPercent,
    required this.currencyCode,
    required this.stripeEnabled,
    required this.stripePublishableKey,
  });

  final num tripDiscountPercent;
  final String currencyCode;
  final bool stripeEnabled;
  final String stripePublishableKey;
}

class DashboardAdminProfileEntity {
  const DashboardAdminProfileEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.phone1,
    required this.phone2,
    required this.isActive,
  });

  final String id;
  final String name;
  final String email;
  final String? phone1;
  final String? phone2;
  final bool isActive;
}

/// A page of admin trips plus the total count, for infinite-scroll paging.
class DashboardTripsPage {
  const DashboardTripsPage({required this.items, required this.totalCount});

  final List<DashboardTripEntity> items;
  final int totalCount;
}

class DashboardTripEntity {
  const DashboardTripEntity({
    required this.id,
    required this.referenceCode,
    required this.status,
    required this.vehicleTypeId,
    required this.fareLabel,
    required this.createdAt,
    required this.pickupLatitude,
    required this.pickupLongitude,
    required this.pickupLabel,
    required this.dropoffLabel,
    this.stops = const <DashboardTripStopEntity>[],
    this.scheduledAt,
    this.assignedAt,
    this.arrivedAt,
    this.startedAt,
    this.completedAt,
    this.passengerNote,
    this.isAirport = false,
    this.flightNumber,
    this.acceptedByAdminId,
    this.acceptedAdminName,
    this.acceptedAt,
    this.dispatchWindowOpensAt,
    this.canMarkEnRoute = false,
    this.attentionState = 'Normal',
    this.recordingCount = 0,
  });

  final String id;
  final String referenceCode;
  final String status;
  final String vehicleTypeId;
  final String fareLabel;
  final int recordingCount;
  final DateTime? createdAt;
  final double? pickupLatitude;
  final double? pickupLongitude;
  final String? pickupLabel;
  final String? dropoffLabel;
  // Full stop list in canonical (sequence-sorted) order. Carries the
  // intermediate waypoints that pickupLabel/dropoffLabel do not expose, so the
  // trips-tab card can render the entire route, not just the endpoints.
  final List<DashboardTripStopEntity> stops;
  final DateTime? scheduledAt;
  final DateTime? assignedAt;
  final DateTime? arrivedAt;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final String? passengerNote;
  final bool isAirport;
  final String? flightNumber;
  final String? acceptedByAdminId;
  final String? acceptedAdminName;
  final DateTime? acceptedAt;
  final DateTime? dispatchWindowOpensAt;
  final bool canMarkEnRoute;
  final String attentionState;

  bool get hasPickupLocation =>
      pickupLatitude != null && pickupLongitude != null;

  bool get isScheduled => scheduledAt != null;

  DashboardTripEntity copyWithStatus(String newStatus) {
    return DashboardTripEntity(
      id: id,
      referenceCode: referenceCode,
      status: newStatus,
      vehicleTypeId: vehicleTypeId,
      fareLabel: fareLabel,
      createdAt: createdAt,
      pickupLatitude: pickupLatitude,
      pickupLongitude: pickupLongitude,
      pickupLabel: pickupLabel,
      dropoffLabel: dropoffLabel,
      stops: stops,
      scheduledAt: scheduledAt,
      assignedAt: assignedAt,
      arrivedAt: arrivedAt,
      startedAt: startedAt,
      completedAt: completedAt,
      passengerNote: passengerNote,
      isAirport: isAirport,
      flightNumber: flightNumber,
      acceptedByAdminId: acceptedByAdminId,
      acceptedAdminName: acceptedAdminName,
      acceptedAt: acceptedAt,
      dispatchWindowOpensAt: dispatchWindowOpensAt,
      canMarkEnRoute: canMarkEnRoute,
      attentionState: attentionState,
      recordingCount: recordingCount,
    );
  }
}

class DashboardTripDetailsEntity {
  const DashboardTripDetailsEntity({
    required this.id,
    required this.referenceCode,
    required this.passengerName,
    required this.passengerPhone,
    required this.driverName,
    required this.driverPhone,
    required this.vehicleTypeName,
    required this.status,
    required this.fareLabel,
    required this.createdAt,
    required this.scheduledAt,
    required this.assignedAt,
    required this.arrivedAt,
    required this.startedAt,
    required this.completedAt,
    required this.stops,
    this.passengerNote,
    this.cancellation,
    this.waitingFeeTotal = 0,
    this.waitingBillableMinutes = 0,
    this.currencyCode = 'EUR',
    this.isAirport = false,
    this.flightNumber,
    this.acceptedByAdminId,
    this.acceptedAdminName,
    this.acceptedAt,
    this.dispatchWindowOpensAt,
    this.canMarkEnRoute = false,
    this.attentionState = 'Normal',
    this.passengerCount = 1,
    this.bagCount = 0,
  });

  final String id;
  final String referenceCode;
  final String passengerName;
  final String passengerPhone;
  final String? driverName;
  final String? driverPhone;
  final String vehicleTypeName;
  final String status;
  final String fareLabel;
  final DateTime? createdAt;
  final DateTime? scheduledAt;
  final DateTime? assignedAt;
  final DateTime? arrivedAt;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final List<DashboardTripStopEntity> stops;
  final String? passengerNote;
  final DashboardCancellationEntity? cancellation;
  final double waitingFeeTotal;
  final int waitingBillableMinutes;
  final String currencyCode;
  final bool isAirport;
  final String? flightNumber;
  final String? acceptedByAdminId;
  final String? acceptedAdminName;
  final DateTime? acceptedAt;
  final DateTime? dispatchWindowOpensAt;
  final bool canMarkEnRoute;
  final String attentionState;
  final int passengerCount;
  final int bagCount;

  String? get waitingFeeLabel => waitingFeeTotal > 0
      ? '${waitingFeeTotal.toStringAsFixed(2)} $currencyCode'
            '${waitingBillableMinutes > 0 ? ' ($waitingBillableMinutes min)' : ''}'
      : null;

  DashboardTripStopEntity? get pickup => stops.firstOrNull;
  DashboardTripStopEntity? get dropoff => stops.length > 1 ? stops.last : null;
}

class DashboardCancellationEntity {
  const DashboardCancellationEntity({
    required this.actor,
    required this.reason,
    required this.refundPercent,
    required this.refundAmount,
    required this.currencyCode,
    this.cancellationFeeAmount = 0,
    this.note,
    this.createdAt,
  });

  final String actor;
  final String reason;
  final double refundPercent;
  final double refundAmount;
  final String currencyCode;

  /// Flat fee withheld from the fare ("annuleringskosten"), 0 when none applied.
  final double cancellationFeeAmount;
  final String? note;
  final DateTime? createdAt;

  /// When a fee was charged the percent is always 100 and would read as a
  /// contradiction next to the smaller amount, so the deduction is shown instead —
  /// this is the line an admin quotes back to a caller asking "where is my money".
  String get refundLabel => cancellationFeeAmount > 0
      ? '${refundAmount.toStringAsFixed(2)} $currencyCode '
            '(-${cancellationFeeAmount.toStringAsFixed(2)} $currencyCode)'
      : '${refundAmount.toStringAsFixed(2)} $currencyCode '
            '(${refundPercent.toStringAsFixed(0)}%)';
}

class DashboardTripStopEntity {
  const DashboardTripStopEntity({
    required this.latitude,
    required this.longitude,
    required this.label,
    this.sequence = 0,
  });

  final double latitude;
  final double longitude;
  final String? label;
  final int sequence;

  String get displayLabel {
    final value = label;
    if (value == null || value.trim().isEmpty) {
      return '${latitude.toStringAsFixed(5)}, ${longitude.toStringAsFixed(5)}';
    }
    return value;
  }
}

class DashboardAuditLogEntity {
  const DashboardAuditLogEntity({
    required this.id,
    required this.action,
    required this.entityName,
    required this.actorName,
    required this.createdAt,
  });

  final String id;
  final String action;
  final String entityName;
  final String actorName;
  final DateTime? createdAt;
}

class DashboardDriverDocumentEntity {
  const DashboardDriverDocumentEntity({
    required this.id,
    required this.type,
    required this.fileUrl,
    required this.status,
    this.reviewNotes,
    this.reviewedAt,
  });

  final String id;
  final String type;
  final String fileUrl;
  final String status;
  final String? reviewNotes;
  final DateTime? reviewedAt;
}

class DashboardDriverLocationEntity {
  const DashboardDriverLocationEntity({
    required this.driverId,
    required this.name,
    required this.phone,
    required this.status,
    required this.approvalStatus,
    required this.latitude,
    required this.longitude,
    required this.locationUpdatedAt,
    required this.vehicleTypeId,
    required this.vehicleTypeName,
  });

  final String driverId;
  final String name;
  final String phone;
  final String status;
  final String approvalStatus;
  final double? latitude;
  final double? longitude;
  final DateTime? locationUpdatedAt;
  final String? vehicleTypeId;
  final String? vehicleTypeName;

  bool get hasLocation => latitude != null && longitude != null;
  bool get isOnline => status.toLowerCase() == 'online';
  bool get isBusy => status.toLowerCase() == 'busy';

  DashboardDriverLocationEntity copyWithLocation({
    required double latitude,
    required double longitude,
  }) {
    return DashboardDriverLocationEntity(
      driverId: driverId,
      name: name,
      phone: phone,
      status: status,
      approvalStatus: approvalStatus,
      latitude: latitude,
      longitude: longitude,
      locationUpdatedAt: DateTime.now(),
      vehicleTypeId: vehicleTypeId,
      vehicleTypeName: vehicleTypeName,
    );
  }
}

class DashboardTripPaymentLineEntity {
  const DashboardTripPaymentLineEntity({
    required this.kind,
    required this.method,
    required this.amount,
    required this.status,
    this.processedAt,
    this.stripePaymentMethodType,
  });

  final String kind;
  final String method;
  final double amount;
  final String status;
  final DateTime? processedAt;
  final String? stripePaymentMethodType;
}

class DashboardTripRefundLineEntity {
  const DashboardTripRefundLineEntity({
    required this.amount,
    required this.status,
    required this.sourceType,
    this.requestedAt,
    this.completedAt,
  });

  final double amount;
  final String status;
  final String sourceType;
  final DateTime? requestedAt;
  final DateTime? completedAt;
}

/// Read-only per-trip money breakdown (fare + fees, wallet vs card vs unpaid,
/// and refunds) shown to admins. Mirrors the backend TripFinancialsDto.
class DashboardTripFinancialsEntity {
  const DashboardTripFinancialsEntity({
    required this.currencyCode,
    required this.fareAmount,
    required this.waitingFeeAmount,
    required this.totalCharged,
    required this.walletPaidAmount,
    required this.cardPaidAmount,
    required this.totalPaidAmount,
    required this.unpaidAmount,
    required this.refundedAmount,
    required this.payments,
    required this.refunds,
  });

  final String currencyCode;
  final double fareAmount;
  final double waitingFeeAmount;
  final double totalCharged;
  final double walletPaidAmount;
  final double cardPaidAmount;
  final double totalPaidAmount;
  final double unpaidAmount;
  final double refundedAmount;
  final List<DashboardTripPaymentLineEntity> payments;
  final List<DashboardTripRefundLineEntity> refunds;

  bool get hasUnpaid => unpaidAmount > 0;
  bool get hasRefund => refundedAmount > 0;
}

class DashboardWalletTransactionEntity {
  const DashboardWalletTransactionEntity({
    required this.id,
    required this.type,
    required this.direction,
    required this.amount,
    required this.currencyCode,
    required this.status,
    this.balanceAfter,
    this.description,
    this.createdAt,
    this.completedAt,
  });

  final String id;
  final String type;
  final String direction;
  final double amount;
  final String currencyCode;
  final String status;
  final double? balanceAfter;
  final String? description;
  final DateTime? createdAt;
  final DateTime? completedAt;

  bool get isCredit => direction.toLowerCase() == 'credit';
}

/// Read-only admin view of a passenger's wallet: balance + recent ledger.
class DashboardUserWalletEntity {
  const DashboardUserWalletEntity({
    required this.userId,
    required this.hasAccount,
    required this.balance,
    required this.currencyCode,
    required this.transactions,
  });

  final String userId;
  final bool hasAccount;
  final double balance;
  final String currencyCode;
  final List<DashboardWalletTransactionEntity> transactions;
}
