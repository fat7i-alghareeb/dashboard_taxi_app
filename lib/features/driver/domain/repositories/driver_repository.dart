import '../../../../core/utils/result.dart';
import '../entities/driver_entity.dart';

abstract class DriverRepository {
  Future<Result<List<DriverEntity>>> getAllDrivers();
  Future<Result<void>> updateStatus(int status);
  Future<Result<void>> updateLocation(double lat, double lng);
  Future<Result<DriverEarningsEntity>> getEarnings();
}
