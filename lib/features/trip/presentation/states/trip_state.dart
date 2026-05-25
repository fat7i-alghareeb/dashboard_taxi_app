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
    @Default(BlocStatus<void>.initial()) BlocStatus<void> startTripState,
    @Default(BlocStatus<void>.initial()) BlocStatus<void> completeTripState,
    @Default(BlocStatus<void>.initial()) BlocStatus<void> driverCancelState,
    @Default(BlocStatus<void>.initial()) BlocStatus<void> startWaitingState,
    @Default(BlocStatus<void>.initial()) BlocStatus<void> stopWaitingState,
    TripEntity? activeTrip,
    TripEntity? completedTrip,
    DateTime? arrivedAt,
  }) = _TripState;
}
