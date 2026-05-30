import 'package:injectable/injectable.dart';

import '../../../../core/utils/result.dart';
import '../entities/dashboard_entity.dart';
import '../repositories/dashboard_repository.dart';

@lazySingleton
class DashboardFacade {
  const DashboardFacade(this._repository);

  final DashboardRepository _repository;

  Future<Result<DashboardEntity>> getOverview() {
    return _repository.getOverview();
  }

  Future<Result<List<DashboardDriverDocumentEntity>>> getDriverDocuments(
    String driverId,
  ) {
    return _repository.getDriverDocuments(driverId);
  }

  Future<Result<List<DashboardDriverLocationEntity>>> getDriverLocations() {
    return _repository.getDriverLocations();
  }

  Future<Result<List<DashboardTripEntity>>> getAdminTrips({String? status}) {
    return _repository.getAdminTrips(status: status);
  }

  Future<Result<DashboardTripDetailsEntity>> getTripDetails(String tripId) {
    return _repository.getTripDetails(tripId);
  }

  Future<Result<DashboardAdminProfileEntity?>> getAdminProfile() {
    return _repository.getAdminProfile();
  }

  Future<Result<DashboardSystemConfigEntity>> getAdminConfig() {
    return _repository.getAdminConfig();
  }

  Future<Result<List<DashboardDriverEntity>>> getAdminDrivers() {
    return _repository.getAdminDrivers();
  }

  Future<Result<List<DashboardVehicleTypeEntity>>> getAdminVehicleTypes() {
    return _repository.getAdminVehicleTypes();
  }

  Future<Result<List<DashboardUserEntity>>> getAdminUsers() {
    return _repository.getAdminUsers();
  }

  Future<Result<List<DashboardAuditLogEntity>>> getAdminAuditLogs() {
    return _repository.getAdminAuditLogs();
  }


  Future<Result<void>> suspendDriver(String driverId) {
    return _repository.suspendDriver(driverId);
  }

  Future<Result<void>> assignDriverVehicleType({
    required String driverId,
    required String vehicleTypeId,
  }) {
    return _repository.assignDriverVehicleType(
      driverId: driverId,
      vehicleTypeId: vehicleTypeId,
    );
  }

  Future<Result<void>> updateVehicleType(
    DashboardVehicleTypeEntity vehicleType,
  ) {
    return _repository.updateVehicleType(vehicleType);
  }

  Future<Result<void>> createVehicleType({
    required String code,
    required String name,
    required int capacity,
    required num ratePerKm,
    required num ratePerMin,
    required num minFare,
    required int sortOrder,
  }) {
    return _repository.createVehicleType(
      code: code,
      name: name,
      capacity: capacity,
      ratePerKm: ratePerKm,
      ratePerMin: ratePerMin,
      minFare: minFare,
      sortOrder: sortOrder,
    );
  }

  Future<Result<void>> removeVehicleType(String vehicleTypeId) {
    return _repository.removeVehicleType(vehicleTypeId);
  }

  Future<Result<void>> updateTripDiscount(num discountPercent) {
    return _repository.updateTripDiscount(discountPercent);
  }

  Future<Result<void>> updateCurrency(String currencyCode) {
    return _repository.updateCurrency(currencyCode);
  }

  Future<Result<void>> reviewDriverDocument({
    required String driverId,
    required String documentId,
    required bool approved,
    String? notes,
  }) {
    return _repository.reviewDriverDocument(
      driverId: driverId,
      documentId: documentId,
      approved: approved,
      notes: notes,
    );
  }

  Future<Result<void>> approveDriver(String driverId) {
    return _repository.approveDriver(driverId);
  }

  Future<Result<void>> assignDriverToTrip({
    required String tripId,
    required String driverId,
  }) {
    return _repository.assignDriverToTrip(tripId: tripId, driverId: driverId);
  }
}
