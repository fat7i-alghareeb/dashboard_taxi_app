import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/services/location/driver_location_streamer.dart';
import '../../../../core/services/realtime/realtime_connection_state.dart';
import '../../../../core/services/realtime/realtime_service.dart';
import '../../../../core/utils/bloc_status.dart';
import '../../../../core/utils/result.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../../../driver/domain/entities/driver_entity.dart';
import '../../../driver/domain/facade/driver_facade.dart';

part 'driver_home_event.dart';
part 'driver_home_state.dart';
part 'driver_home_bloc.freezed.dart';

@injectable
class DriverHomeBloc extends Bloc<DriverHomeEvent, DriverHomeState> {
  DriverHomeBloc(
    this._driverFacade,
    this._locationStreamer,
    this._realtimeService,
  ) : super(const DriverHomeState()) {
    on<_Started>(_onStarted);
    on<_ToggleStatusRequested>(_onToggleStatusRequested);
    on<_EarningsRequested>(_onEarningsRequested);
    on<_ConnectionStateChanged>(_onConnectionStateChanged);

    // Subscribe to the real-time SignalR socket connection states
    _connectionStateSub = _realtimeService.connectionState.listen((state) {
      add(DriverHomeEvent.connectionStateChanged(state));
    });
  }

  final DriverFacade _driverFacade;
  final DriverLocationStreamer _locationStreamer;
  final RealtimeService _realtimeService;

  StreamSubscription<RealtimeConnectionState>? _connectionStateSub;

  Future<void> _onStarted(_Started event, Emitter<DriverHomeState> emit) async {
    printM('[DriverHomeBloc] started');
    // Sync the initial tracking status
    emit(
      state.copyWith(
        isOnline: _locationStreamer.isTracking,
        connectionState: _realtimeService.currentConnectionState,
      ),
    );
    add(const DriverHomeEvent.earningsRequested());
  }

  Future<void> _onEarningsRequested(
    _EarningsRequested event,
    Emitter<DriverHomeState> emit,
  ) async {
    printM('[DriverHomeBloc] earnings requested');
    emit(state.copyWith(earningsState: const BlocStatus.loading()));

    final result = await _driverFacade.getEarnings();

    result.when(
      success: (earnings) {
        printG(
          '[DriverHomeBloc] earnings success trips=${earnings.totalTrips} total=${earnings.totalEarnings}',
        );
        emit(state.copyWith(earningsState: BlocStatus.success(earnings)));
      },
      failure: (message) {
        printY('[DriverHomeBloc] earnings failed: $message');
        emit(state.copyWith(earningsState: BlocStatus.failure(message)));
      },
    );
  }

  Future<void> _onToggleStatusRequested(
    _ToggleStatusRequested event,
    Emitter<DriverHomeState> emit,
  ) async {
    printM('[DriverHomeBloc] toggle status requested online=${event.isOnline}');
    emit(state.copyWith(statusState: const BlocStatus.loading()));

    // 1. Send the state change request to the REST backend
    final targetStatus = event.isOnline ? 1 : 0; // 1 = Online, 0 = Offline
    final result = await _driverFacade.updateStatus(targetStatus);

    await result.when(
      success: (_) async {
        printG(
          '[DriverHomeBloc] status update success online=${event.isOnline}',
        );
        // 2. Toggled status on backend succeeded. Now activate/deactivate the local coordinate tracking system
        if (event.isOnline) {
          await _locationStreamer.startTracking();
        } else {
          await _locationStreamer.stopTracking();
        }

        emit(
          state.copyWith(
            isOnline: event.isOnline,
            statusState: const BlocStatus.success(null),
          ),
        );
      },
      failure: (message) {
        printY('[DriverHomeBloc] status update failed: $message');
        emit(state.copyWith(statusState: BlocStatus.failure(message)));
      },
    );
  }

  void _onConnectionStateChanged(
    _ConnectionStateChanged event,
    Emitter<DriverHomeState> emit,
  ) {
    printC('[DriverHomeBloc] realtime connection=${event.connectionState}');
    emit(state.copyWith(connectionState: event.connectionState));
  }

  @override
  Future<void> close() {
    _connectionStateSub?.cancel();
    return super.close();
  }
}
