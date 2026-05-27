import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/services/location/location_service.dart';
import '../../../../core/services/permissions/permissions_coordinator.dart';
import '../../../../core/utils/bloc_status.dart';
import '../../../../utils/constants/app_flow_constants.dart';
import '../../domain/entities/root_map_location_entity.dart';

part 'root_event.dart';
part 'root_state.dart';
part 'root_bloc.freezed.dart';

@injectable
class RootBloc extends Bloc<RootEvent, RootState> {
  RootBloc(
    this._permissionsCoordinator,
    this._locationService,
  ) : super(const RootState()) {
    on<_Started>(_onStarted);
    on<_MapBootstrapRequested>(_onMapBootstrapRequested);
    on<_RecenterRequested>(_onRecenterRequested);
    on<_AccurateLocationResolved>(_onAccurateLocationResolved);
  }

  final PermissionsCoordinator _permissionsCoordinator;
  final LocationService _locationService;

  Future<void> _onStarted(_Started event, Emitter<RootState> emit) async {
    add(const RootEvent.mapBootstrapRequested());
  }

  Future<void> _onMapBootstrapRequested(
    _MapBootstrapRequested event,
    Emitter<RootState> emit,
  ) async {
    await _permissionsCoordinator.ensureForegroundLocationRequired();

    final lastKnown = await _locationService.getLastKnownPosition();
    if (lastKnown != null) {
      emit(
        state.copyWith(
          mapBootstrapState: BlocStatus.success(
            RootMapLocationEntity(
              latitude: lastKnown.latitude,
              longitude: lastKnown.longitude,
              zoom: MapConfig.initialZoom,
            ),
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          mapBootstrapState: const BlocStatus.success(
            RootMapLocationEntity(
              latitude: MapConfig.defaultLat,
              longitude: MapConfig.defaultLng,
              zoom: MapConfig.initialZoom,
            ),
          ),
        ),
      );
    }

    _resolveAccurateLocation();
  }

  Future<void> _resolveAccurateLocation() async {
    try {
      final position = await _locationService.getCurrentPosition();
      add(
        RootEvent.accurateLocationResolved(
          RootMapLocationEntity(
            latitude: position.latitude,
            longitude: position.longitude,
            zoom: MapConfig.focusZoom,
          ),
        ),
      );
    } catch (_) {}
  }

  void _onAccurateLocationResolved(
    _AccurateLocationResolved event,
    Emitter<RootState> emit,
  ) {
    emit(
      state.copyWith(
        mapBootstrapState: BlocStatus.success(event.location),
      ),
    );
  }

  Future<void> _onRecenterRequested(
    _RecenterRequested event,
    Emitter<RootState> emit,
  ) async {
    emit(state.copyWith(recenterState: const BlocStatus.loading()));

    final lastKnown = await _locationService.getLastKnownPosition();
    if (lastKnown != null) {
      final location = RootMapLocationEntity(
        latitude: lastKnown.latitude,
        longitude: lastKnown.longitude,
        zoom: MapConfig.focusZoom,
      );
      emit(
        state.copyWith(
          mapBootstrapState: BlocStatus.success(location),
          recenterState: BlocStatus.success(location),
        ),
      );
    }

    _resolveAccurateLocation();
  }
}
