part of 'dashboard_bloc.dart';

@freezed
abstract class DashboardState with _$DashboardState {
  const factory DashboardState({
    @Default(BlocStatus<DashboardEntity>.initial())
    BlocStatus<DashboardEntity> overviewState,
    @Default(BlocStatus<List<DashboardDriverDocumentEntity>>.initial())
    BlocStatus<List<DashboardDriverDocumentEntity>> driverDocumentsState,
    @Default(BlocStatus<void>.initial()) BlocStatus<void> documentReviewState,
    @Default(BlocStatus<void>.initial()) BlocStatus<void> driverApprovalState,
    @Default(BlocStatus<void>.initial()) BlocStatus<void> tripAssignmentState,
    @Default(BlocStatus<List<DashboardDriverLocationEntity>>.initial())
    BlocStatus<List<DashboardDriverLocationEntity>> driverLocationsState,
    @Default(BlocStatus<List<DashboardTripEntity>>.initial())
    BlocStatus<List<DashboardTripEntity>> adminTripsState,
    @Default(BlocStatus<DashboardTripDetailsEntity>.initial())
    BlocStatus<DashboardTripDetailsEntity> tripDetailsState,

    // --- Control Center admin states ---
    @Default(BlocStatus<DashboardSystemConfigEntity>.initial())
    BlocStatus<DashboardSystemConfigEntity> adminConfigState,
    @Default(BlocStatus<List<DashboardVehicleTypeEntity>>.initial())
    BlocStatus<List<DashboardVehicleTypeEntity>> adminVehicleTypesState,

    // Per-section action loading (scoped instead of shared)
    @Default(BlocStatus<void>.initial()) BlocStatus<void> configActionState,
    @Default(BlocStatus<void>.initial())
    BlocStatus<void> vehicleTypeActionState,

    String? selectedDriverId,
    String? selectedTripId,
  }) = _DashboardState;
}
