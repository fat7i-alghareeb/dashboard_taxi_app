import 'dart:async';

import 'package:dio_refresh_bot/dio_refresh_bot.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../../core/router/app_page_transitions.dart';
import '../../features/auth/presentation/ui/screens/admin_login_screen.dart';
import '../../features/auth/presentation/ui/screens/change_password_screen.dart';
import '../../features/auth/presentation/ui/screens/force_password_reset_screen.dart';
import '../../features/auth/presentation/ui/screens/login_screen.dart';
import '../../features/admin_management/presentation/ui/screens/create_admin_screen.dart';
import '../../features/compensation/presentation/ui/screens/compensation_claims_screen.dart';
import '../../features/control_center/presentation/ui/screens/control_center_screen.dart';
import '../../features/dashboard/presentation/ui/screens/dashboard_live_map_screen.dart';
import '../../features/dashboard/presentation/ui/screens/dashboard_screen.dart';
import '../../features/dashboard/presentation/ui/screens/dashboard_trips_screen.dart';
import '../../features/notifications/presentation/ui/screens/send_notification_screen.dart';
import '../../features/permissions/presentation/ui/screens/permission_gate_screen.dart';
import '../../features/root/presentation/ui/screens/root_screen.dart';
import '../../features/kyc/presentation/ui/screens/kyc_screen.dart';
import '../../features/splash/presentation/ui/screens/splash_screen.dart';
import '../../utils/constants/app_flow_constants.dart';
import '../../utils/helpers/colored_print.dart';
import '../services/session/auth_state_notifier.dart';
import '../services/permissions/permissions_coordinator.dart';

part 'app_routes.dart';

/// * RouterRefreshListenable
///
/// Bridges authentication status and an internal
/// splash delay into a single [Listenable] used by GoRouter.
class RouterRefreshListenable extends ChangeNotifier {
  RouterRefreshListenable({
    required this.authState,
    required this.permissionsCoordinator,
  }) {
    // * Listen to all reactive sources that affect routing.
    authState.addListener(_onSourceChanged);
    permissionsCoordinator.addListener(_onSourceChanged);

    // * Ensure the splash is visible for at least [SplashConfig.initialDelay]
    //   even if auth resolves instantly.
    Future<void>.delayed(SplashConfig.initialDelay, () {
      _splashDelayElapsed = true;
      printC('${RouterLogTags.router} splash delay elapsed ⏱');
      notifyListeners();
    });
  }

  final AuthStateNotifier authState;
  final PermissionsCoordinator permissionsCoordinator;

  bool _splashDelayElapsed = false;

  bool get splashDelayElapsed => _splashDelayElapsed;

  void _onSourceChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    authState.removeListener(_onSourceChanged);
    permissionsCoordinator.removeListener(_onSourceChanged);
    super.dispose();
  }
}

/// * AppRouterConfig
///
/// High-level configuration object that owns the [GoRouter] instance and
/// wires together:
/// - [RouterRefreshListenable]
/// - [AppRouteRegistry]
/// - [AppRouteGuard]
@lazySingleton
class AppRouterConfig {
  AppRouterConfig(
    this._authState,
    this._permissionsCoordinator,
    this._routeRegistry,
  ) {
    _refresh = RouterRefreshListenable(
      authState: _authState,
      permissionsCoordinator: _permissionsCoordinator,
    );

    _guard = AppRouteGuard(
      authState: _authState,
      permissionsCoordinator: _permissionsCoordinator,
      splashPath: SplashScreen.pagePath,
      loginPath: AdminLoginScreen.pagePath,
      forceResetPath: ForcePasswordResetScreen.pagePath,
      permissionGatePath: PermissionGateScreen.pagePath,
      rootPath: RootScreen.pagePath,
    );

    _router = GoRouter(
      // * Initial route is the splash screen.
      initialLocation: SplashScreen.pagePath,
      routes: _routeRegistry.routes,
      refreshListenable: _refresh,
      redirect: (context, state) => _guard.handleRedirect(
        state: state,
        splashDelayElapsed: _refresh.splashDelayElapsed,
      ),
    );
  }

  final AuthStateNotifier _authState;
  final PermissionsCoordinator _permissionsCoordinator;
  final AppRouteRegistry _routeRegistry;

  late final RouterRefreshListenable _refresh;
  late final AppRouteGuard _guard;
  late final GoRouter _router;

  GoRouter get router => _router;
}

/// * AppRouteGuard
///
/// Isolated class that owns all redirect / guard logic for the router so
/// the rules stay in one focused place instead of being spread across
/// multiple functions.
class AppRouteGuard {
  AppRouteGuard({
    required this.authState,
    required this.permissionsCoordinator,
    required this.splashPath,
    required this.loginPath,
    required this.forceResetPath,
    required this.permissionGatePath,
    required this.rootPath,
  });

  final AuthStateNotifier authState;
  final PermissionsCoordinator permissionsCoordinator;
  final String splashPath;
  final String loginPath;
  final String forceResetPath;
  final String permissionGatePath;
  final String rootPath;

  /// * Central route-guard / redirect logic.
  ///
  /// Rules:
  /// - While status is [Status.initial] OR splash delay not elapsed → stay on
  ///   splash.
  /// - If onboarding enabled and not finished → go to onboarding.
  /// - After onboarding:
  ///   - If auth enabled:
  ///     - unauthenticated → login
  ///     - authenticated → root
  ///   - If auth disabled → root
  FutureOr<String?> handleRedirect({
    required GoRouterState state,
    required bool splashDelayElapsed,
  }) async {
    final currentPath = state.matchedLocation;
    final status = authState.authStatus.status;
    final isGuest = authState.isGuest;
    final isAuthenticated = status == Status.authenticated && !isGuest;
    final canEnterApp = isAuthenticated || isGuest;

    printM(
      '${RouterLogTags.redirect} currentPath="$currentPath" '
      'status=$status isGuest=$isGuest',
    );

    // 1) Splash / initial state.
    final splashRedirect = _handleSplash(
      currentPath: currentPath,
      status: status,
      splashDelayElapsed: splashDelayElapsed,
    );
    if (splashRedirect != null) return splashRedirect;

    // Important: while splash is still active (delay not elapsed OR auth status
    // still bootstrapping), we must NOT run onboarding/auth redirects.
    // Otherwise GoRouter can immediately redirect away from the splash route
    // before the first frame is painted, making the splash appear to never show.
    if (!splashDelayElapsed || status == Status.initial) {
      return null;
    }

    // 2) Auth.
    final authRedirect = _handleAuth(
      currentPath: currentPath,
      canEnterApp: canEnterApp,
    );
    if (authRedirect != null) return authRedirect;

    // 3) Permission Gate.
    final permissionRedirect = await _handlePermissionGate(
      currentPath: currentPath,
    );
    if (permissionRedirect != null) return permissionRedirect;

    return null;
  }

  String? _handleSplash({
    required String currentPath,
    required Status status,
    required bool splashDelayElapsed,
  }) {
    if (!splashDelayElapsed || status == Status.initial) {
      if (currentPath != splashPath) {
        printC('${RouterLogTags.redirect} → splash (bootstrapping)');
        return splashPath;
      }
      return null;
    }
    return null;
  }

  Future<String?> _handlePermissionGate({required String currentPath}) async {
    if (!AppFlowConfig.permissionGateEnabled) {
      return null;
    }

    final hasForeground = await permissionsCoordinator
        .isForegroundLocationGranted();
    if (!hasForeground) {
      if (currentPath != permissionGatePath &&
          currentPath != splashPath &&
          currentPath != loginPath &&
          currentPath != forceResetPath &&
          currentPath != KycScreen.pagePath) {
        printC(
          '${RouterLogTags.redirect} → permission gate (location required)',
        );
        return permissionGatePath;
      }
      return null;
    }

    // If they have the permission and are trying to enter the permission gate, redirect to root
    if (currentPath == permissionGatePath) {
      printG('${RouterLogTags.redirect} permission already granted → root');
      return rootPath;
    }

    return null;
  }

  String? _handleAuth({
    required String currentPath,
    required bool canEnterApp,
  }) {
    if (!AppFlowConfig.authEnabled) {
      if (currentPath != rootPath) {
        printG('${RouterLogTags.redirect} auth disabled → root');
        return rootPath;
      }
      return null;
    }

    if (!canEnterApp) {
      if (currentPath != loginPath) {
        printY('${RouterLogTags.redirect} unauthenticated → login');
        return loginPath;
      }
      return null;
    }

    final user = authState.user;
    final requiresPasswordReset = user?.requiresPasswordReset == true;

    if (requiresPasswordReset) {
      if (currentPath != forceResetPath) {
        printY('${RouterLogTags.redirect} password reset required');
        return forceResetPath;
      }
      return null;
    }

    if (currentPath == forceResetPath) {
      printG('${RouterLogTags.redirect} password reset complete → root');
      return rootPath;
    }

    // KYC Status Guards
    final isDriver = user?.role == 'Driver';
    final isKycApproved = user?.approvalStatus == 'Approved';
    final isAdmin = user?.role == 'Admin';

    if (isDriver && !isKycApproved && !isAdmin) {
      if (currentPath != KycScreen.pagePath) {
        printY(
          '${RouterLogTags.redirect} KYC Not Approved (${user?.approvalStatus}) → KycScreen',
        );
        return KycScreen.pagePath;
      }
      return null;
    }

    // Prevent verified users/admins from staying on KycScreen
    if (currentPath == KycScreen.pagePath && (isKycApproved || isAdmin)) {
      printG('${RouterLogTags.redirect} KYC Approved/Admin → root');
      return rootPath;
    }

    // Let the permission gate live — it navigates to root itself on grant.
    if (currentPath == permissionGatePath) {
      return null;
    }

    if (currentPath == splashPath || currentPath == loginPath) {
      printG('${RouterLogTags.redirect} authenticated → permission gate');
      return permissionGatePath;
    }

    return null;
  }
}
