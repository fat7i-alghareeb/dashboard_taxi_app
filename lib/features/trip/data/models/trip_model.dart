class TripStopModel {
  const TripStopModel({
    required this.latitude,
    required this.longitude,
    this.label,
  });

  final double latitude;
  final double longitude;
  final String? label;

  factory TripStopModel.fromJson(Map<String, dynamic> json) {
    return TripStopModel(
      latitude: _readDouble(json, 'latitude'),
      longitude: _readDouble(json, 'longitude'),
      label: (json['label'] ?? json['Label'])?.toString(),
    );
  }
}

class TripModel {
  const TripModel({
    required this.id,
    required this.referenceCode,
    required this.passengerId,
    this.driverId,
    required this.vehicleTypeId,
    required this.status,
    required this.quotedFare,
    required this.currencyCode,
    required this.createdAtUtc,
    this.scheduledAtUtc,
    required this.stops,
    this.driverLatitude,
    this.driverLongitude,
    this.vehicleTypeName,
    this.cancellation,
    this.compensationClaim,
    this.activeWaitingSession,
  });

  final String id;
  final String referenceCode;
  final String passengerId;
  final String? driverId;
  final String vehicleTypeId;
  final String status;
  final double quotedFare;
  final String currencyCode;
  final DateTime createdAtUtc;
  final DateTime? scheduledAtUtc;
  final List<TripStopModel> stops;
  final double? driverLatitude;
  final double? driverLongitude;
  final String? vehicleTypeName;
  final TripCancellationModel? cancellation;
  final TripCompensationClaimModel? compensationClaim;
  final TripWaitingSessionModel? activeWaitingSession;

  factory TripModel.fromJson(Map<String, dynamic> json) {
    final stopsJson =
        (json['stops'] ?? json['Stops']) as List<dynamic>? ?? const [];

    return TripModel(
      id: _readString(json, 'id'),
      referenceCode: _readString(json, 'referenceCode'),
      passengerId: _readString(json, 'passengerId'),
      driverId: _readNullableString(json, 'driverId'),
      vehicleTypeId: _readString(json, 'vehicleTypeId'),
      status: _readString(json, 'status'),
      quotedFare: _readDouble(json, 'quotedFare'),
      currencyCode: _readString(json, 'currencyCode', fallback: 'EUR'),
      createdAtUtc: _readDate(json, 'createdAtUtc') ?? DateTime.now(),
      scheduledAtUtc: _readDate(json, 'scheduledAtUtc'),
      stops: stopsJson
          .whereType<Map>()
          .map((e) => TripStopModel.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
      driverLatitude: _readNullableDouble(json, 'driverLatitude'),
      driverLongitude: _readNullableDouble(json, 'driverLongitude'),
      vehicleTypeName: _readNullableString(json, 'vehicleTypeName'),
      cancellation: _readObject(json, 'cancellation') == null
          ? null
          : TripCancellationModel.fromJson(_readObject(json, 'cancellation')!),
      compensationClaim: _readObject(json, 'compensationClaim') == null
          ? null
          : TripCompensationClaimModel.fromJson(
              _readObject(json, 'compensationClaim')!,
            ),
      activeWaitingSession: _readObject(json, 'activeWaitingSession') == null
          ? null
          : TripWaitingSessionModel.fromJson(
              _readObject(json, 'activeWaitingSession')!,
            ),
    );
  }
}

class TripCancellationModel {
  const TripCancellationModel({
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

  factory TripCancellationModel.fromJson(Map<String, dynamic> json) {
    return TripCancellationModel(
      actor: _readString(json, 'actor'),
      reason: _readString(json, 'reason'),
      refundPercent: _readDouble(json, 'refundPercent'),
      refundAmount: _readDouble(json, 'refundAmount'),
      currencyCode: _readString(json, 'currencyCode', fallback: 'EUR'),
      note: _readNullableString(json, 'note'),
    );
  }
}

class TripCompensationClaimModel {
  const TripCompensationClaimModel({
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

  factory TripCompensationClaimModel.fromJson(Map<String, dynamic> json) {
    return TripCompensationClaimModel(
      id: _readString(json, 'id'),
      status: _readString(json, 'status'),
      requestedAmount: _readDouble(json, 'requestedAmount'),
      currencyCode: _readString(json, 'currencyCode', fallback: 'EUR'),
      note: _readString(json, 'note'),
    );
  }
}

class TripWaitingSessionModel {
  const TripWaitingSessionModel({
    required this.id,
    this.minutes,
    this.estimatedFee,
    this.isActive = false,
  });

  final String id;
  final int? minutes;
  final double? estimatedFee;
  final bool isActive;

  factory TripWaitingSessionModel.fromJson(Map<String, dynamic> json) {
    return TripWaitingSessionModel(
      id: _readString(json, 'id'),
      minutes: _readNullableInt(json, 'minutes'),
      estimatedFee: _readNullableDouble(json, 'estimatedFee'),
      isActive: _readBool(json, 'isActive'),
    );
  }
}

String _readString(
  Map<String, dynamic> json,
  String key, {
  String fallback = '',
}) {
  return (json[key] ?? json[_pascal(key)] ?? fallback).toString();
}

String? _readNullableString(Map<String, dynamic> json, String key) {
  final value = json[key] ?? json[_pascal(key)];
  final text = value?.toString();
  if (text == null || text.trim().isEmpty) return null;
  return text;
}

double _readDouble(Map<String, dynamic> json, String key) {
  return _readNullableDouble(json, key) ?? 0;
}

double? _readNullableDouble(Map<String, dynamic> json, String key) {
  final value = json[key] ?? json[_pascal(key)];
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}

DateTime? _readDate(Map<String, dynamic> json, String key) {
  final value = json[key] ?? json[_pascal(key)];
  if (value is String) return DateTime.tryParse(value);
  return null;
}

Map<String, dynamic>? _readObject(Map<String, dynamic> json, String key) {
  final value = json[key] ?? json[_pascal(key)];
  if (value is Map) return Map<String, dynamic>.from(value);
  return null;
}

int? _readNullableInt(Map<String, dynamic> json, String key) {
  final value = json[key] ?? json[_pascal(key)];
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value);
  return null;
}

bool _readBool(Map<String, dynamic> json, String key) {
  final value = json[key] ?? json[_pascal(key)];
  if (value is bool) return value;
  if (value is String) return value.toLowerCase() == 'true';
  return false;
}

String _pascal(String key) {
  if (key.isEmpty) return key;
  return '${key[0].toUpperCase()}${key.substring(1)}';
}
