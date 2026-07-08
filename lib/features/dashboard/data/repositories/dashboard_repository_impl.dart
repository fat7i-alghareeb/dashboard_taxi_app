import 'package:injectable/injectable.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/dashboard_entity.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/dashboard_remote_datasource.dart';
import '../mappers/dashboard_model_mapper.dart';
import '../models/dashboard_model.dart';

@LazySingleton(as: DashboardRepository)
class DashboardRepositoryImpl implements DashboardRepository {
  const DashboardRepositoryImpl(this._remote);

  final DashboardRemoteDataSource _remote;

  @override
  Future<Result<DashboardEntity>> getOverview() {
    return runAsResult(() async {
      final model = await _remote.getOverview();
      return model.toEntity;
    });
  }

  @override
  Future<Result<List<DashboardDriverDocumentEntity>>> getDriverDocuments(
    String driverId,
  ) {
    return runAsResult(() async {
      final models = await _remote.getDriverDocuments(driverId);
      return models.map((e) => e.toEntity).toList();
    });
  }

  @override
  Future<Result<List<DashboardDriverLocationEntity>>> getDriverLocations() {
    return runAsResult(() async {
      final models = await _remote.getDriverLocations();
      return models.map((e) => e.toEntity).toList();
    });
  }

  @override
  Future<Result<DashboardTripsPage>> getAdminTrips({
    int page = 1,
    int pageSize = 20,
    String? status,
    String? search,
    String? passengerId,
  }) {
    return runAsResult(() async {
      final paged = await _remote.getAdminTrips(
        page: page,
        pageSize: pageSize,
        status: status,
        search: search,
        passengerId: passengerId,
      );
      return DashboardTripsPage(
        items: paged.items.map((e) => e.toEntity).toList(),
        totalCount: paged.totalCount,
      );
    });
  }

  @override
  Future<Result<DashboardTripDetailsEntity>> getTripDetails(String tripId) {
    return runAsResult(() async {
      final model = await _remote.getTripDetails(tripId);
      return model.toEntity;
    });
  }

  @override
  Future<Result<DashboardTripFinancialsEntity>> getTripFinancials(
    String tripId,
  ) {
    return runAsResult(() async {
      final model = await _remote.getTripFinancials(tripId);
      return model.toEntity;
    });
  }

  @override
  Future<Result<DashboardUserWalletEntity>> getUserWallet(String userId) {
    return runAsResult(() async {
      final model = await _remote.getUserWallet(userId);
      return model.toEntity;
    });
  }

  @override
  Future<Result<DashboardAdminProfileEntity?>> getAdminProfile() {
    return runAsResult(() async {
      final model = await _remote.getAdminProfile();
      return model?.toEntity;
    });
  }

  @override
  Future<Result<DashboardSystemConfigEntity>> getAdminConfig() {
    return runAsResult(() async {
      final model = await _remote.getAdminConfig();
      return model.toEntity;
    });
  }

  @override
  Future<Result<List<DashboardDriverEntity>>> getAdminDrivers() {
    return runAsResult(() async {
      final models = await _remote.getAdminDrivers();
      return models.map((e) => e.toEntity).toList();
    });
  }

  @override
  Future<Result<List<DashboardVehicleTypeEntity>>> getAdminVehicleTypes() {
    return runAsResult(() async {
      final models = await _remote.getAdminVehicleTypes();
      return models.map((e) => e.toEntity).toList();
    });
  }

  @override
  Future<Result<List<DashboardUserEntity>>> getAdminUsers() {
    return runAsResult(() async {
      final models = await _remote.getAdminUsers();
      return models.map((e) => e.toEntity).toList();
    });
  }

  @override
  Future<Result<List<DashboardAuditLogEntity>>> getAdminAuditLogs() {
    return runAsResult(() async {
      final models = await _remote.getAdminAuditLogs();
      return models.map((e) => e.toEntity).toList();
    });
  }

  @override
  Future<Result<void>> suspendDriver(String driverId) {
    return runAsResult(() => _remote.suspendDriver(driverId));
  }

  @override
  Future<Result<void>> assignDriverVehicleType({
    required String driverId,
    required String vehicleTypeId,
  }) {
    return runAsResult(
      () => _remote.assignDriverVehicleType(
        driverId: driverId,
        vehicleTypeId: vehicleTypeId,
      ),
    );
  }

  @override
  Future<Result<void>> updateVehicleType(
    DashboardVehicleTypeEntity vehicleType,
  ) {
    return runAsResult(
      () => _remote.updateVehicleType(
        DashboardVehicleTypeModel(
          id: vehicleType.id,
          code: vehicleType.code,
          name: vehicleType.name,
          capacity: vehicleType.capacity,
          ratePerKm: vehicleType.ratePerKm,
          ratePerMin: vehicleType.ratePerMin,
          minFare: vehicleType.minFare,
          sortOrder: vehicleType.sortOrder,
          isActive: vehicleType.isActive,
        ),
      ),
    );
  }

  @override
  Future<Result<void>> createVehicleType({
    required String code,
    required String name,
    required int capacity,
    required num ratePerKm,
    required num ratePerMin,
    required num minFare,
    required int sortOrder,
  }) {
    return runAsResult(
      () => _remote.createVehicleType(
        code: code,
        name: name,
        capacity: capacity,
        ratePerKm: ratePerKm,
        ratePerMin: ratePerMin,
        minFare: minFare,
        sortOrder: sortOrder,
      ),
    );
  }

  @override
  Future<Result<void>> removeVehicleType(String vehicleTypeId) {
    return runAsResult(() => _remote.removeVehicleType(vehicleTypeId));
  }

  @override
  Future<Result<void>> updateTripDiscount(num discountPercent) {
    return runAsResult(() => _remote.updateTripDiscount(discountPercent));
  }

  @override
  Future<Result<void>> updateCurrency(String currencyCode) {
    return runAsResult(() => _remote.updateCurrency(currencyCode));
  }

  @override
  Future<Result<void>> reviewDriverDocument({
    required String driverId,
    required String documentId,
    required bool approved,
    String? notes,
  }) {
    return runAsResult(() {
      return _remote.reviewDriverDocument(
        driverId: driverId,
        documentId: documentId,
        approved: approved,
        notes: notes,
      );
    });
  }

  @override
  Future<Result<void>> approveDriver(String driverId) {
    return runAsResult(() => _remote.approveDriver(driverId));
  }

  @override
  Future<Result<void>> assignDriverToTrip({
    required String tripId,
    required String driverId,
  }) {
    return runAsResult(
      () => _remote.assignDriverToTrip(tripId: tripId, driverId: driverId),
    );
  }
}
