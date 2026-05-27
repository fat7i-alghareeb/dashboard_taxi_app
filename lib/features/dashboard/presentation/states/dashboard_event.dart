part of 'dashboard_bloc.dart';

@freezed
class DashboardEvent with _$DashboardEvent {
  const factory DashboardEvent.started() = _Started;
  const factory DashboardEvent.overviewRequested() = _OverviewRequested;
  const factory DashboardEvent.driverDocumentsRequested(String driverId) =
      _DriverDocumentsRequested;
  const factory DashboardEvent.documentReviewRequested({
    required String driverId,
    required String documentId,
    required bool approved,
    String? notes,
  }) = _DocumentReviewRequested;
  const factory DashboardEvent.driverApprovalRequested(String driverId) =
      _DriverApprovalRequested;
  const factory DashboardEvent.tripAssignmentRequested({
    required String tripId,
    required String driverId,
    @Default(false) bool enterDriverMode,
  }) = _TripAssignmentRequested;
  const factory DashboardEvent.driverLocationsRequested() =
      _DriverLocationsRequested;
  const factory DashboardEvent.driverLocationReceived({
    required String driverId,
    required double latitude,
    required double longitude,
  }) = _DriverLocationReceived;
  const factory DashboardEvent.adminTripsRequested({String? status}) =
      _AdminTripsRequested;
  const factory DashboardEvent.tripDetailsRequested(String tripId) =
      _TripDetailsRequested;
  const factory DashboardEvent.adminOperationsRequested() =
      _AdminOperationsRequested;
  const factory DashboardEvent.driverSuspensionRequested(String driverId) =
      _DriverSuspensionRequested;
  const factory DashboardEvent.driverVehicleTypeAssignmentRequested({
    required String driverId,
    required String vehicleTypeId,
  }) = _DriverVehicleTypeAssignmentRequested;
  const factory DashboardEvent.vehicleTypeStatusToggleRequested(
    DashboardVehicleTypeEntity vehicleType,
  ) = _VehicleTypeStatusToggleRequested;
  const factory DashboardEvent.vehicleTypeRemovalRequested(
    String vehicleTypeId,
  ) = _VehicleTypeRemovalRequested;
  const factory DashboardEvent.vehicleTypeCreateRequested({
    required String code,
    required String name,
    required int capacity,
    required num ratePerKm,
    required num ratePerMin,
    required num minFare,
    required int sortOrder,
  }) = _VehicleTypeCreateRequested;
  const factory DashboardEvent.vehicleTypeUpdateRequested(
    DashboardVehicleTypeEntity vehicleType,
  ) = _VehicleTypeUpdateRequested;
  const factory DashboardEvent.tripDiscountUpdateRequested(
    num discountPercent,
  ) = _TripDiscountUpdateRequested;
  const factory DashboardEvent.currencyUpdateRequested(String currencyCode) =
      _CurrencyUpdateRequested;
}
