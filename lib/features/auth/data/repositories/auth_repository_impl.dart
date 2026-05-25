import 'package:injectable/injectable.dart';

import '../../../../core/domain/user_entity.dart';
import '../../../../core/error/global_error_handler.dart';
import '../../../../core/services/session/auth_manager.dart';
import '../../../../core/utils/result.dart';
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
    return runAsResult(() => _firebase.requestSmsCode(phone));
  }

  @override
  Future<Result<UserEntity>> verifyAndLogin({
    required String phone,
    required String verificationId,
    required String smsCode,
  }) {
    return runAsResult(() async {
      final idToken = await _firebase.signInAndGetIdToken(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      final fcmToken = await _firebase.getFcmToken();

      final response = await _remote.login(
        LoginParams(phone: phone, firebaseIdToken: idToken, fcmToken: fcmToken),
      );

      final user = response.toUserEntity();
      final token = response.toAuthTokenModel();
      await _authManager.login(user: user, token: token);
      return user;
    });
  }

  @override
  Future<Result<void>> updateFcmToken(String token) {
    return runAsResult(() => _remote.updateFcmToken(token));
  }

  @override
  Future<Result<void>> updatePreferredLanguage(String languageCode) {
    return runAsResult(() => _remote.updatePreferredLanguage(languageCode));
  }

  @override
  Future<Result<void>> forceResetPassword(String newPassword) {
    return runAsResult(() async {
      final tokenResponse = await _remote.forceResetPassword(newPassword);
      await _authManager.updateToken(tokenResponse.toAuthTokenModel());

      final currentUser = _authManager.currentUser;
      if (currentUser != null) {
        await _authManager.updateUser(
          currentUser.copyWith(requiresPasswordReset: false),
        );
      }

      await _authManager.refreshCurrentUserProfile();
    });
  }
}
