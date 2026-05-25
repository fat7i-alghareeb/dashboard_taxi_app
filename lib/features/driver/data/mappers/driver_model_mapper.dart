import '../../domain/entities/driver_entity.dart';
import '../models/driver_model.dart';

extension DriverModelMapper on DriverModel {
  DriverEntity get toEntity => DriverEntity(id: id);
}

extension DriverEarningsModelMapper on DriverEarningsModel {
  DriverEarningsEntity get toEntity {
    return DriverEarningsEntity(
      totalTrips: totalTrips,
      totalEarnings: totalEarnings,
      currencyCode: currencyCode,
      trips: trips.map((trip) => trip.toEntity).toList(),
    );
  }
}

extension DriverTripEarningModelMapper on DriverTripEarningModel {
  DriverTripEarningEntity get toEntity {
    return DriverTripEarningEntity(
      tripId: tripId,
      referenceCode: referenceCode,
      fare: fare,
      currencyCode: currencyCode,
      completedAt: completedAt,
    );
  }
}
