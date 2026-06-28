import 'dart:async';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart'
    show SystemChrome, SystemUiMode, appFlavor;
import 'firebase_options.dart';
import 'core/config/localization_config.dart';
import 'core/injection/injectable.dart';
import 'core/notification/notification_config.dart';
import 'core/notification/notification_coordinator.dart';
import 'core/notification/notification_init_options.dart';
import 'core/notification/notification_payload.dart';
import 'core/router/router_config.dart';
import 'core/services/localization/locale_service.dart';
import 'core/services/media/media_picker_service.dart';
import 'core/services/session/auth_manager.dart';
import 'package:dashboardtaxi/core/services/realtime/realtime_lifecycle_coordinator.dart';
import 'package:dashboardtaxi/core/utils/result.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/chat/presentation/ui/screens/trip_chat_screen.dart';
import 'features/dashboard/presentation/ui/screens/dashboard_trips_screen.dart';
import 'features/root/presentation/ui/screens/root_screen.dart';
import 'features/trip/presentation/states/trip_bloc.dart';
import 'core/theme/theme_controller.dart';
import 'common/widgets/stage_tools/stage_device_preview_controller.dart';
import 'flavors.dart' show F, Flavor;
import 'utils/constants/design_constants.dart';
import 'utils/helpers/colored_print.dart';

/// Common bootstrap entry point used by all flavors.
///
/// This function wires together all low-level initialization steps:
///
/// - Ensures Flutter bindings are initialized.
/// - Initializes EasyLocalization's core infrastructure.
/// - Configures dependency injection via Injectable / GetIt.
/// - Prepares the [AuthManager] and global Dio client.
/// - Resolves the initial locale using [LocaleService].
/// - Runs the provided widget tree inside a guarded zone with
///   EasyLocalization and the active [Flavor].
Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  // Important: keep `ensureInitialized` and `runApp` inside the same zone.
  await runZonedGuarded<Future<void>>(
    () async {
      //    Ensure Flutter engine + widget binding are ready before any
      //    plugins or framework APIs are used.
      WidgetsFlutterBinding.ensureInitialized();
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      await appMediaPickerService.initialize();

      // Select the active flavor (stage / production) based on the
      // compile-time value provided by the native layer.
      F.appFlavor = Flavor.values.firstWhere(
        (element) => element.name == appFlavor,
        orElse: () => Flavor.stage,
      );

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      //    Configure the dependency injection container and register
      //    low-level services and singletons.
      await configureDependencies();

      if (F.appFlavor == Flavor.stage) {
        if (!getIt.isRegistered<StageDevicePreviewController>()) {
          getIt.registerSingleton<StageDevicePreviewController>(
            StageDevicePreviewController(getIt()),
          );
        }
        await getIt<StageDevicePreviewController>().load();
      }

      await _initializeNotifications();

      await EasyLocalization.ensureInitialized();
      await getIt<ThemeController>().initialize();

      await _initializeAuthAndNetwork();

      //    Resolve the locale that the app should start with using
      //    the [LocaleService] abstraction.
      final initialLocale = await getIt<LocaleService>().resolveInitialLocale();

      await _runGuardedApp(builder, initialLocale);
    },
    (error, stackTrace) {
      // Last-resort safety net for any exceptions that happen outside
      // of Flutter's normal error handling pipeline.
      log('Uncaught application error', error: error, stackTrace: stackTrace);
    },
  );
}

/// Initializes notifications.
///
/// Note:
/// - Firebase/FCM initialization is controlled by [NotificationInitOptions]
///   passed to [NotificationCoordinator.initialize].
Future<void> _initializeNotifications() async {
  try {
    final coordinator = getIt<NotificationCoordinator>();

    await coordinator.initialize(
      config: AppNotificationConfig.defaults(),
      // Firebase is already initialized by bootstrap above, so we skip the
      // duplicate Firebase init that this module would otherwise perform.
      // FCM is on by default.
      options: const NotificationInitOptions(initializeFirebase: false),
      onNotificationTap: (payload) async {
        await _handleNotificationTap(payload);
      },
      onForegroundNotification: (payload) async {
        // Chat messages: the coordinator already showed the banner and the open
        // chat updates live over SignalR — don't refetch the active trip.
        if (_typeFromPayload(payload) == 'chat_message') return;
        _routeTripPayloadToBloc(payload);
      },
      onTokenRefresh: (token) async {
        await _syncFcmTokenToBackend(token);
      },
    );

    printG('[Bootstrap] Notifications initialized');
  } catch (e) {
    printY('[Bootstrap] Notifications initialize failed: $e');
  }
}

/// Handles a notification tap (cold-start, background, or foreground).
///
/// Order matters:
/// 1) If the payload references a trip, hand it to [TripBloc] so the active
///    trip is fetched and the staged sheet opens at the right stage.
/// 2) Navigate to the route/deep-link if provided, falling back to the
///    root screen when the payload only carries a trip id.
Future<void> _handleNotificationTap(AppNotificationPayload payload) async {
  // Chat message tapped — open the active trip so the user can read/reply.
  if (_typeFromPayload(payload) == 'chat_message') {
    final chatTripId = _tripIdFromPayload(payload);
    if (chatTripId != null) _routeTripPayloadToBloc(payload);
    if (chatTripId != null) {
      await _navigateToChatWhenReady(chatTripId);
    }
    return;
  }

  final tripId = _tripIdFromPayload(payload);
  if (tripId != null) {
    _routeTripPayloadToBloc(payload);
  }

  final type = _typeFromPayload(payload);
  final explicitLocation = payload.toGoRouterLocation;
  final String? location;
  if (explicitLocation != null && explicitLocation.isNotEmpty) {
    // A server-provided route/deep-link always wins.
    location = explicitLocation;
  } else if (type == 'trip_awaiting_admin_acceptance' ||
      type == 'scheduled_trip_admin_reminder') {
    // Admin operational alerts → open the bookings/trips list for triage.
    location = DashboardTripsScreen.pagePath;
  } else if (tripId != null) {
    // Trip-scoped alert with no explicit route → open the root (staged sheet).
    location = RootScreen.pagePath;
  } else {
    location = null;
  }

  if (location == null) {
    printC('[Notifications] Tap ignored (no route/deepLink/tripId)');
    return;
  }

  await _navigateWhenReady(location);
}

/// Navigates to [location] once the session and router are ready.
///
/// On a cold start (tap on a terminated app) the router is still on splash and
/// the auth redirect can bounce an immediate `go`. Waiting for auth + a live
/// navigator context ensures the deep-link actually lands on the target screen.
/// When the app is already running this passes on the first attempt.
Future<void> _navigateWhenReady(String location) async {
  for (var attempt = 0; attempt < 30; attempt++) {
    final authManager = getIt<AuthManager>();
    final router = getIt<AppRouterConfig>().router;
    if (authManager.isAuthenticated &&
        router.routerDelegate.navigatorKey.currentContext != null) {
      try {
        router.go(location);
        printG('[Notifications] Navigated to $location');
      } catch (e) {
        printY('[Notifications] Navigation failed: $e (location=$location)');
      }
      return;
    }
    await Future<void>.delayed(const Duration(milliseconds: 500));
  }
  // Best-effort fallback if readiness was never confirmed within the window.
  try {
    getIt<AppRouterConfig>().router.go(location);
  } catch (_) {}
}

Future<void> _navigateToChatWhenReady(String tripId) async {
  for (var attempt = 0; attempt < 30; attempt++) {
    final authManager = getIt<AuthManager>();
    final router = getIt<AppRouterConfig>().router;
    if (authManager.isAuthenticated &&
        router.routerDelegate.navigatorKey.currentContext != null) {
      router.goNamed(
        TripChatScreen.pageName,
        extra: TripChatScreenArgs(tripId: tripId),
      );
      return;
    }
    await Future<void>.delayed(const Duration(milliseconds: 500));
  }
  getIt<AppRouterConfig>().router.go(RootScreen.pagePath);
}

/// If the payload contains a `tripId`, ask the singleton [TripBloc] to fetch
/// it so the staged sheet renders in the correct stage. Called from both the
/// tap handler and the foreground push handler.
void _routeTripPayloadToBloc(AppNotificationPayload payload) {
  final tripId = _tripIdFromPayload(payload);
  if (tripId == null) return;
  try {
    getIt<TripBloc>().add(TripEvent.fetchActiveRequested(tripId));
    printG('[Notifications] Trip arrival routed to bloc tripId=$tripId');
  } catch (e) {
    printY('[Notifications] Trip routing failed: $e');
  }
}

String? _typeFromPayload(AppNotificationPayload payload) {
  final raw = payload.data['type'] ?? payload.data['Type'];
  if (raw is String && raw.trim().isNotEmpty) return raw.trim().toLowerCase();
  return null;
}

String? _tripIdFromPayload(AppNotificationPayload payload) {
  final raw =
      payload.data['tripId'] ??
      payload.data['TripId'] ??
      payload.data['trip_id'];
  if (raw is String && raw.trim().isNotEmpty) return raw;
  if (raw != null) {
    final asString = raw.toString();
    if (asString.trim().isNotEmpty) return asString;
  }
  return null;
}

Future<void> _syncFcmTokenToBackend(String token) async {
  final authManager = getIt<AuthManager>();
  if (!authManager.isAuthenticated) {
    printC('[Notifications] FCM token refreshed; deferred (not authenticated)');
    return;
  }

  await authManager.syncNotificationTopicsForCurrentUser();

  try {
    await getIt<AuthRepository>().updateFcmToken(token);
    printG('[Notifications] FCM token synced to backend');
  } catch (e) {
    printY('[Notifications] FCM token sync failed: $e');
  }
}

/// Initializes the authentication layer and HTTP client.
///
/// Responsibilities:
/// - Creates and registers a single [AuthManager] instance.
/// - Awaits [AuthManager.initialize] so user/guest and token state are
///   loaded before the UI starts.
/// - Creates and registers a global Dio client so repositories can perform
///   network calls immediately.
Future<void> _initializeAuthAndNetwork() async {
  final authManager = getIt<AuthManager>();
  await authManager.initialize();
  getIt<RealtimeLifecycleCoordinator>().start();

  // Startup FCM token backup: if the user is already authenticated when the
  // app launches, push the currently cached token to the backend. This covers
  // two real cases:
  //   - The OS rotated the token while the app was closed (no onTokenRefresh
  //     callback fired in that window).
  //   - A prior on-login submission silently failed.
  // The runtime onTokenRefresh callback still handles in-session rotations.
  if (authManager.isAuthenticated) {
    try {
      final coordinator = getIt<NotificationCoordinator>();
      final token = await coordinator.getDeviceToken();
      if (token != null && token.isNotEmpty) {
        final result = await getIt<AuthRepository>().updateFcmToken(token);
        result.when(
          success: (_) => printG('[Bootstrap] Startup FCM token backup synced'),
          failure: (msg) =>
              printY('[Bootstrap] Startup FCM token backup failed: $msg'),
        );
      }
    } catch (e) {
      printY('[Bootstrap] Startup FCM token backup failed: $e');
    }

    // Re-verify if still authenticated (FCM sync or token refresh could have triggered logout)
    if (authManager.isAuthenticated) {
      try {
        final localeService = getIt<LocaleService>();
        final code = await localeService.currentLanguageCode();
        final result = await getIt<AuthRepository>().updatePreferredLanguage(
          code,
        );
        result.when(
          success: (_) =>
              printG('[Bootstrap] Startup language backup synced: $code'),
          failure: (msg) =>
              printY('[Bootstrap] Startup language backup failed: $msg'),
        );
      } catch (e) {
        printY('[Bootstrap] Startup language backup failed: $e');
      }
    }
  }
}

/// Runs the application inside a guarded zone and wraps it with
/// [EasyLocalization].
///
/// Parameters:
/// - [builder]: Factory that constructs the root widget tree.
/// - [initialLocale]: Locale that should be used as the starting
///   locale for the app.
///
/// This function also assigns the current [Flavor] based on the
/// native `appFlavor` and logs any uncaught errors via [log].
Future<void> _runGuardedApp(
  FutureOr<Widget> Function() builder,
  Locale initialLocale,
) async {
  // Build the actual root widget tree provided by the caller.
  final app = await builder();

  // Wrap the root app with EasyLocalization and ScreenUtil so that:
  // - Localized strings are available everywhere.
  // - The app starts with the resolved [initialLocale].
  // - Responsive sizing via ScreenUtil is available globally.
  final localizedApp = EasyLocalization(
    supportedLocales: AppLocalizationConfig.supportedLanguageCodes
        .map((code) => Locale(code))
        .toList(),
    path: AppLocalizationConfig.translationsPath,
    fallbackLocale: const Locale(AppLocalizationConfig.fallbackLanguageCode),
    startLocale: initialLocale,
    saveLocale: false,
    useOnlyLangCode: true,
    child: ScreenUtilInit(
      designSize: AppDesign.designSize,
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      fontSizeResolver: (fontSize, instance) {
        final width = instance.screenWidth;
        //TODO make this logic const to be used in any other plce the width values i mean
        double factor;
        if (width <= 320) {
          factor = 0.9;
        } else if (width <= 360) {
          factor = 0.95;
        } else if (width <= 400) {
          factor = 1.0;
        } else if (width <= 480) {
          factor = 1.05;
        } else {
          factor = 1.1;
        }

        return fontSize * factor;
      },
      builder: (context, _) => app,
    ),
  );

  // Finally render the localized app tree.
  runApp(localizedApp);
}
