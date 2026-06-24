import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

import 'package:dashboardtaxi/core/utils/result.dart';
import '../../../utils/helpers/colored_print.dart';
import '../../network/api_config.dart';
import '../session/jwt_token_storage.dart';
import 'location_service.dart';
import 'package:dashboardtaxi/features/driver/domain/facade/driver_facade.dart';

/// Why location is currently being streamed. Multiple reasons can be active at
/// once (e.g. an online driver who also has an active trip); streaming stops only
/// once every reason has been cleared so one concern never cancels another.
enum LocationTrackingReason {
  /// Driver toggled Online and is broadcasting for the dispatch radar.
  online,

  /// An active trip is in a moving state (EnRoute/Arrived/InProgress) and the
  /// customer must see the driver. Enables background (foreground-service) survival.
  activeTrip,
}

/// Service responsible for high-frequency location streaming.
///
/// Automatically establishes a SignalR connection to `LocationTrackingHub` at `/hubs/location`.
/// Periodically streams GPS coordinates every 10 seconds.
/// If SignalR is disconnected or fails, it automatically falls back to HTTP REST API updates.
///
/// Streaming is reference-counted by [LocationTrackingReason]. While an active trip
/// is being tracked the position stream runs as an Android foreground service / iOS
/// background updates so it keeps broadcasting when the app is minimized.
@lazySingleton
class DriverLocationStreamer {
  DriverLocationStreamer(
    this._locationService,
    this._tokenStorage,
    this._driverFacade,
  );

  static const String _hubPath = '/hubs/location';
  static const String _logTag = '[DriverLocationStreamer]';

  /// Minimum gap between consecutive sends. Keeps the customer's map updating
  /// near-continuously (~1 Hz) while the driver moves, without flooding the hub.
  static const Duration _minSendInterval = Duration(milliseconds: 1000);

  /// Heartbeat that re-sends the last position while the driver is stationary
  /// (the GPS stream goes quiet) and keeps the hub connection warm.
  static const Duration _heartbeatInterval = Duration(seconds: 4);

  final LocationService _locationService;
  final JwtTokenStorage _tokenStorage;
  final DriverFacade _driverFacade;

  HubConnection? _connection;
  StreamSubscription<Position>? _positionSub;
  Timer? _streamTimer;
  Position? _lastPosition;
  DateTime? _lastSentAt;
  final Set<LocationTrackingReason> _reasons = <LocationTrackingReason>{};
  bool _backgroundEnabled = false;

  bool get isTracking => _reasons.isNotEmpty;

  /// True when the driver is broadcasting for the Online dispatch radar.
  bool get isOnlineTracking => _reasons.contains(LocationTrackingReason.online);

  /// Starts (or augments) the tracking flow for the given [reason].
  ///
  /// Connects to SignalR `LocationTrackingHub`, listens to Geolocator and runs the
  /// 10-second streaming timer. Idempotent per reason. Adding the [activeTrip] reason
  /// (re)configures the position stream to survive backgrounding.
  Future<void> startTracking({required LocationTrackingReason reason}) async {
    final alreadyTracking = _reasons.isNotEmpty;
    _reasons.add(reason);

    final needsBackground = _reasons.contains(
      LocationTrackingReason.activeTrip,
    );

    // Already running with the required background mode — nothing to do.
    if (alreadyTracking && needsBackground == _backgroundEnabled) {
      return;
    }

    printG('$_logTag starting location tracking (reasons=$_reasons)...');
    _backgroundEnabled = needsBackground;

    // 1. Clear any active component state (we re-create the geolocator subscription
    //    so a newly-required background/foreground mode takes effect).
    _stopComponents();

    // 2. Start Geolocator listening and stream every movement (continuous).
    //    distanceFilter:0 emits on each fix (~1 Hz while moving); _maybeSend
    //    throttles to _minSendInterval so the hub isn't flooded.
    _positionSub = _locationService
        .getPositionStream(
          distanceFilter:
              5, // update last known position if driver moves 5 meters
          keepAliveInBackground: needsBackground,
          foregroundNotificationText:
              'Sharing your live location with the rider',
        )
        .listen(
          (position) {
            _lastPosition = position;
            unawaited(_maybeSend(position.latitude, position.longitude));
          },
          onError: (Object error) {
            printR('$_logTag geolocator error: $error');
          },
        );

    // 3. Connect to SignalR LocationTrackingHub (skip if already connected)
    if (_connection == null) {
      await _connectHub();
    }

    // 4. Send initial position immediately if possible
    try {
      final initialPosition = await _locationService.getCurrentPosition();
      _lastPosition = initialPosition;
      await _sendLocation(initialPosition.latitude, initialPosition.longitude);
      _lastSentAt = DateTime.now();
    } catch (e) {
      printY('$_logTag failed to send initial position: $e');
    }

    // 5. Heartbeat: keep streaming the last position while the driver is
    //    stationary (no GPS movement events) and keep the socket warm.
    _streamTimer?.cancel();
    _streamTimer = Timer.periodic(_heartbeatInterval, (_) async {
      final pos = _lastPosition;
      if (pos == null) {
        printY('$_logTag no position recorded yet, skipping heartbeat');
        return;
      }
      await _maybeSend(pos.latitude, pos.longitude);
    });
  }

  /// Sends the coordinate unless one was sent within [_minSendInterval] — keeps
  /// updates near-continuous while moving without overwhelming the hub.
  Future<void> _maybeSend(double lat, double lng) async {
    final now = DateTime.now();
    final last = _lastSentAt;
    if (last != null && now.difference(last) < _minSendInterval) return;
    _lastSentAt = now;
    await _sendLocation(lat, lng);
  }

  /// Clears the given [reason]. Streaming fully stops only when no reason remains,
  /// so ending a trip never tears down an online driver's radar (and vice versa).
  Future<void> stopTracking({required LocationTrackingReason reason}) async {
    if (!_reasons.remove(reason)) return;

    if (_reasons.isNotEmpty) {
      printY(
        '$_logTag cleared reason=$reason; still tracking (reasons=$_reasons)',
      );
      // The background foreground-service is only needed for active trips. If the
      // active-trip reason is gone but online remains, downgrade to a normal stream.
      final needsBackground = _reasons.contains(
        LocationTrackingReason.activeTrip,
      );
      if (needsBackground != _backgroundEnabled) {
        await startTracking(reason: _reasons.first);
      }
      return;
    }

    printY('$_logTag stopping location tracking...');
    _stopComponents();
    _lastPosition = null;
    _lastSentAt = null;
    _backgroundEnabled = false;
  }

  void _stopComponents() {
    _streamTimer?.cancel();
    _streamTimer = null;

    _positionSub?.cancel();
    _positionSub = null;

    final hub = _connection;
    _connection = null;
    if (hub != null) {
      hub.stop().catchError((Object error) {
        printY('$_logTag error stopping hub: $error');
      });
    }
  }

  Future<void> _connectHub() async {
    final url = '${ApiConfig.baseUrl}$_hubPath';

    try {
      _connection = HubConnectionBuilder()
          .withUrl(
            url,
            options: HttpConnectionOptions(
              accessTokenFactory: () async =>
                  _tokenStorage.cachedToken?.accessToken ?? '',
            ),
          )
          .withAutomaticReconnect()
          .build();

      _connection?.onclose(({Exception? error}) {
        printY('$_logTag SignalR closed (error=$error)');
      });

      _connection?.onreconnecting(({Exception? error}) {
        printY('$_logTag SignalR reconnecting (error=$error)');
      });

      _connection?.onreconnected(({String? connectionId}) {
        printG('$_logTag SignalR reconnected ($connectionId)');
      });

      await _connection?.start();
      printG('$_logTag SignalR connection established');
    } catch (e) {
      printR(
        '$_logTag SignalR start failed: $e. Fallback REST updates will trigger.',
      );
    }
  }

  Future<void> _sendLocation(double lat, double lng) async {
    final hub = _connection;

    // A. Preferred Option: Stream via SignalR Hub if connected
    if (hub != null && hub.state == HubConnectionState.Connected) {
      try {
        await hub.invoke('UpdateLocation', args: <Object>[lat, lng]);
        printG('$_logTag Location streamed via SignalR ($lat, $lng)');
        return;
      } catch (e) {
        printR('$_logTag SignalR invocation failed: $e. Falling back to REST.');
      }
    }

    // B. Fallback Option: POST to REST Endpoint when SignalR is unavailable/failed
    printY('$_logTag REST backup triggered for coordinate ($lat, $lng)');
    final result = await _driverFacade.updateLocation(lat, lng);
    result.when(
      success: (_) {
        printG('$_logTag Location updated via REST fallback');
      },
      failure: (message) {
        printR('$_logTag REST fallback failed: $message');
      },
    );
  }
}
