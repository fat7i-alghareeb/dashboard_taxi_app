import 'dart:async';

import 'package:dio_refresh_bot/dio_refresh_bot.dart' show AuthStatus, Status;
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

import '../../../utils/helpers/colored_print.dart';
import '../session/auth_manager.dart';
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
///    * `paused` / `detached` / `hidden` → disconnect (no zombie sockets
///      while the OS suspends us).
///    * `resumed` → reconnect, but only if auth is currently authenticated.
@lazySingleton
class RealtimeLifecycleCoordinator with WidgetsBindingObserver {
  RealtimeLifecycleCoordinator(
    this._service,
    this._authManager,
  );

  static const String _logTag = '[Realtime/Lifecycle]';

  final RealtimeService _service;
  final AuthManager _authManager;

  StreamSubscription<AuthStatus>? _authSub;
  bool _started = false;

  /// Subscribes to auth + app lifecycle. Idempotent.
  void start() {
    if (_started) return;
    _started = true;

    WidgetsBinding.instance.addObserver(this);
    _authSub = _authManager.authStatusStream.listen(_onAuthStatus);

    // Best-effort initial connect: the auth stream only emits on changes,
    // so if we are already authenticated at startup we need to kick a
    // connect now.
    if (_authManager.isAuthenticated) {
      printC('$_logTag authenticated at startup — connecting');
      unawaited(_service.connect());
    }
  }

  Future<void> stop() async {
    if (!_started) return;
    _started = false;
    WidgetsBinding.instance.removeObserver(this);
    await _authSub?.cancel();
    _authSub = null;
    await _service.disconnect();
  }

  void _onAuthStatus(AuthStatus status) {
    switch (status.status) {
      case Status.authenticated:
        printC('$_logTag auth -> authenticated, connecting');
        unawaited(_service.connect());
        break;
      case Status.unauthenticated:
        printY('$_logTag auth -> unauthenticated, disconnecting');
        unawaited(_service.disconnect());
        break;
      case Status.initial:
        // Wait until auth resolves.
        break;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        if (_authManager.isAuthenticated) {
          printC('$_logTag app resumed, reconnecting');
          unawaited(_service.connect());
        }
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        printY('$_logTag app $state, disconnecting');
        unawaited(_service.disconnect());
        break;
      case AppLifecycleState.inactive:
        // Transient — do nothing.
        break;
    }
  }
}
