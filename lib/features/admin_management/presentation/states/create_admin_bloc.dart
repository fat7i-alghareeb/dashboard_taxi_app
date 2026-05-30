import 'package:bloc/bloc.dart';

import '../../../../core/utils/bloc_status.dart';
import '../../../../core/utils/result.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../../data/params/register_admin_params.dart';
import '../../domain/facade/admin_management_facade.dart';

// ---------------------------------------------------------------------------
// Events
// ---------------------------------------------------------------------------

sealed class CreateAdminEvent {}

final class CreateAdminSubmitted extends CreateAdminEvent {
  CreateAdminSubmitted(this.params);
  final RegisterAdminParams params;
}

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------

class CreateAdminState {
  const CreateAdminState({this.submitStatus = const BlocStatus.initial()});

  final BlocStatus<void> submitStatus;

  CreateAdminState copyWith({BlocStatus<void>? submitStatus}) =>
      CreateAdminState(submitStatus: submitStatus ?? this.submitStatus);
}

// ---------------------------------------------------------------------------
// BLoC
// ---------------------------------------------------------------------------

class CreateAdminBloc extends Bloc<CreateAdminEvent, CreateAdminState> {
  CreateAdminBloc(this._facade) : super(const CreateAdminState()) {
    on<CreateAdminSubmitted>(_onSubmitted);
  }

  final AdminManagementFacade _facade;

  Future<void> _onSubmitted(
    CreateAdminSubmitted event,
    Emitter<CreateAdminState> emit,
  ) async {
    if (state.submitStatus.isLoading) {
      printY('[CreateAdminBloc] submit ignored, request already loading');
      return;
    }
    printM('[CreateAdminBloc] submit userName="${event.params.userName}"');
    emit(state.copyWith(submitStatus: const BlocStatus.loading()));

    final result = await _facade.registerAdmin(event.params);

    result.when(
      success: (_) {
        printG('[CreateAdminBloc] registerAdmin success');
        emit(state.copyWith(submitStatus: const BlocStatus.success(null)));
      },
      failure: (message) {
        printY('[CreateAdminBloc] registerAdmin failed: $message');
        emit(state.copyWith(submitStatus: BlocStatus.failure(message)));
      },
    );
  }
}
