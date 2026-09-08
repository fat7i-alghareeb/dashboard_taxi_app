import 'package:injectable/injectable.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/app_version_config_entity.dart';
import '../../domain/repositories/app_version_config_repository.dart';
import '../datasources/app_version_config_remote_datasource.dart';

@LazySingleton(as: AppVersionConfigRepository)
class AppVersionConfigRepositoryImpl implements AppVersionConfigRepository {
  const AppVersionConfigRepositoryImpl(this._remote);

  final AppVersionConfigRemoteDataSource _remote;

  @override
  Future<Result<AppVersionConfigEntity>> getAppVersionConfig() {
    return runAsResult(() async {
      final model = await _remote.getAppVersionConfig();
      return model.toEntity();
    });
  }

  @override
  Future<Result<AppVersionConfigEntity>> updateAppVersionConfig(
    AppVersionConfigEntity config,
  ) {
    return runAsResult(() async {
      final model = await _remote.updateAppVersionConfig(
        enabled: config.enabled,
        androidLatestVersion: config.android.latestVersion,
        androidMinimumRequiredVersion: config.android.minimumRequiredVersion,
        androidStoreUrl: config.android.storeUrl,
        iosLatestVersion: config.ios.latestVersion,
        iosMinimumRequiredVersion: config.ios.minimumRequiredVersion,
        iosStoreUrl: config.ios.storeUrl,
      );
      return model.toEntity();
    });
  }
}
