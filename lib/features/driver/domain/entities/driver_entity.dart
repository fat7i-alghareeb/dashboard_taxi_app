class DriverEntity {
  const DriverEntity({required this.id});

  final String id;
}

class DriverEarningsEntity {
  const DriverEarningsEntity({
    required this.totalTrips,
    required this.totalEarnings,
    required this.currencyCode,
    required this.trips,
  });

  final int totalTrips;
  final num totalEarnings;
  final String currencyCode;
  final List<DriverTripEarningEntity> trips;

  String get totalEarningsLabel =>
      '${totalEarnings.toStringAsFixed(2)} $currencyCode';
}

class DriverTripEarningEntity {
  const DriverTripEarningEntity({
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
}
