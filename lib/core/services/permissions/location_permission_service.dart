import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:dashboardtaxi/utils/helpers/colored_print.dart';

@lazySingleton
class LocationPermissionService {
  const LocationPermissionService();

  Future<bool> isForegroundLocationGranted() async {
    final whenInUse = await Permission.locationWhenInUse.status;
    if (whenInUse.isGranted) return true;

    final always = await Permission.locationAlways.status;
    return always.isGranted;
  }
  
  Future<bool> isBackgroundLocationGranted() async {
    final status = await Permission.locationAlways.status;
    return status.isGranted;
  }

  Future<PermissionStatus> requestForegroundLocationPermission({
    required bool enableDebugLogs,
    bool openSettingsIfPermanentlyDenied = false,
  }) async {
    final current = await Permission.locationWhenInUse.status;
    if (current.isGranted) return current;

    final result = await Permission.locationWhenInUse.request();

    if (result.isPermanentlyDenied && openSettingsIfPermanentlyDenied) {
      await openAppSettings();
    }

    if (enableDebugLogs) {
      printM('[Location] foreground permission=${result.name}');
    }

    return result;
  }

  Future<PermissionStatus> requestBackgroundLocationPermission({
    required bool enableDebugLogs,
    bool openSettingsIfPermanentlyDenied = false,
  }) async {
    final current = await Permission.locationAlways.status;
    if (current.isGranted) return current;

    final result = await Permission.locationAlways.request();

    if (result.isPermanentlyDenied && openSettingsIfPermanentlyDenied) {
      await openAppSettings();
    }

    if (enableDebugLogs) {
      printM('[Location] background permission=${result.name}');
    }

    return result;
  }

  Future<void> openSettings() {
    return openAppSettings();
  }
}
