import 'package:injectable/injectable.dart';

import '../../../../core/utils/result.dart';
import '../entities/app_version_config_entity.dart';
import '../repositories/app_version_config_repository.dart';

@lazySingleton
class AppVersionConfigFacade {
  const AppVersionConfigFacade(this._repository);

  final AppVersionConfigRepository _repository;

  Future<Result<AppVersionConfigEntity>> getAppVersionConfig() =>
      _repository.getAppVersionConfig();

  Future<Result<AppVersionConfigEntity>> updateAppVersionConfig(
    AppVersionConfigEntity config,
  ) => _repository.updateAppVersionConfig(config);
}
