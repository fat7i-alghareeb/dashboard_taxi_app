import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:dashboardtaxi/core/notification/notification_coordinator.dart';
import 'package:dashboardtaxi/utils/helpers/colored_print.dart';
import 'package:dashboardtaxi/core/services/location/location_service.dart';
import 'package:dashboardtaxi/core/services/permissions/location_permission_service.dart';

enum PermissionGateResult {
  granted,
  denied,
  permanentlyDenied,
  locationServiceDisabled,
}

@lazySingleton
class PermissionsCoordinator extends ChangeNotifier {
  PermissionsCoordinator(
    this._notificationCoordinator,
    this._locationPermissionService,
    this._locationService,
  );

  final NotificationCoordinator _notificationCoordinator;
  final LocationPermissionService _locationPermissionService;
  final LocationService _locationService;

  bool _notificationPromptRequestedThisSession = false;

  Future<bool> isNotificationGranted() {
    return _notificationCoordinator.isNotificationPermissionGranted();
  }

  Future<bool> isForegroundLocationGranted() {
    printM('[PermissionsCoordinator] check foreground location permission');
    return _locationPermissionService.isForegroundLocationGranted();
  }

  Future<bool> isBackgroundLocationGranted() {
    return _locationPermissionService.isBackgroundLocationGranted();
  }

  Future<PermissionGateResult> ensurePostSplashPermissions() async {
    printC('[PermissionsCoordinator] ensurePostSplashPermissions start');
    await _requestNotificationSoftly();
    final result = await ensureForegroundLocationRequired();
    printC('[PermissionsCoordinator] ensurePostSplashPermissions -> $result');
    return result;
  }

  Future<PermissionGateResult> ensureForegroundLocationRequired({
    bool openSettingsIfPermanentlyDenied = false,
  }) async {
    printM('[PermissionsCoordinator] ensureForegroundLocationRequired start');
    final locationServiceEnabled = await _locationService
        .isLocationServiceEnabled();
    printM(
      '[PermissionsCoordinator] location service enabled=$locationServiceEnabled',
    );

    if (!locationServiceEnabled) {
      printY('[PermissionsCoordinator] result=locationServiceDisabled');
      notifyListeners();
      return PermissionGateResult.locationServiceDisabled;
    }

    final hasForeground = await _locationPermissionService
        .isForegroundLocationGranted();
    printM('[PermissionsCoordinator] hasForeground=$hasForeground');

    if (hasForeground) {
      printG('[PermissionsCoordinator] result=granted (already granted)');
      notifyListeners();
      return PermissionGateResult.granted;
    }

    final status = await _locationPermissionService
        .requestForegroundLocationPermission(
          enableDebugLogs: true,
          openSettingsIfPermanentlyDenied: openSettingsIfPermanentlyDenied,
        );

    final grantedAfterRequest = await _locationPermissionService
        .isForegroundLocationGranted();

    printM(
      '[PermissionsCoordinator] request status=${status.name} '
      'grantedAfterRequest=$grantedAfterRequest',
    );

    notifyListeners();

    if (grantedAfterRequest) {
      printG('[PermissionsCoordinator] result=granted (after request)');
      return PermissionGateResult.granted;
    }

    if (status.isPermanentlyDenied || status == PermissionStatus.restricted) {
      printY('[PermissionsCoordinator] result=permanentlyDenied');
      return PermissionGateResult.permanentlyDenied;
    }

    printY('[PermissionsCoordinator] result=denied');
    return PermissionGateResult.denied;
  }

  Future<PermissionGateResult> ensureBackgroundLocationWhenNeeded({
    bool openSettingsIfPermanentlyDenied = false,
  }) async {
    final hasForeground = await _locationPermissionService
        .isForegroundLocationGranted();

    if (!hasForeground) {
      notifyListeners();
      return PermissionGateResult.denied;
    }

    final hasBackground = await _locationPermissionService
        .isBackgroundLocationGranted();

    if (hasBackground) {
      notifyListeners();
      return PermissionGateResult.granted;
    }

    final status = await _locationPermissionService
        .requestBackgroundLocationPermission(
          enableDebugLogs: true,
          openSettingsIfPermanentlyDenied: openSettingsIfPermanentlyDenied,
        );

    final grantedAfterRequest = await _locationPermissionService
        .isBackgroundLocationGranted();

    notifyListeners();

    if (grantedAfterRequest) {
      return PermissionGateResult.granted;
    }

    if (status.isPermanentlyDenied || status == PermissionStatus.restricted) {
      return PermissionGateResult.permanentlyDenied;
    }

    return PermissionGateResult.denied;
  }

  Future<void> openSettings() {
    printY('[PermissionsCoordinator] openSettings invoked');
    return _locationPermissionService.openSettings();
  }

  Future<void> _requestNotificationSoftly() async {
    if (_notificationPromptRequestedThisSession) {
      printM(
        '[PermissionsCoordinator] notification soft prompt already requested',
      );
      return;
    }

    _notificationPromptRequestedThisSession = true;
    printC('[PermissionsCoordinator] notification soft prompt start');

    try {
      final granted = await _notificationCoordinator
          .isNotificationPermissionGranted();

      printM('[PermissionsCoordinator] notification granted=$granted');

      if (!granted) {
        await _notificationCoordinator.requestNotificationPermission();
        printC('[PermissionsCoordinator] notification permission requested');
      }
    } catch (e) {
      printY('[PermissionsCoordinator] notification prompt failed: $e');
    }
  }
}
