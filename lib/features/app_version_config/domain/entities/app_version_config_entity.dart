import 'app_version_platform_entity.dart';

/// Remote version gate configuration for the customer app.
class AppVersionConfigEntity {
  const AppVersionConfigEntity({
    required this.enabled,
    required this.android,
    required this.ios,
  });

  final bool enabled;
  final AppVersionPlatformEntity android;
  final AppVersionPlatformEntity ios;
}
