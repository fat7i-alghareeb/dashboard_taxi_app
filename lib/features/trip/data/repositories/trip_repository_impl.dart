import 'package:injectable/injectable.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/trip_entity.dart';
import '../../domain/repositories/trip_repository.dart';
import '../datasources/trip_remote_datasource.dart';
import '../mappers/trip_model_mapper.dart';

@LazySingleton(as: TripRepository)
class TripRepositoryImpl implements TripRepository {
  const TripRepositoryImpl(this._remote);

  final TripRemoteDataSource _remote;

  @override
  Future<Result<List<TripEntity>>> getAllTrips() {
    return runAsResult(() async {
      final models = await _remote.getAllTrips();
      return models.map((e) => e.toEntity).toList();
    });
  }

  @override
  Future<Result<TripEntity>> getTripById(String tripId) {
    return runAsResult(() async {
      final model = await _remote.getTripById(tripId);
      return model.toEntity;
    });
  }

  @override
  Future<Result<TripEntity?>> getActiveTrip() {
    return runAsResult(() async {
      final model = await _remote.getActiveTrip();
      return model?.toEntity;
    });
  }

  @override
  Future<Result<void>> markEnRoute(String tripId, {bool forceOverride = false}) {
    return runAsResult(() => _remote.markEnRoute(tripId, forceOverride: forceOverride));
  }

  @override
  Future<Result<void>> markArrived(String tripId) {
    return runAsResult(() => _remote.markArrived(tripId));
  }

  @override
  Future<Result<void>> resendArrived(String tripId) {
    return runAsResult(() => _remote.resendArrived(tripId));
  }

  @override
  Future<Result<void>> startTrip(String tripId, {bool forceOverride = false}) {
    return runAsResult(() => _remote.startTrip(tripId, forceOverride: forceOverride));
  }

  @override
  Future<Result<void>> completeTrip(String tripId) {
    return runAsResult(() => _remote.completeTrip(tripId));
  }

  @override
  Future<Result<void>> completeStop(String tripId, int sequence) {
    return runAsResult(() => _remote.completeStop(tripId, sequence));
  }

  @override
  Future<Result<void>> assignToDriver(String tripId, String driverId) {
    return runAsResult(() => _remote.assignToDriver(tripId, driverId));
  }

  @override
  Future<Result<void>> adminTakeTrip(String tripId) {
    return runAsResult(() => _remote.adminTakeTrip(tripId));
  }

  @override
  Future<Result<void>> adminCancelTrip(String tripId, {String? note}) {
    return runAsResult(() => _remote.adminCancelTrip(tripId, note: note));
  }

  @override
  Future<Result<void>> driverCancelTrip(
    String tripId,
    String reason,
    String? note,
  ) {
    return runAsResult(() => _remote.driverCancelTrip(tripId, reason, note));
  }
}
