class DriverModel {
  const DriverModel({required this.id});

  final String id;

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(id: json["id"]);
  }
}

class DriverEarningsModel {
  const DriverEarningsModel({
    required this.totalTrips,
    required this.totalEarnings,
    required this.currencyCode,
    required this.trips,
  });

  final int totalTrips;
  final num totalEarnings;
  final String currencyCode;
  final List<DriverTripEarningModel> trips;

  factory DriverEarningsModel.fromJson(Map<String, dynamic> json) {
    return DriverEarningsModel(
      totalTrips: json['totalTrips'] as int? ?? json['TotalTrips'] as int? ?? 0,
      totalEarnings:
          json['totalEarnings'] as num? ?? json['TotalEarnings'] as num? ?? 0,
      currencyCode: _readString(json, 'currencyCode', fallback: 'EUR'),
      trips: _readList(
        json,
        'trips',
      ).map((e) => DriverTripEarningModel.fromJson(e)).toList(),
    );
  }
}

class DriverTripEarningModel {
  const DriverTripEarningModel({
    required this.tripId,
    required this.referenceCode,
    required this.fare,
    required this.currencyCode,
    required this.completedAt,
  });

  final String tripId;
  final String referenceCode;
  final num fare;
  final String currencyCode;
  final DateTime? completedAt;

  factory DriverTripEarningModel.fromJson(Map<String, dynamic> json) {
    return DriverTripEarningModel(
      tripId: _readString(json, 'tripId'),
      referenceCode: _readString(json, 'referenceCode'),
      fare: json['fare'] as num? ?? json['Fare'] as num? ?? 0,
      currencyCode: _readString(json, 'currencyCode', fallback: 'EUR'),
      completedAt: DateTime.tryParse(_readString(json, 'completedAt')),
    );
  }
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

List<Map<String, dynamic>> _readList(Map<String, dynamic> json, String key) {
  final pascalKey = key.isEmpty
      ? key
      : '${key[0].toUpperCase()}${key.substring(1)}';
  final value = json[key] ?? json[pascalKey];
  if (value is! List<dynamic>) return const <Map<String, dynamic>>[];
  return value.whereType<Map<String, dynamic>>().toList();
}
