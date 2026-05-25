import '../../../../core/utils/result.dart';
import '../entities/trip_entity.dart';

abstract class TripRepository {
  Future<Result<List<TripEntity>>> getAllTrips();
  Future<Result<TripEntity>> getTripById(String tripId);
  Future<Result<void>> markEnRoute(String tripId);
  Future<Result<void>> markArrived(String tripId);
  Future<Result<void>> startTrip(String tripId);
  Future<Result<void>> completeTrip(String tripId);
  Future<Result<void>> driverCancelTrip(
    String tripId,
    String reason,
    String? note,
  );
  Future<Result<TripWaitingSessionEntity>> startWaiting(String tripId);
  Future<Result<TripWaitingSessionEntity>> stopWaiting(String tripId);
}
