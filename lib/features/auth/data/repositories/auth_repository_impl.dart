import 'package:injectable/injectable.dart';

import '../../../../core/domain/user_entity.dart';
import '../../../../core/error/global_error_handler.dart';
import '../../../../core/services/session/auth_manager.dart';
import '../../../../core/utils/result.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_firebase_datasource.dart';
import '../datasources/auth_remote_datasource.dart';
import '../mappers/auth_model_mapper.dart';
import '../params/auth_params.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._firebase, this._remote, this._authManager);

  final AuthFirebaseDataSource _firebase;
  final AuthRemoteDataSource _remote;
  final AuthManager _authManager;

  @override
  Future<Result<String>> requestSmsCode(String phone) {
    return runAsResult(() async {
      // Backend-owned OTP (CM.com SMS). The returned otpRequestId is carried in
      // the "verificationId" slot so the bloc/UI stay unchanged.
      printC('[AuthRepository] requestPhoneLoginOtp start phone=$phone');
      final otpRequestId = await _remote.requestPhoneLoginOtp(
        PhoneOtpParams(phone: phone),
      );
      printG('[AuthRepository] requestPhoneLoginOtp success');
      return otpRequestId;
    });
  }

  @override
  Future<Result<UserEntity>> verifyAndLogin({
    required String phone,
    required String verificationId,
    required String smsCode,
  }) {
    return runAsResult(() async {
      // verificationId == otpRequestId from requestSmsCode above.
      printC(
        '[AuthRepository] verifyPhoneLoginOtp start otpRequestId=$verificationId',
      );
      final fcmToken = await _firebase.getFcmToken();
      printC('[AuthRepository] FCM token present=${fcmToken != null}');

      final response = await _remote.verifyPhoneLoginOtp(
        VerifyOtpParams(
          otpRequestId: verificationId,
          code: smsCode,
          fcmToken: fcmToken,
        ),
      );
      printG('[AuthRepository] backend phone login success');

      final user = response.toUserEntity();
      final token = response.toAuthTokenModel();
      printC(
        '[AuthRepository] mapped login user=${user.id} role=${user.role} '
        'requiresPasswordReset=${user.requiresPasswordReset}',
      );
      await _authManager.login(user: user, token: token);
      printG('[AuthRepository] verifyAndLogin session persisted');
      return user;
    });
  }

  @override
  Future<Result<void>> updateFcmToken(String token) {
    return runAsResult(() async {
      printC('[AuthRepository] updateFcmToken start');
      await _remote.updateFcmToken(token);
      printG('[AuthRepository] updateFcmToken success');
    });
  }

  @override
  Future<Result<void>> updatePreferredLanguage(String languageCode) {
    return runAsResult(() async {
      printC(
        '[AuthRepository] updatePreferredLanguage start lang=$languageCode',
      );
      await _remote.updatePreferredLanguage(languageCode);
      printG('[AuthRepository] updatePreferredLanguage success');
    });
  }

  @override
  Future<Result<UserEntity>> adminLogin({
    required String userName,
    required String password,
  }) {
    return runAsResult(() async {
      printC('[AuthRepository] adminLogin start userName="$userName"');
      final response = await _remote.adminLogin(
        userName: userName,
        password: password,
      );
      printG(
        '[AuthRepository] adminLogin response '
        'requiresPasswordReset=${response.requiresPasswordReset}',
      );
      final token = response.toAuthTokenModel();

      // Store the token first so authenticated API calls work immediately.
      printC('[AuthRepository] adminLogin writing token before session login');
      await _authManager.updateToken(token);

      // Build a minimal user entity so the router can check requiresPasswordReset.
      final user = UserEntity(
        role: 'Admin',
        requiresPasswordReset: response.requiresPasswordReset,
      );

      await _authManager.login(user: user, token: token);
      printG(
        '[AuthRepository] adminLogin minimal session persisted '
        'requiresPasswordReset=${user.requiresPasswordReset}',
      );

      if (response.requiresPasswordReset) {
        printY(
          '[AuthRepository] adminLogin requires password reset; skipping profile refresh',
        );
        return user;
      }

      // Fetch the full profile (name, id, email, etc.) now that the token is stored.
      printC('[AuthRepository] adminLogin refreshing current user profile');
      await _authManager.refreshCurrentUserProfile();

      // Return the refreshed user from state (profile includes id/name/email).
      printG(
        '[AuthRepository] adminLogin profile refreshed '
        'user=${_authManager.currentUser?.id} '
        'requiresPasswordReset=${_authManager.currentUser?.requiresPasswordReset}',
      );

      // FCM token + preferred language are registered centrally in
      // AuthManager.login() (called above) for all roles. The backend routes
      // both to the AdminProfiles record based on the authenticated identity,
      // so admin push is delivered per-device and localized per admin.

      return _authManager.currentUser ?? user;
    });
  }



  @override
  Future<Result<void>> forceResetPassword(String newPassword) {
    return runAsResult(() async {
      printC('[AuthRepository] forceResetPassword start');
      final tokenResponse = await _remote.forceResetPassword(newPassword);
      printG('[AuthRepository] forceResetPassword token response received');
      await _authManager.updateToken(tokenResponse.toAuthTokenModel());

      final currentUser = _authManager.currentUser;
      if (currentUser != null) {
        printC(
          '[AuthRepository] forceResetPassword clearing local reset flag '
          'user=${currentUser.id}',
        );
        await _authManager.updateUser(
          currentUser.copyWith(requiresPasswordReset: false),
        );
      } else {
        printY('[AuthRepository] forceResetPassword no current user to update');
      }

      printC('[AuthRepository] forceResetPassword refreshing profile');
      await _authManager.refreshCurrentUserProfile();
      printG('[AuthRepository] forceResetPassword completed');
    });
  }

  @override
  Future<Result<void>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) {
    return runAsResult(() async {
      printC('[AuthRepository] changePassword start');
      await _remote.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      printG('[AuthRepository] changePassword completed');
    });
  }
}
