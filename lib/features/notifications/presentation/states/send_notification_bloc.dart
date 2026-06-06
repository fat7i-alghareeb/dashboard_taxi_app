import 'package:bloc/bloc.dart';

import '../../../../core/utils/bloc_status.dart';
import '../../../../core/utils/result.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../../data/params/broadcast_notification_params.dart';
import '../../domain/facade/notification_facade.dart';

// ---------------------------------------------------------------------------
// Events
// ---------------------------------------------------------------------------

sealed class SendNotificationEvent {}

final class SendNotificationSubmitted extends SendNotificationEvent {
  SendNotificationSubmitted(this.params);
  final BroadcastNotificationParams params;
}

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------

class SendNotificationState {
  const SendNotificationState({
    this.submitStatus = const BlocStatus.initial(),
  });

  final BlocStatus<void> submitStatus;

  SendNotificationState copyWith({BlocStatus<void>? submitStatus}) =>
      SendNotificationState(submitStatus: submitStatus ?? this.submitStatus);
}

// ---------------------------------------------------------------------------
// BLoC
// ---------------------------------------------------------------------------

class SendNotificationBloc
    extends Bloc<SendNotificationEvent, SendNotificationState> {
  SendNotificationBloc(this._facade) : super(const SendNotificationState()) {
    on<SendNotificationSubmitted>(_onSubmitted);
  }

  final NotificationFacade _facade;

  Future<void> _onSubmitted(
    SendNotificationSubmitted event,
    Emitter<SendNotificationState> emit,
  ) async {
    if (state.submitStatus.isLoading) {
      printY('[SendNotificationBloc] submit ignored, request already loading');
      return;
    }
    printM('[SendNotificationBloc] submit title="${event.params.title}"');
    emit(state.copyWith(submitStatus: const BlocStatus.loading()));

    final result = await _facade.broadcast(event.params);

    result.when(
      success: (_) {
        printG('[SendNotificationBloc] broadcast success');
        emit(state.copyWith(submitStatus: const BlocStatus.success(null)));
      },
      failure: (message) {
        printY('[SendNotificationBloc] broadcast failed: $message');
        emit(state.copyWith(submitStatus: BlocStatus.failure(message)));
      },
    );
  }
}
