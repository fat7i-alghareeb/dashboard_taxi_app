part of 'root_bloc.dart';

@freezed
class RootEvent with _$RootEvent {
  const factory RootEvent.started() = _Started;
  const factory RootEvent.mapBootstrapRequested() = _MapBootstrapRequested;
  const factory RootEvent.recenterRequested() = _RecenterRequested;
  const factory RootEvent.accurateLocationResolved(
    RootMapLocationEntity location,
  ) = _AccurateLocationResolved;
}
