part of 'driver_bloc.dart';

@freezed
class DriverEvent with _$DriverEvent {
  const factory DriverEvent.started() = _Started;
  const factory DriverEvent.getAllRequested() = _GetAllRequested;
}
