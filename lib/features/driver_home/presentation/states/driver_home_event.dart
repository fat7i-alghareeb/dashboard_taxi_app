part of 'driver_home_bloc.dart';

@freezed
class DriverHomeEvent with _$DriverHomeEvent {
  const factory DriverHomeEvent.started() = _Started;
  const factory DriverHomeEvent.toggleStatusRequested(bool isOnline) = _ToggleStatusRequested;
  const factory DriverHomeEvent.earningsRequested() = _EarningsRequested;
  const factory DriverHomeEvent.connectionStateChanged(RealtimeConnectionState connectionState) = _ConnectionStateChanged;
}
