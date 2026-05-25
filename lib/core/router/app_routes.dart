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
      path: ForcePasswordResetScreen.pagePath,
      name: ForcePasswordResetScreen.pageName,
      pageBuilder: (context, state) => AppPageTransitions.build(
        state: state,
        child: const ForcePasswordResetScreen(),
      ),
    ),
    GoRoute(
      path: RootScreen.pagePath,
      name: RootScreen.pageName,
      pageBuilder: (context, state) =>
          AppPageTransitions.build(state: state, child: const RootScreen()),
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
      path: DashboardAdminOperationsScreen.pagePath,
      name: DashboardAdminOperationsScreen.pageName,
      pageBuilder: (context, state) => AppPageTransitions.build(
        state: state,
        child: const DashboardAdminOperationsScreen(),
      ),
    ),
    GoRoute(
      path: KycScreen.pagePath,
      name: KycScreen.pageName,
      pageBuilder: (context, state) =>
          AppPageTransitions.build(state: state, child: const KycScreen()),
    ),
  ];
}
