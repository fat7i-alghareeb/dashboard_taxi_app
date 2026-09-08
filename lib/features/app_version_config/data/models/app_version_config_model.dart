import '../../domain/entities/app_version_config_entity.dart';
import '../../domain/entities/app_version_platform_entity.dart';

class AppVersionPlatformModel {
  const AppVersionPlatformModel({
    required this.latestVersion,
    required this.minimumRequiredVersion,
    required this.storeUrl,
  });

  final String latestVersion;
  final String minimumRequiredVersion;
  final String storeUrl;

  /// Backend `PlatformVersionDto` shape.
  factory AppVersionPlatformModel.fromJson(Map<String, dynamic> json) {
    return AppVersionPlatformModel(
      latestVersion: _str(json, 'latestVersion'),
      minimumRequiredVersion: _str(json, 'minimumRequiredVersion'),
      storeUrl: _str(json, 'storeUrl'),
    );
  }

  AppVersionPlatformEntity toEntity() => AppVersionPlatformEntity(
    latestVersion: latestVersion,
    minimumRequiredVersion: minimumRequiredVersion,
    storeUrl: storeUrl,
  );
}

class AppVersionConfigModel {
  const AppVersionConfigModel({
    required this.enabled,
    required this.android,
    required this.ios,
  });

  final bool enabled;
  final AppVersionPlatformModel android;
  final AppVersionPlatformModel ios;

  /// Backend `AppVersionConfigDto` shape.
  factory AppVersionConfigModel.fromJson(Map<String, dynamic> json) {
    return AppVersionConfigModel(
      enabled: _bool(json, 'enabled'),
      android: AppVersionPlatformModel.fromJson(_map(json, 'android')),
      ios: AppVersionPlatformModel.fromJson(_map(json, 'ios')),
    );
  }

  AppVersionConfigEntity toEntity() => AppVersionConfigEntity(
    enabled: enabled,
    android: android.toEntity(),
    ios: ios.toEntity(),
  );
}

/// The .NET backend serialises camelCase today, but tolerate PascalCase too so a
/// future JSON policy change cannot silently blank every field.
dynamic _raw(Map<String, dynamic> json, String key) =>
    json[key] ?? json['${key[0].toUpperCase()}${key.substring(1)}'];

String _str(Map<String, dynamic> json, String key) =>
    _raw(json, key)?.toString() ?? '';

bool _bool(Map<String, dynamic> json, String key) {
  final value = _raw(json, key);
  if (value is bool) return value;
  return value?.toString().toLowerCase() == 'true';
}

Map<String, dynamic> _map(Map<String, dynamic> json, String key) {
  final value = _raw(json, key);
  if (value is Map) return Map<String, dynamic>.from(value);
  return <String, dynamic>{};
}
