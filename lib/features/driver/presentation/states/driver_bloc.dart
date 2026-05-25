import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/bloc_status.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/driver_entity.dart';
import '../../domain/facade/driver_facade.dart';

part 'driver_event.dart';
part 'driver_state.dart';
part 'driver_bloc.freezed.dart';

@injectable
class DriverBloc extends Bloc<DriverEvent, DriverState> {
  DriverBloc(this._facade) : super(const DriverState()) {
    on<_Started>(_onStarted);
    on<_GetAllRequested>(_onGetAllRequested);
  }

  final DriverFacade _facade;

  Future<void> _onStarted(_Started event, Emitter<DriverState> emit) {
    return _onGetAllRequested(const _GetAllRequested(), emit);
  }

  Future<void> _onGetAllRequested(
    _GetAllRequested event,
    Emitter<DriverState> emit,
  ) async {
    emit(state.copyWith(getAllState: const BlocStatus.loading()));

    final result = await _facade.getAllDrivers();
    result.when(
      success: (data) => emit(state.copyWith(getAllState: BlocStatus.success(data))),
      failure: (message) => emit(state.copyWith(getAllState: BlocStatus.failure(message))),
    );
  }
}
