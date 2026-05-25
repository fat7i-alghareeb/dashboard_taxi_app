import 'package:injectable/injectable.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/driver_entity.dart';
import '../../domain/repositories/driver_repository.dart';
import '../datasources/driver_remote_datasource.dart';
import '../mappers/driver_model_mapper.dart';

@LazySingleton(as: DriverRepository)
class DriverRepositoryImpl implements DriverRepository {
  const DriverRepositoryImpl(this._remote);

  final DriverRemoteDataSource _remote;

  @override
  Future<Result<List<DriverEntity>>> getAllDrivers() {
    return runAsResult(() async {
      final models = await _remote.getAllDrivers();
      return models.map((e) => e.toEntity).toList();
    });
  }

  @override
  Future<Result<void>> updateStatus(int status) {
    return runAsResult(() async {
      await _remote.updateStatus(status);
    });
  }

  @override
  Future<Result<void>> updateLocation(double lat, double lng) {
    return runAsResult(() async {
      await _remote.updateLocation(lat, lng);
    });
  }

  @override
  Future<Result<DriverEarningsEntity>> getEarnings() {
    return runAsResult(() async {
      final model = await _remote.getEarnings();
      return model.toEntity;
    });
  }
}
