import 'package:injectable/injectable.dart';

import '../../../../core/utils/result.dart';
import '../entities/driver_entity.dart';
import '../repositories/driver_repository.dart';

@lazySingleton
class DriverFacade {
  const DriverFacade(this._repository);

  final DriverRepository _repository;

  Future<Result<List<DriverEntity>>> getAllDrivers() {
    return _repository.getAllDrivers();
  }

  Future<Result<void>> updateStatus(int status) {
    return _repository.updateStatus(status);
  }

  Future<Result<void>> updateLocation(double lat, double lng) {
    return _repository.updateLocation(lat, lng);
  }

  Future<Result<DriverEarningsEntity>> getEarnings() {
    return _repository.getEarnings();
  }
}
