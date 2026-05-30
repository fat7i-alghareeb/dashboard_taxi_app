import 'package:injectable/injectable.dart';
import '../../../../core/domain/user_entity.dart';
import '../../../../core/utils/result.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class AuthFacade {
  const AuthFacade(this._repository);

  final AuthRepository _repository;

  Future<Result<String>> requestSmsCode(String phone) {
    printC('[AuthFacade] requestSmsCode phone=$phone');
    return _repository.requestSmsCode(phone);
  }

  Future<Result<UserEntity>> verifyAndLogin({
    required String phone,
    required String verificationId,
    required String smsCode,
  }) {
    printC(
      '[AuthFacade] verifyAndLogin phone=$phone '
      'verificationId=$verificationId',
    );
    return _repository.verifyAndLogin(
      phone: phone,
      verificationId: verificationId,
      smsCode: smsCode,
    );
  }

  Future<Result<UserEntity>> adminLogin({
    required String userName,
    required String password,
  }) {
    printC('[AuthFacade] adminLogin userName="$userName"');
    return _repository.adminLogin(userName: userName, password: password);
  }

  Future<Result<void>> forceResetPassword(String newPassword) {
    printC('[AuthFacade] forceResetPassword');
    return _repository.forceResetPassword(newPassword);
  }

  Future<Result<void>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) {
    printC('[AuthFacade] changePassword');
    return _repository.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }
}
