part of 'root_bloc.dart';

@freezed
abstract class RootState with _$RootState {
  const factory RootState({
    @Default(BlocStatus<RootMapLocationEntity>.initial())
    BlocStatus<RootMapLocationEntity> mapBootstrapState,
    @Default(BlocStatus<RootMapLocationEntity>.initial())
    BlocStatus<RootMapLocationEntity> recenterState,
  }) = _RootState;
}
