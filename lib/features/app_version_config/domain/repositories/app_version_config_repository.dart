import '../../../../core/utils/result.dart';
import '../entities/app_version_config_entity.dart';

abstract class AppVersionConfigRepository {
  Future<Result<AppVersionConfigEntity>> getAppVersionConfig();

  Future<Result<AppVersionConfigEntity>> updateAppVersionConfig(
    AppVersionConfigEntity config,
  );
}
