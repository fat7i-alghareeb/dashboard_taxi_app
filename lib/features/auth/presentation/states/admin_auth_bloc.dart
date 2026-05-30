import 'package:bloc/bloc.dart';

import '../../../../core/utils/bloc_status.dart';
import '../../../../core/utils/result.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../../domain/facade/auth_facade.dart';

// ---------------------------------------------------------------------------
// Events
// ---------------------------------------------------------------------------

sealed class AdminAuthEvent {}

final class AdminLoginRequested extends AdminAuthEvent {
  AdminLoginRequested({required this.userName, required this.password});
  final String userName;
  final String password;
}

final class AdminChangePasswordRequested extends AdminAuthEvent {
  AdminChangePasswordRequested({
    required this.currentPassword,
    required this.newPassword,
  });
  final String currentPassword;
  final String newPassword;
}

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------

class AdminAuthState {
  const AdminAuthState({
    this.loginStatus = const BlocStatus.initial(),
    this.changePasswordStatus = const BlocStatus.initial(),
  });

  final BlocStatus<void> loginStatus;
  final BlocStatus<void> changePasswordStatus;

  AdminAuthState copyWith({
    BlocStatus<void>? loginStatus,
    BlocStatus<void>? changePasswordStatus,
  }) =>
      AdminAuthState(
        loginStatus: loginStatus ?? this.loginStatus,
        changePasswordStatus: changePasswordStatus ?? this.changePasswordStatus,
      );
}

// ---------------------------------------------------------------------------
// BLoC
// ---------------------------------------------------------------------------

class AdminAuthBloc extends Bloc<AdminAuthEvent, AdminAuthState> {
  AdminAuthBloc(this._facade) : super(const AdminAuthState()) {
    on<AdminLoginRequested>(_onLoginRequested);
    on<AdminChangePasswordRequested>(_onChangePasswordRequested);
  }

  final AuthFacade _facade;

  Future<void> _onLoginRequested(
    AdminLoginRequested event,
    Emitter<AdminAuthState> emit,
  ) async {
    if (state.loginStatus.isLoading) {
      printY(
        '[AdminAuthBloc] login ignored because request is already loading',
      );
      return;
    }
    printM('[AdminAuthBloc] login requested userName="${event.userName}"');
    emit(state.copyWith(loginStatus: const BlocStatus.loading()));

    final result = await _facade.adminLogin(
      userName: event.userName,
      password: event.password,
    );

    result.when(
      success: (_) {
        printG('[AdminAuthBloc] login success');
        emit(state.copyWith(loginStatus: const BlocStatus.success(null)));
      },
      failure: (message) {
        printY('[AdminAuthBloc] login failed: $message');
        emit(state.copyWith(loginStatus: BlocStatus.failure(message)));
      },
    );
  }

  Future<void> _onChangePasswordRequested(
    AdminChangePasswordRequested event,
    Emitter<AdminAuthState> emit,
  ) async {
    if (state.changePasswordStatus.isLoading) {
      printY(
        '[AdminAuthBloc] change password ignored because request is already loading',
      );
      return;
    }
    printM('[AdminAuthBloc] change password requested');
    emit(state.copyWith(changePasswordStatus: const BlocStatus.loading()));

    final result = await _facade.changePassword(
      currentPassword: event.currentPassword,
      newPassword: event.newPassword,
    );

    result.when(
      success: (_) {
        printG('[AdminAuthBloc] change password success');
        emit(
          state.copyWith(
            changePasswordStatus: const BlocStatus.success(null),
          ),
        );
      },
      failure: (message) {
        printY('[AdminAuthBloc] change password failed: $message');
        emit(
          state.copyWith(
            changePasswordStatus: BlocStatus.failure(message),
          ),
        );
      },
    );
  }
}
