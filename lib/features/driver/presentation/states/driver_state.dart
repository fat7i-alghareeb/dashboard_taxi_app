part of 'driver_bloc.dart';

@freezed
abstract class DriverState with _$DriverState {
  const factory DriverState({
    @Default(BlocStatus<List<DriverEntity>>.initial())
    BlocStatus<List<DriverEntity>> getAllState,
  }) = _DriverState;
}
