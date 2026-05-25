import 'package:injectable/injectable.dart';
import '../../../../core/domain/user_entity.dart';
import '../../../../core/utils/result.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class AuthFacade {
  const AuthFacade(this._repository);

  final AuthRepository _repository;

  Future<Result<String>> requestSmsCode(String phone) =>
      _repository.requestSmsCode(phone);

  Future<Result<UserEntity>> verifyAndLogin({
    required String phone,
    required String verificationId,
    required String smsCode,
  }) => _repository.verifyAndLogin(
    phone: phone,
    verificationId: verificationId,
    smsCode: smsCode,
  );

  Future<Result<void>> forceResetPassword(String newPassword) {
    return _repository.forceResetPassword(newPassword);
  }
}
