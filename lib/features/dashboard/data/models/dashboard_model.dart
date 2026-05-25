class DashboardModel {
  const DashboardModel({
    required this.drivers,
    required this.trips,
    required this.auditLogs,
    required this.vehicleTypes,
  });

  final List<DashboardDriverModel> drivers;
  final List<DashboardTripModel> trips;
  final List<DashboardAuditLogModel> auditLogs;
  final List<DashboardVehicleTypeModel> vehicleTypes;
}

class DashboardDriverModel {
  const DashboardDriverModel({
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

  factory DashboardDriverModel.fromJson(Map<String, dynamic> json) {
    return DashboardDriverModel(
      id: _readString(json, 'id'),
      userId: _readString(json, 'userId'),
      fullName: _readString(
        json,
        'fullName',
        fallback: _readString(json, 'name'),
      ),
      licenseNumber: _readString(json, 'licenseNumber'),
      status: _readString(json, 'status'),
      approvalStatus: _readString(json, 'approvalStatus'),
      vehicleTypeId: _readNullableString(json, 'vehicleTypeId'),
    );
  }
}

class DashboardTripModel {
  const DashboardTripModel({
    required this.id,
    required this.referenceCode,
    required this.status,
    required this.vehicleTypeId,
    required this.quotedFare,
    required this.currencyCode,
    required this.createdAt,
    required this.stops,
  });

  final String id;
  final String referenceCode;
  final String status;
  final String vehicleTypeId;
  final num quotedFare;
  final String currencyCode;
  final DateTime? createdAt;
  final List<DashboardTripStopModel> stops;

  factory DashboardTripModel.fromJson(Map<String, dynamic> json) {
    return DashboardTripModel(
      id: _readString(json, 'id'),
      referenceCode: _readString(json, 'referenceCode'),
      status: _readString(json, 'status'),
      vehicleTypeId: _readString(json, 'vehicleTypeId'),
      quotedFare: json['quotedFare'] as num? ?? json['QuotedFare'] as num? ?? 0,
      currencyCode: _readString(json, 'currencyCode', fallback: 'EUR'),
      createdAt: DateTime.tryParse(_readString(json, 'createdAtUtc')),
      stops: _readList(
        json,
        'stops',
      ).map((e) => DashboardTripStopModel.fromJson(e)).toList(),
    );
  }
}

class DashboardTripStopModel {
  const DashboardTripStopModel({
    required this.latitude,
    required this.longitude,
    required this.label,
  });

  final double latitude;
  final double longitude;
  final String? label;

  factory DashboardTripStopModel.fromJson(Map<String, dynamic> json) {
    return DashboardTripStopModel(
      latitude: _readNullableDouble(json, 'latitude') ?? 0,
      longitude: _readNullableDouble(json, 'longitude') ?? 0,
      label: _readNullableString(json, 'label'),
    );
  }
}

class DashboardTripDetailsModel {
  const DashboardTripDetailsModel({
    required this.id,
    required this.referenceCode,
    required this.passengerName,
    required this.passengerPhone,
    required this.driverName,
    required this.driverPhone,
    required this.vehicleTypeName,
    required this.status,
    required this.fare,
    required this.currencyCode,
    required this.createdAt,
    required this.scheduledAt,
    required this.assignedAt,
    required this.arrivedAt,
    required this.startedAt,
    required this.completedAt,
    required this.stops,
  });

  final String id;
  final String referenceCode;
  final String passengerName;
  final String passengerPhone;
  final String? driverName;
  final String? driverPhone;
  final String vehicleTypeName;
  final String status;
  final num fare;
  final String currencyCode;
  final DateTime? createdAt;
  final DateTime? scheduledAt;
  final DateTime? assignedAt;
  final DateTime? arrivedAt;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final List<DashboardTripStopModel> stops;

  factory DashboardTripDetailsModel.fromJson(Map<String, dynamic> json) {
    return DashboardTripDetailsModel(
      id: _readString(json, 'tripId', fallback: _readString(json, 'id')),
      referenceCode: _readString(json, 'referenceCode'),
      passengerName: _readString(json, 'passengerName'),
      passengerPhone: _readString(json, 'passengerPhone'),
      driverName: _readNullableString(json, 'driverName'),
      driverPhone: _readNullableString(json, 'driverPhone'),
      vehicleTypeName: _readString(json, 'vehicleTypeName'),
      status: _readString(json, 'status'),
      fare: json['fare'] as num? ?? json['Fare'] as num? ?? 0,
      currencyCode: _readString(json, 'currencyCode', fallback: 'EUR'),
      createdAt: DateTime.tryParse(_readString(json, 'createdAtUtc')),
      scheduledAt: DateTime.tryParse(_readString(json, 'scheduledAtUtc')),
      assignedAt: DateTime.tryParse(_readString(json, 'assignedAtUtc')),
      arrivedAt: DateTime.tryParse(_readString(json, 'arrivedAtUtc')),
      startedAt: DateTime.tryParse(_readString(json, 'startedAtUtc')),
      completedAt: DateTime.tryParse(_readString(json, 'completedAtUtc')),
      stops: _readList(
        json,
        'stops',
      ).map((e) => DashboardTripStopModel.fromJson(e)).toList(),
    );
  }
}

class DashboardAuditLogModel {
  const DashboardAuditLogModel({
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

  factory DashboardAuditLogModel.fromJson(Map<String, dynamic> json) {
    return DashboardAuditLogModel(
      id: _readString(json, 'id'),
      action: _readString(json, 'action'),
      entityName: _readString(json, 'entityName'),
      actorName: _readString(
        json,
        'userName',
        fallback: _readString(json, 'userId'),
      ),
      createdAt: DateTime.tryParse(_readString(json, 'createdAtUtc')),
    );
  }
}

class DashboardDriverDocumentModel {
  const DashboardDriverDocumentModel({
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

  factory DashboardDriverDocumentModel.fromJson(Map<String, dynamic> json) {
    return DashboardDriverDocumentModel(
      id: _readString(json, 'id'),
      type: _readString(json, 'type'),
      fileUrl: _readString(json, 'fileUrl'),
      status: _readString(json, 'status'),
      reviewNotes: _readNullableString(json, 'reviewNotes'),
      reviewedAt: DateTime.tryParse(_readString(json, 'reviewedAtUtc')),
    );
  }
}

class DashboardDriverLocationModel {
  const DashboardDriverLocationModel({
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

  factory DashboardDriverLocationModel.fromJson(Map<String, dynamic> json) {
    return DashboardDriverLocationModel(
      driverId: _readString(
        json,
        'driverId',
        fallback: _readString(json, 'id'),
      ),
      name: _readString(json, 'name', fallback: _readString(json, 'fullName')),
      phone: _readString(json, 'phone'),
      status: _readString(json, 'status'),
      approvalStatus: _readString(json, 'approvalStatus'),
      latitude: _readNullableDouble(json, 'latitude'),
      longitude: _readNullableDouble(json, 'longitude'),
      locationUpdatedAt: DateTime.tryParse(
        _readString(json, 'locationUpdatedAt'),
      ),
      vehicleTypeId: _readNullableString(json, 'vehicleTypeId'),
      vehicleTypeName: _readNullableString(json, 'vehicleTypeName'),
    );
  }
}

class DashboardVehicleTypeModel {
  const DashboardVehicleTypeModel({
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

  factory DashboardVehicleTypeModel.fromJson(Map<String, dynamic> json) {
    return DashboardVehicleTypeModel(
      id: _readString(json, 'id'),
      code: _readString(json, 'code'),
      name: _readString(json, 'name'),
      capacity: json['capacity'] as int? ?? json['Capacity'] as int? ?? 0,
      ratePerKm: json['ratePerKm'] as num? ?? json['RatePerKm'] as num? ?? 0,
      ratePerMin: json['ratePerMin'] as num? ?? json['RatePerMin'] as num? ?? 0,
      minFare: json['minFare'] as num? ?? json['MinFare'] as num? ?? 0,
      sortOrder: json['sortOrder'] as int? ?? json['SortOrder'] as int? ?? 0,
      isActive: json['isActive'] as bool? ?? json['IsActive'] as bool? ?? true,
    );
  }
}

class DashboardUserModel {
  const DashboardUserModel({
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

  factory DashboardUserModel.fromJson(Map<String, dynamic> json) {
    return DashboardUserModel(
      id: _readString(json, 'id'),
      name: _readString(json, 'name'),
      phone: _readString(json, 'phone'),
      email: _readNullableString(json, 'email'),
      role: _readString(json, 'role'),
      isActive: json['isActive'] as bool? ?? json['IsActive'] as bool? ?? true,
      createdAt: DateTime.tryParse(_readString(json, 'createdAtUtc')),
    );
  }
}

class DashboardSystemConfigModel {
  const DashboardSystemConfigModel({
    required this.tripDiscountPercent,
    required this.currencyCode,
    required this.stripeEnabled,
    required this.stripePublishableKey,
  });

  final num tripDiscountPercent;
  final String currencyCode;
  final bool stripeEnabled;
  final String stripePublishableKey;

  factory DashboardSystemConfigModel.fromPayloads({
    required Map<String, dynamic> discount,
    required Map<String, dynamic> currency,
    required Map<String, dynamic> client,
  }) {
    return DashboardSystemConfigModel(
      tripDiscountPercent:
          discount['discountPercent'] as num? ??
          discount['DiscountPercent'] as num? ??
          0,
      currencyCode: _readString(currency, 'currencyCode', fallback: 'EUR'),
      stripeEnabled:
          client['stripeEnabled'] as bool? ??
          client['StripeEnabled'] as bool? ??
          false,
      stripePublishableKey: _readString(client, 'stripePublishableKey'),
    );
  }
}

class DashboardAdminOperationsModel {
  const DashboardAdminOperationsModel({
    required this.drivers,
    required this.vehicleTypes,
    required this.users,
    required this.auditLogs,
    required this.config,
  });

  final List<DashboardDriverModel> drivers;
  final List<DashboardVehicleTypeModel> vehicleTypes;
  final List<DashboardUserModel> users;
  final List<DashboardAuditLogModel> auditLogs;
  final DashboardSystemConfigModel config;
}

String _readString(
  Map<String, dynamic> json,
  String key, {
  String fallback = '',
}) {
  final pascalKey = key.isEmpty
      ? key
      : '${key[0].toUpperCase()}${key.substring(1)}';
  final value = json[key] ?? json[pascalKey];
  return value?.toString() ?? fallback;
}

String? _readNullableString(Map<String, dynamic> json, String key) {
  final value = _readString(json, key);
  return value.isEmpty ? null : value;
}

double? _readNullableDouble(Map<String, dynamic> json, String key) {
  final pascalKey = key.isEmpty
      ? key
      : '${key[0].toUpperCase()}${key.substring(1)}';
  final value = json[key] ?? json[pascalKey];
  return switch (value) {
    final num number => number.toDouble(),
    final String text => double.tryParse(text),
    _ => null,
  };
}

List<Map<String, dynamic>> _readList(Map<String, dynamic> json, String key) {
  final pascalKey = key.isEmpty
      ? key
      : '${key[0].toUpperCase()}${key.substring(1)}';
  final value = json[key] ?? json[pascalKey];
  if (value is! List<dynamic>) return const <Map<String, dynamic>>[];
  return value.whereType<Map<String, dynamic>>().toList();
}
