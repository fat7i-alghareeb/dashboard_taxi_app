import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../models/app_version_config_model.dart';

@lazySingleton
class AppVersionConfigRemoteDataSource {
  const AppVersionConfigRemoteDataSource(this._dio);

  final Dio _dio;

  Future<AppVersionConfigModel> getAppVersionConfig() {
    return rethrowAsAppException(() async {
      printY('[AppVersionConfigRemoteDataSource] GET app version config');
      final response = await _dio.get<dynamic>(ApiEndpoints.appVersionConfig);
      return AppVersionConfigModel.fromJson(
        Map<String, dynamic>.from(response.data as Map),
      );
    });
  }

  Future<AppVersionConfigModel> updateAppVersionConfig({
    required bool enabled,
    required String androidLatestVersion,
    required String androidMinimumRequiredVersion,
    required String androidStoreUrl,
    required String iosLatestVersion,
    required String iosMinimumRequiredVersion,
    required String iosStoreUrl,
  }) {
    return rethrowAsAppException(() async {
      printY('[AppVersionConfigRemoteDataSource] PUT app version config');
      final response = await _dio.put<dynamic>(
        ApiEndpoints.appVersionConfig,
        data: {
          'enabled': enabled,
          'android': {
            'latestVersion': androidLatestVersion,
            'minimumRequiredVersion': androidMinimumRequiredVersion,
            'storeUrl': androidStoreUrl,
          },
          'ios': {
            'latestVersion': iosLatestVersion,
            'minimumRequiredVersion': iosMinimumRequiredVersion,
            'storeUrl': iosStoreUrl,
          },
        },
      );
      return AppVersionConfigModel.fromJson(
        Map<String, dynamic>.from(response.data as Map),
      );
    });
  }
}
