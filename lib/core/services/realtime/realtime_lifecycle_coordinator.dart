import 'dart:async';

import 'package:dio_refresh_bot/dio_refresh_bot.dart' show AuthStatus, Status;
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

import '../../../utils/helpers/colored_print.dart';
import '../../domain/extensions/user_role_extensions.dart';
import '../session/auth_manager.dart';
import 'realtime_connection_state.dart';
import 'realtime_service.dart';

/// Owns the realtime connection lifecycle.
///
/// Single source of truth for when [RealtimeService.connect] /
/// [RealtimeService.disconnect] is called. Features must NOT touch the
/// service directly for lifecycle — they only consume events and trip
/// groups.
///
/// Wires two triggers:
///
/// 1. **Auth state** (via [AuthManager.authStatusStream]):
///    * `Status.authenticated` → connect.
///    * `Status.unauthenticated` → disconnect.
///
/// 2. **App lifecycle** (via [WidgetsBindingObserver]):
///    * `paused` / `hidden` → defer disconnect by [_backgroundGrace]. If the
///      user returns within the window the live socket is kept (a short app
///      switch must not tear realtime down); only after the window elapses do
///      we disconnect to avoid zombie sockets while the OS suspends us.
///    * `detached` → disconnect immediately (the app is terminating).
///    * `resumed` → cancel any pending background disconnect and reconnect
///      (idempotent — a no-op when the socket is still alive), but only if
///      auth is currently authenticated.
@lazySingleton
class RealtimeLifecycleCoordinator with WidgetsBindingObserver {
  RealtimeLifecycleCoordinator(
    this._service,
    this._authManager,
  );

  static const String _logTag = '[Realtime/Lifecycle]';

  /// How long the socket is kept alive after the app is backgrounded before we
  /// proactively disconnect. Covers quick app switches, checking a
  /// notification, taking a call, copying an address, etc. Long backgrounds are
  /// still covered by FCM push.
  static const Duration _backgroundGrace = Duration(minutes: 10);

  final RealtimeService _service;
  final AuthManager _authManager;

  StreamSubscription<AuthStatus>? _authSub;
  StreamSubscription<RealtimeConnectionState>? _connectionSub;
  Timer? _backgroundDisconnectTimer;
  String? _subscribedVehicleTypeId;
  bool _started = false;

  /// Subscribes to auth + app lifecycle. Idempotent.
  void start() {
    if (_started) return;
    _started = true;

    WidgetsBinding.instance.addObserver(this);
    _authSub = _authManager.authStatusStream.listen(_onAuthStatus);
    _connectionSub = _service.connectionState.listen((state) {
      if (state == RealtimeConnectionState.connected) {
        unawaited(_syncDriverVehicleGroup());
      }
    });

    // Best-effort initial connect: the auth stream only emits on changes,
    // so if we are already authenticated at startup we need to kick a
    // connect now.
    if (_authManager.isAuthenticated) {
      printC('$_logTag authenticated at startup — connecting');
      unawaited(_connectAndSyncDriverGroup());
    }
  }

  Future<void> stop() async {
    if (!_started) return;
    _started = false;
    WidgetsBinding.instance.removeObserver(this);
    _cancelBackgroundDisconnect();
    await _authSub?.cancel();
    _authSub = null;
    await _connectionSub?.cancel();
    _connectionSub = null;
    _subscribedVehicleTypeId = null;
    await _service.disconnect();
  }

  void _onAuthStatus(AuthStatus status) {
    switch (status.status) {
      case Status.authenticated:
        printC('$_logTag auth -> authenticated, connecting');
        _cancelBackgroundDisconnect();
        unawaited(_connectAndSyncDriverGroup());
        break;
      case Status.unauthenticated:
        printY('$_logTag auth -> unauthenticated, disconnecting');
        _cancelBackgroundDisconnect();
        unawaited(_service.disconnect());
        break;
      case Status.initial:
        // Wait until auth resolves.
        break;
    }
  }

  Future<void> _connectAndSyncDriverGroup() async {
    await _service.connect();
    await _syncDriverVehicleGroup();
  }

  Future<void> _syncDriverVehicleGroup() async {
    final user = _authManager.currentUser;
    final nextVehicleTypeId =
        user?.isDriver == true &&
            user?.approvalStatus?.toLowerCase() == 'approved'
        ? user?.vehicleTypeId
        : null;

    final previous = _subscribedVehicleTypeId;
    if (previous != null && previous != nextVehicleTypeId) {
      await _service.leaveVehicleTypeGroup(previous);
      _subscribedVehicleTypeId = null;
    }
    if (nextVehicleTypeId != null &&
        nextVehicleTypeId.isNotEmpty &&
        nextVehicleTypeId != _subscribedVehicleTypeId) {
      await _service.joinVehicleTypeGroup(nextVehicleTypeId);
      _subscribedVehicleTypeId = nextVehicleTypeId;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _cancelBackgroundDisconnect();
        if (_authManager.isAuthenticated) {
          // Idempotent: no-op when the socket survived the background, real
          // reconnect only if the OS dropped it.
          printC('$_logTag app resumed, ensuring connection');
          unawaited(_connectAndSyncDriverGroup());
        }
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
        _scheduleBackgroundDisconnect(state);
        break;
      case AppLifecycleState.detached:
        // App is terminating — drop the socket now, no grace period.
        printY('$_logTag app detached, disconnecting');
        _cancelBackgroundDisconnect();
        unawaited(_service.disconnect());
        break;
      case AppLifecycleState.inactive:
        // Transient — do nothing.
        break;
    }
  }

  /// Defers the disconnect by [_backgroundGrace] so a short background does not
  /// tear the socket down. Idempotent: a timer already in flight is kept.
  void _scheduleBackgroundDisconnect(AppLifecycleState state) {
    if (_backgroundDisconnectTimer != null) return;
    printY(
      '$_logTag app $state, disconnecting in '
      '${_backgroundGrace.inMinutes}m if still backgrounded',
    );
    _backgroundDisconnectTimer = Timer(_backgroundGrace, () {
      _backgroundDisconnectTimer = null;
      printY('$_logTag background grace elapsed, disconnecting');
      unawaited(_service.disconnect());
    });
  }

  void _cancelBackgroundDisconnect() {
    _backgroundDisconnectTimer?.cancel();
    _backgroundDisconnectTimer = null;
  }
}
