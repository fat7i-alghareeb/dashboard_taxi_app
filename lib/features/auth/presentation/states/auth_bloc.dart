import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/domain/user_entity.dart';
import '../../../../core/utils/bloc_status.dart';
import '../../../../core/utils/result.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../../domain/facade/auth_facade.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._facade) : super(const AuthState()) {
    on<_Started>(_onStarted);
    on<_SendOtpRequested>(_onSendOtpRequested);
    on<_VerifyOtpRequested>(_onVerifyOtpRequested);
    on<_ForceResetPasswordRequested>(_onForceResetPasswordRequested);
    on<_ResetRequested>(_onResetRequested);
  }

  final AuthFacade _facade;

  // Phone stored between send-OTP and verify-OTP steps
  String? _pendingPhone;

  Future<void> _onStarted(_Started event, Emitter<AuthState> emit) async {
    printM('[AuthBloc] started');
    _pendingPhone = null;
    emit(const AuthState());
  }

  Future<void> _onResetRequested(
    _ResetRequested event,
    Emitter<AuthState> emit,
  ) async {
    printM('[AuthBloc] reset requested');
    _pendingPhone = null;
    emit(
      state.copyWith(
        isOtpSent: false,
        phoneStatus: const BlocStatus.initial(),
        otpStatus: const BlocStatus.initial(),
        verificationId: null,
      ),
    );
  }

  Future<void> _onSendOtpRequested(
    _SendOtpRequested event,
    Emitter<AuthState> emit,
  ) async {
    if (state.phoneStatus.isLoading) {
      printY('[AuthBloc] send otp ignored because request is already loading');
      return;
    }
    printM('[AuthBloc] send otp requested phone=${event.phone}');
    emit(state.copyWith(phoneStatus: const BlocStatus.loading()));

    _pendingPhone = event.phone;
    final result = await _facade.requestSmsCode(event.phone);

    result.when(
      success: (verificationId) {
        printG('[AuthBloc] send otp success verificationId=$verificationId');
        emit(
          state.copyWith(
            phoneStatus: const BlocStatus.success(null),
            isOtpSent: true,
            verificationId: verificationId,
          ),
        );
      },
      failure: (message) {
        printY('[AuthBloc] send otp failed: $message');
        emit(state.copyWith(phoneStatus: BlocStatus.failure(message)));
      },
    );
  }

  Future<void> _onVerifyOtpRequested(
    _VerifyOtpRequested event,
    Emitter<AuthState> emit,
  ) async {
    if (state.otpStatus.isLoading) {
      printY(
        '[AuthBloc] verify otp ignored because request is already loading',
      );
      return;
    }
    if (_pendingPhone == null || state.verificationId == null) {
      printY(
        '[AuthBloc] verify otp ignored missing pendingPhone=$_pendingPhone '
        'verificationId=${state.verificationId}',
      );
      return;
    }

    printM('[AuthBloc] verify otp requested phone=$_pendingPhone');
    emit(state.copyWith(otpStatus: const BlocStatus.loading()));

    final result = await _facade.verifyAndLogin(
      phone: _pendingPhone!,
      verificationId: state.verificationId!,
      smsCode: event.otp,
    );

    result.when(
      success: (user) {
        printG('[AuthBloc] verify otp success user=${user.id}');
        emit(state.copyWith(otpStatus: BlocStatus.success(user)));
      },
      failure: (message) {
        printY('[AuthBloc] verify otp failed: $message');
        emit(state.copyWith(otpStatus: BlocStatus.failure(message)));
      },
    );
  }

  Future<void> _onForceResetPasswordRequested(
    _ForceResetPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    if (state.forceResetStatus.isLoading) {
      printY(
        '[AuthBloc] force reset ignored because request is already loading',
      );
      return;
    }

    printM('[AuthBloc] force reset password requested');
    emit(state.copyWith(forceResetStatus: const BlocStatus.loading()));

    final result = await _facade.forceResetPassword(event.newPassword);

    result.when(
      success: (_) {
        printG('[AuthBloc] force reset password success');
        emit(state.copyWith(forceResetStatus: const BlocStatus.success(null)));
      },
      failure: (message) {
        printY('[AuthBloc] force reset password failed: $message');
        emit(state.copyWith(forceResetStatus: BlocStatus.failure(message)));
      },
    );
  }
}
