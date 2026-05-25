part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.started() = _Started;
  const factory AuthEvent.sendOtpRequested(String phone) = _SendOtpRequested;
  const factory AuthEvent.verifyOtpRequested(String otp) = _VerifyOtpRequested;
  const factory AuthEvent.forceResetPasswordRequested(String newPassword) =
      _ForceResetPasswordRequested;
  const factory AuthEvent.resetRequested() = _ResetRequested;
}
