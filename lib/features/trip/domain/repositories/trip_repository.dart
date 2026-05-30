import '../../../../core/utils/result.dart';
import '../entities/trip_entity.dart';

abstract class TripRepository {
  Future<Result<List<TripEntity>>> getAllTrips();
  Future<Result<TripEntity>> getTripById(String tripId);
  Future<Result<void>> markEnRoute(String tripId);
  Future<Result<void>> markArrived(String tripId);
  Future<Result<void>> resendArrived(String tripId);
  Future<Result<void>> startTrip(String tripId);
  Future<Result<void>> completeTrip(String tripId);
  Future<Result<void>> completeStop(String tripId, int sequence);
  Future<Result<void>> assignToDriver(String tripId, String driverId);
  Future<Result<void>> adminTakeTrip(String tripId);
  Future<Result<void>> adminCancelTrip(String tripId, {String? note});
  Future<Result<void>> driverCancelTrip(
    String tripId,
    String reason,
    String? note,
  );
}
