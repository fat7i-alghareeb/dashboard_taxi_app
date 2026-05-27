import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../models/admin_login_response_model.dart';
import '../models/auth_login_response_model.dart';
import '../models/auth_token_response_model.dart';
import '../params/auth_params.dart';

@lazySingleton
class AuthRemoteDataSource {
  const AuthRemoteDataSource(this._dio);

  final Dio _dio;

  Future<AdminLoginResponseModel> adminLogin({
    required String userName,
    required String password,
  }) => rethrowAsAppException(() async {
    printY(
      '[AuthRemoteDataSource] adminLogin -> ${ApiEndpoints.adminLogin} userName="$userName"',
    );
    final res = await _dio.post(
      ApiEndpoints.adminLogin,
      data: {'userName': userName, 'password': password},
    );
    final model = AdminLoginResponseModel.fromJson(
      res.data as Map<String, dynamic>,
    );
    printG(
      '[AuthRemoteDataSource] adminLogin success '
      'requiresPasswordReset=${model.requiresPasswordReset}',
    );
    return model;
  });

  Future<AuthLoginResponseModel> login(LoginParams params) =>
      rethrowAsAppException(() async {
        printY('[AuthRemoteDataSource] login -> ${ApiEndpoints.login}');
        final res = await _dio.post(ApiEndpoints.login, data: params.toJson());
        final model = AuthLoginResponseModel.fromJson(
          res.data as Map<String, dynamic>,
        );
        printG(
          '[AuthRemoteDataSource] login success '
          'user=${model.user.id} role=${model.user.role}',
        );
        return model;
      });

  Future<void> updateFcmToken(String token) => rethrowAsAppException(() async {
    printY(
      '[AuthRemoteDataSource] updateFcmToken -> ${ApiEndpoints.updateFcmToken}',
    );
    await _dio.put(ApiEndpoints.updateFcmToken, data: {'fcmToken': token});
    printG('[AuthRemoteDataSource] updateFcmToken success');
  });

  Future<void> updatePreferredLanguage(String languageCode) =>
      rethrowAsAppException(() async {
        printY(
          '[AuthRemoteDataSource] updatePreferredLanguage -> '
          '${ApiEndpoints.updatePreferredLanguage} lang=$languageCode',
        );
        await _dio.put(
          ApiEndpoints.updatePreferredLanguage,
          data: {'languageCode': languageCode},
        );
        printG('[AuthRemoteDataSource] updatePreferredLanguage success');
      });

  Future<AuthTokenResponseModel> forceResetPassword(String newPassword) =>
      rethrowAsAppException(() async {
        printY(
          '[AuthRemoteDataSource] forceResetPassword -> '
          '${ApiEndpoints.forceResetPassword}',
        );
        final res = await _dio.post(
          ApiEndpoints.forceResetPassword,
          data: {'newPassword': newPassword},
        );
        final model = AuthTokenResponseModel.fromJson(
          res.data as Map<String, dynamic>,
        );
        printG(
          '[AuthRemoteDataSource] forceResetPassword success token received',
        );
        return model;
      });
}
