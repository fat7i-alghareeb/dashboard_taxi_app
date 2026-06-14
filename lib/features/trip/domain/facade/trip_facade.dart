import 'package:injectable/injectable.dart';

import '../../../../core/utils/result.dart';
import '../entities/trip_entity.dart';
import '../repositories/trip_repository.dart';

@lazySingleton
class TripFacade {
  const TripFacade(this._repository);

  final TripRepository _repository;

  Future<Result<List<TripEntity>>> getAllTrips() {
    return _repository.getAllTrips();
  }

  Future<Result<TripEntity>> getTripById(String tripId) {
    return _repository.getTripById(tripId);
  }

  Future<Result<TripEntity?>> getActiveTrip() {
    return _repository.getActiveTrip();
  }

  Future<Result<void>> markEnRoute(String tripId) {
    return _repository.markEnRoute(tripId);
  }

  Future<Result<void>> markArrived(String tripId) {
    return _repository.markArrived(tripId);
  }

  Future<Result<void>> resendArrived(String tripId) {
    return _repository.resendArrived(tripId);
  }

  Future<Result<void>> startTrip(String tripId) {
    return _repository.startTrip(tripId);
  }

  Future<Result<void>> completeTrip(String tripId) {
    return _repository.completeTrip(tripId);
  }

  Future<Result<void>> completeStop(String tripId, int sequence) {
    return _repository.completeStop(tripId, sequence);
  }

  Future<Result<void>> assignToDriver(String tripId, String driverId) {
    return _repository.assignToDriver(tripId, driverId);
  }

  Future<Result<void>> adminTakeTrip(String tripId) {
    return _repository.adminTakeTrip(tripId);
  }

  Future<Result<void>> adminCancelTrip(String tripId, {String? note}) {
    return _repository.adminCancelTrip(tripId, note: note);
  }

  Future<Result<void>> driverCancelTrip(
    String tripId,
    String reason,
    String? note,
  ) {
    return _repository.driverCancelTrip(tripId, reason, note);
  }
}
