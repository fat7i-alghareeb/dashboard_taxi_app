import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/bloc_status.dart';
import '../../../../core/utils/result.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../../domain/entities/app_version_config_entity.dart';
import '../../domain/facade/app_version_config_facade.dart';

// ---------------------------------------------------------------------------
// Events
// ---------------------------------------------------------------------------

sealed class AppVersionConfigEvent {}

final class AppVersionConfigLoadRequested extends AppVersionConfigEvent {}

/// Carries the whole entity rather than seven positional fields — at that count
/// positional arguments stop being readable at the call site.
final class AppVersionConfigUpdateRequested extends AppVersionConfigEvent {
  AppVersionConfigUpdateRequested({required this.config});

  final AppVersionConfigEntity config;
}

final class AppVersionConfigUpdateAcknowledged extends AppVersionConfigEvent {}

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------

class AppVersionConfigState {
  const AppVersionConfigState({
    this.loadStatus = const BlocStatus.initial(),
    this.updateStatus = const BlocStatus.initial(),
    this.config,
  });

  final BlocStatus<AppVersionConfigEntity> loadStatus;
  final BlocStatus<void> updateStatus;
  final AppVersionConfigEntity? config;

  AppVersionConfigState copyWith({
    BlocStatus<AppVersionConfigEntity>? loadStatus,
    BlocStatus<void>? updateStatus,
    AppVersionConfigEntity? config,
  }) {
    return AppVersionConfigState(
      loadStatus: loadStatus ?? this.loadStatus,
      updateStatus: updateStatus ?? this.updateStatus,
      config: config ?? this.config,
    );
  }
}

// ---------------------------------------------------------------------------
// BLoC
// ---------------------------------------------------------------------------

@injectable
class AppVersionConfigBloc
    extends Bloc<AppVersionConfigEvent, AppVersionConfigState> {
  AppVersionConfigBloc(this._facade) : super(const AppVersionConfigState()) {
    on<AppVersionConfigLoadRequested>(_onLoadRequested);
    on<AppVersionConfigUpdateRequested>(_onUpdateRequested);
    on<AppVersionConfigUpdateAcknowledged>(_onUpdateAcknowledged);
  }

  final AppVersionConfigFacade _facade;

  Future<void> _onLoadRequested(
    AppVersionConfigLoadRequested event,
    Emitter<AppVersionConfigState> emit,
  ) async {
    printM('[AppVersionConfigBloc] load requested');
    emit(state.copyWith(loadStatus: const BlocStatus.loading()));

    final result = await _facade.getAppVersionConfig();

    result.when(
      success: (config) {
        printG('[AppVersionConfigBloc] load success enabled=${config.enabled}');
        emit(
          state.copyWith(
            loadStatus: BlocStatus.success(config),
            config: config,
          ),
        );
      },
      failure: (message) {
        printY('[AppVersionConfigBloc] load failed: $message');
        emit(state.copyWith(loadStatus: BlocStatus.failure(message)));
      },
    );
  }

  Future<void> _onUpdateRequested(
    AppVersionConfigUpdateRequested event,
    Emitter<AppVersionConfigState> emit,
  ) async {
    if (state.updateStatus.isLoading) return;

    printM('[AppVersionConfigBloc] update requested');
    emit(state.copyWith(updateStatus: const BlocStatus.loading()));

    final result = await _facade.updateAppVersionConfig(event.config);

    result.when(
      success: (config) {
        printG('[AppVersionConfigBloc] update success');
        emit(
          state.copyWith(
            updateStatus: const BlocStatus.success(null),
            config: config,
          ),
        );
      },
      failure: (message) {
        printY('[AppVersionConfigBloc] update failed: $message');
        emit(state.copyWith(updateStatus: BlocStatus.failure(message)));
      },
    );
  }

  void _onUpdateAcknowledged(
    AppVersionConfigUpdateAcknowledged event,
    Emitter<AppVersionConfigState> emit,
  ) {
    emit(state.copyWith(updateStatus: const BlocStatus.initial()));
  }
}
