import '../../../../core/domain/user_entity.dart';
import '../../../../core/utils/result.dart';

abstract class AuthRepository {
  /// Triggers Firebase Phone Auth and returns the verificationId on success.
  Future<Result<String>> requestSmsCode(String phone);

  /// Verifies the SMS code with Firebase, exchanges the resulting Firebase
  /// ID token for the system JWT via the backend `/auth/login` endpoint,
  /// and persists the session via [AuthManager].
  Future<Result<UserEntity>> verifyAndLogin({
    required String phone,
    required String verificationId,
    required String smsCode,
  });

  /// Updates the FCM device token on the backend.
  Future<Result<void>> updateFcmToken(String token);

  /// Updates the user's preferred language on the backend.
  Future<Result<void>> updatePreferredLanguage(String languageCode);

  /// Authenticates an admin using username + password and persists the session.
  Future<Result<UserEntity>> adminLogin({
    required String userName,
    required String password,
  });

  /// Completes the mandatory password reset flow and refreshes the session.
  Future<Result<void>> forceResetPassword(String newPassword);

  /// Changes the password of the currently authenticated user.
  Future<Result<void>> changePassword({
    required String currentPassword,
    required String newPassword,
  });
}
