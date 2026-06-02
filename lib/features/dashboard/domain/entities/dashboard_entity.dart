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
  });

  final String id;
  final String referenceCode;
  final String status;
  final String vehicleTypeId;
  final String fareLabel;
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

  bool get hasPickupLocation =>
      pickupLatitude != null && pickupLongitude != null;

  bool get isScheduled =>
      status.toLowerCase() == 'scheduled' && scheduledAt != null;

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

  DashboardTripStopEntity? get pickup => stops.firstOrNull;
  DashboardTripStopEntity? get dropoff => stops.length > 1 ? stops.last : null;
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
