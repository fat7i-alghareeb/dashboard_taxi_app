import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/bloc_status.dart';
import '../../../../core/utils/result.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../../domain/entities/support_contact_entity.dart';
import '../../domain/facade/support_contact_facade.dart';

// ---------------------------------------------------------------------------
// Events
// ---------------------------------------------------------------------------

sealed class SupportContactEvent {}

final class SupportContactLoadRequested extends SupportContactEvent {}

final class SupportContactUpdateRequested extends SupportContactEvent {
  SupportContactUpdateRequested({required this.whatsApp});
  final String whatsApp;
}

final class SupportContactUpdateAcknowledged extends SupportContactEvent {}

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------

class SupportContactState {
  const SupportContactState({
    this.loadStatus = const BlocStatus.initial(),
    this.updateStatus = const BlocStatus.initial(),
    this.contact,
  });

  final BlocStatus<SupportContactEntity> loadStatus;
  final BlocStatus<void> updateStatus;
  final SupportContactEntity? contact;

  SupportContactState copyWith({
    BlocStatus<SupportContactEntity>? loadStatus,
    BlocStatus<void>? updateStatus,
    SupportContactEntity? contact,
  }) {
    return SupportContactState(
      loadStatus: loadStatus ?? this.loadStatus,
      updateStatus: updateStatus ?? this.updateStatus,
      contact: contact ?? this.contact,
    );
  }
}

// ---------------------------------------------------------------------------
// BLoC
// ---------------------------------------------------------------------------

@injectable
class SupportContactBloc
    extends Bloc<SupportContactEvent, SupportContactState> {
  SupportContactBloc(this._facade) : super(const SupportContactState()) {
    on<SupportContactLoadRequested>(_onLoadRequested);
    on<SupportContactUpdateRequested>(_onUpdateRequested);
    on<SupportContactUpdateAcknowledged>(_onUpdateAcknowledged);
  }

  final SupportContactFacade _facade;

  Future<void> _onLoadRequested(
    SupportContactLoadRequested event,
    Emitter<SupportContactState> emit,
  ) async {
    printM('[SupportContactBloc] load requested');
    emit(state.copyWith(loadStatus: const BlocStatus.loading()));

    final result = await _facade.getSupportContact();

    result.when(
      success: (contact) {
        printG('[SupportContactBloc] load success');
        emit(
          state.copyWith(
            loadStatus: BlocStatus.success(contact),
            contact: contact,
          ),
        );
      },
      failure: (message) {
        printY('[SupportContactBloc] load failed: $message');
        emit(state.copyWith(loadStatus: BlocStatus.failure(message)));
      },
    );
  }

  Future<void> _onUpdateRequested(
    SupportContactUpdateRequested event,
    Emitter<SupportContactState> emit,
  ) async {
    printM('[SupportContactBloc] update requested');
    emit(state.copyWith(updateStatus: const BlocStatus.loading()));

    final result = await _facade.updateSupportContact(whatsApp: event.whatsApp);

    result.when(
      success: (contact) {
        printG('[SupportContactBloc] update success');
        emit(
          state.copyWith(
            updateStatus: const BlocStatus.success(null),
            contact: contact,
          ),
        );
      },
      failure: (message) {
        printY('[SupportContactBloc] update failed: $message');
        emit(state.copyWith(updateStatus: BlocStatus.failure(message)));
      },
    );
  }

  void _onUpdateAcknowledged(
    SupportContactUpdateAcknowledged event,
    Emitter<SupportContactState> emit,
  ) {
    emit(state.copyWith(updateStatus: const BlocStatus.initial()));
  }
}
