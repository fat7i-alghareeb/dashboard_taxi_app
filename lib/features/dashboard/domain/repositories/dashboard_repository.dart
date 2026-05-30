import '../../../../core/utils/result.dart';
import '../entities/dashboard_entity.dart';

abstract class DashboardRepository {
  Future<Result<DashboardEntity>> getOverview();

  Future<Result<List<DashboardDriverDocumentEntity>>> getDriverDocuments(
    String driverId,
  );

  Future<Result<List<DashboardDriverLocationEntity>>> getDriverLocations();

  Future<Result<List<DashboardTripEntity>>> getAdminTrips({String? status});

  Future<Result<DashboardTripDetailsEntity>> getTripDetails(String tripId);

  Future<Result<DashboardAdminProfileEntity?>> getAdminProfile();

  Future<Result<DashboardSystemConfigEntity>> getAdminConfig();

  Future<Result<List<DashboardDriverEntity>>> getAdminDrivers();

  Future<Result<List<DashboardVehicleTypeEntity>>> getAdminVehicleTypes();

  Future<Result<List<DashboardUserEntity>>> getAdminUsers();

  Future<Result<List<DashboardAuditLogEntity>>> getAdminAuditLogs();


  Future<Result<void>> suspendDriver(String driverId);

  Future<Result<void>> assignDriverVehicleType({
    required String driverId,
    required String vehicleTypeId,
  });

  Future<Result<void>> updateVehicleType(DashboardVehicleTypeEntity vehicleType);

  Future<Result<void>> createVehicleType({
    required String code,
    required String name,
    required int capacity,
    required num ratePerKm,
    required num ratePerMin,
    required num minFare,
    required int sortOrder,
  });

  Future<Result<void>> removeVehicleType(String vehicleTypeId);

  Future<Result<void>> updateTripDiscount(num discountPercent);

  Future<Result<void>> updateCurrency(String currencyCode);

  Future<Result<void>> reviewDriverDocument({
    required String driverId,
    required String documentId,
    required bool approved,
    String? notes,
  });

  Future<Result<void>> approveDriver(String driverId);

  Future<Result<void>> assignDriverToTrip({
    required String tripId,
    required String driverId,
  });
}
