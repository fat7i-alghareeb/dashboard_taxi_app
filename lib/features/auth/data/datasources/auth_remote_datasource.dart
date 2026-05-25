import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/auth_login_response_model.dart';
import '../models/auth_token_response_model.dart';
import '../params/auth_params.dart';

@lazySingleton
class AuthRemoteDataSource {
  const AuthRemoteDataSource(this._dio);

  final Dio _dio;

  Future<AuthLoginResponseModel> login(LoginParams params) =>
      rethrowAsAppException(() async {
        final res = await _dio.post(ApiEndpoints.login, data: params.toJson());
        return AuthLoginResponseModel.fromJson(
          res.data as Map<String, dynamic>,
        );
      });

  Future<void> updateFcmToken(String token) => rethrowAsAppException(() async {
    await _dio.put(ApiEndpoints.updateFcmToken, data: {'fcmToken': token});
  });

  Future<void> updatePreferredLanguage(String languageCode) =>
      rethrowAsAppException(() async {
        await _dio.put(
          ApiEndpoints.updatePreferredLanguage,
          data: {'languageCode': languageCode},
        );
      });

  Future<AuthTokenResponseModel> forceResetPassword(String newPassword) =>
      rethrowAsAppException(() async {
        final res = await _dio.post(
          ApiEndpoints.forceResetPassword,
          data: {'newPassword': newPassword},
        );
        return AuthTokenResponseModel.fromJson(
          res.data as Map<String, dynamic>,
        );
      });
}
