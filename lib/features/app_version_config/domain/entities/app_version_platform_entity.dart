/// Version gate rules for a single mobile platform.
///
/// Empty strings mean "not configured": the customer app leaves that platform
/// ungated rather than guessing.
class AppVersionPlatformEntity {
  const AppVersionPlatformEntity({
    required this.latestVersion,
    required this.minimumRequiredVersion,
    required this.storeUrl,
  });

  const AppVersionPlatformEntity.empty()
    : latestVersion = '',
      minimumRequiredVersion = '',
      storeUrl = '';

  final String latestVersion;
  final String minimumRequiredVersion;
  final String storeUrl;
}
