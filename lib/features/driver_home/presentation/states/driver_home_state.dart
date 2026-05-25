part of 'driver_home_bloc.dart';

@freezed
abstract class DriverHomeState with _$DriverHomeState {
  const factory DriverHomeState({
    @Default(false) bool isOnline,
    @Default(BlocStatus<void>.initial()) BlocStatus<void> statusState,
    @Default(BlocStatus<DriverEarningsEntity>.initial())
    BlocStatus<DriverEarningsEntity> earningsState,
    @Default(RealtimeConnectionState.disconnected) RealtimeConnectionState connectionState,
  }) = _DriverHomeState;
}
