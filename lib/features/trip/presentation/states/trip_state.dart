part of 'trip_bloc.dart';

@freezed
abstract class TripState with _$TripState {
  const factory TripState({
    @Default(BlocStatus<List<TripEntity>>.initial())
    BlocStatus<List<TripEntity>> getAllState,
    @Default(BlocStatus<TripEntity>.initial())
    BlocStatus<TripEntity> activeTripState,
    @Default(BlocStatus<void>.initial()) BlocStatus<void> markEnRouteState,
    @Default(BlocStatus<void>.initial()) BlocStatus<void> markArrivedState,
    @Default(BlocStatus<void>.initial())
    BlocStatus<void> resendArrivedNotificationState,
    DateTime? lastArrivedResendAt,
    @Default(BlocStatus<void>.initial()) BlocStatus<void> startTripState,
    @Default(BlocStatus<void>.initial()) BlocStatus<void> completeTripState,
    @Default(BlocStatus<void>.initial()) BlocStatus<void> driverCancelState,
    @Default(BlocStatus<void>.initial()) BlocStatus<void> completeStopState,
    TripEntity? activeTrip,
    TripEntity? completedTrip,
    @Default(<TripEntity>[]) List<TripEntity> pendingTrips,
    DateTime? arrivedAt,
    @Default(<int>{}) Set<int> completedStops,
    @Default(BlocStatus<void>.initial()) BlocStatus<void> adminSelfAssignState,
    @Default(BlocStatus<void>.initial()) BlocStatus<void> adminCancelState,
  }) = _TripState;
}
