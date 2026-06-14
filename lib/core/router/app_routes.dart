part of 'router_config.dart';

/// * AppRouteRegistry
///
/// Single-responsibility class that knows how to register all core
/// app routes. Screen-specific files will eventually expose their own
/// static `routePath` / `routeName` and this registry will simply
/// reference them.
@lazySingleton
class AppRouteRegistry {
  const AppRouteRegistry();

  /// * All GoRouter routes for the app.
  List<GoRoute> get routes => [
    GoRoute(
      path: SplashScreen.pagePath,
      name: SplashScreen.pageName,
      pageBuilder: (context, state) =>
          AppPageTransitions.build(state: state, child: const SplashScreen()),
    ),
    GoRoute(
      path: LoginScreen.pagePath,
      name: LoginScreen.pageName,
      pageBuilder: (context, state) =>
          AppPageTransitions.build(state: state, child: const LoginScreen()),
    ),
    GoRoute(
      path: AdminLoginScreen.pagePath,
      name: AdminLoginScreen.pageName,
      pageBuilder: (context, state) => AppPageTransitions.build(
        state: state,
        child: const AdminLoginScreen(),
      ),
    ),
    GoRoute(
      path: ForcePasswordResetScreen.pagePath,
      name: ForcePasswordResetScreen.pageName,
      pageBuilder: (context, state) => AppPageTransitions.build(
        state: state,
        child: const ForcePasswordResetScreen(),
      ),
    ),
    GoRoute(
      path: PermissionGateScreen.pagePath,
      name: PermissionGateScreen.pageName,
      pageBuilder: (context, state) => AppPageTransitions.build(
        state: state,
        child: const PermissionGateScreen(),
      ),
    ),
    GoRoute(
      path: RootScreen.pagePath,
      name: RootScreen.pageName,
      pageBuilder: (context, state) =>
          AppPageTransitions.build(state: state, child: const RootScreen()),
    ),
    GoRoute(
      path: DashboardScreen.pagePath,
      name: DashboardScreen.pageName,
      pageBuilder: (context, state) => AppPageTransitions.build(
        state: state,
        child: const DashboardScreen(),
      ),
    ),
    GoRoute(
      path: DashboardLiveMapScreen.pagePath,
      name: DashboardLiveMapScreen.pageName,
      pageBuilder: (context, state) => AppPageTransitions.build(
        state: state,
        child: const DashboardLiveMapScreen(),
      ),
    ),
    GoRoute(
      path: DashboardTripsScreen.pagePath,
      name: DashboardTripsScreen.pageName,
      pageBuilder: (context, state) => AppPageTransitions.build(
        state: state,
        child: const DashboardTripsScreen(),
      ),
    ),
    GoRoute(
      path: KycScreen.pagePath,
      name: KycScreen.pageName,
      pageBuilder: (context, state) =>
          AppPageTransitions.build(state: state, child: const KycScreen()),
    ),
    GoRoute(
      path: ControlCenterScreen.pagePath,
      name: ControlCenterScreen.pageName,
      pageBuilder: (context, state) => AppPageTransitions.build(
        state: state,
        child: const ControlCenterScreen(),
      ),
    ),
    GoRoute(
      path: CompanyContactScreen.pagePath,
      name: CompanyContactScreen.pageName,
      pageBuilder: (context, state) => AppPageTransitions.build(
        state: state,
        child: const CompanyContactScreen(),
      ),
    ),
    GoRoute(
      path: CreateAdminScreen.pagePath,
      name: CreateAdminScreen.pageName,
      pageBuilder: (context, state) => AppPageTransitions.build(
        state: state,
        child: const CreateAdminScreen(),
      ),
    ),
    GoRoute(
      path: CompensationClaimsScreen.pagePath,
      name: CompensationClaimsScreen.pageName,
      pageBuilder: (context, state) => AppPageTransitions.build(
        state: state,
        child: const CompensationClaimsScreen(),
      ),
    ),
    GoRoute(
      path: SendNotificationScreen.pagePath,
      name: SendNotificationScreen.pageName,
      pageBuilder: (context, state) => AppPageTransitions.build(
        state: state,
        child: const SendNotificationScreen(),
      ),
    ),
    GoRoute(
      path: ChangePasswordScreen.pagePath,
      name: ChangePasswordScreen.pageName,
      pageBuilder: (context, state) => AppPageTransitions.build(
        state: state,
        child: const ChangePasswordScreen(),
      ),
    ),
  ];
}
