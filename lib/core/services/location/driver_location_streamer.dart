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

/// Service responsible for high-frequency location streaming while the driver is Online.
///
/// Automatically establishes a SignalR connection to `LocationTrackingHub` at `/hubs/location`.
/// Periodically streams GPS coordinates every 10 seconds.
/// If SignalR is disconnected or fails, it automatically falls back to HTTP REST API updates.
@lazySingleton
class DriverLocationStreamer {
  DriverLocationStreamer(
    this._locationService,
    this._tokenStorage,
    this._driverFacade,
  );

  static const String _hubPath = '/hubs/location';
  static const String _logTag = '[DriverLocationStreamer]';

  final LocationService _locationService;
  final JwtTokenStorage _tokenStorage;
  final DriverFacade _driverFacade;

  HubConnection? _connection;
  StreamSubscription<Position>? _positionSub;
  Timer? _streamTimer;
  Position? _lastPosition;
  bool _isTracking = false;

  bool get isTracking => _isTracking;

  /// Starts the tracking flow.
  ///
  /// Connects to SignalR `LocationTrackingHub`, starts listening to Geolocator
  /// and initiates the 10-second streaming timer.
  Future<void> startTracking() async {
    if (_isTracking) return;
    _isTracking = true;
    printG('$_logTag starting location tracking...');

    // 1. Clear any active states
    _stopComponents();

    // 2. Start Geolocator listening to collect live updates
    _positionSub = _locationService.getPositionStream(
      distanceFilter: 5, // update last known position if driver moves 5 meters
    ).listen((position) {
      _lastPosition = position;
    }, onError: (Object error) {
      printR('$_logTag geolocator error: $error');
    });

    // 3. Connect to SignalR LocationTrackingHub
    await _connectHub();

    // 4. Send initial position immediately if possible
    try {
      final initialPosition = await _locationService.getCurrentPosition();
      _lastPosition = initialPosition;
      await _sendLocation(initialPosition.latitude, initialPosition.longitude);
    } catch (e) {
      printY('$_logTag failed to send initial position: $e');
    }

    // 5. Start the throttled 10-second periodic streamer
    _streamTimer = Timer.periodic(const Duration(seconds: 10), (_) async {
      final pos = _lastPosition;
      if (pos == null) {
        printY('$_logTag no position recorded yet, skipping periodic update');
        return;
      }
      await _sendLocation(pos.latitude, pos.longitude);
    });
  }

  /// Stops tracking, cancels streams and disconnects the SignalR socket.
  Future<void> stopTracking() async {
    if (!_isTracking) return;
    _isTracking = false;
    printY('$_logTag stopping location tracking...');
    _stopComponents();
    _lastPosition = null;
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
    final token = _tokenStorage.cachedToken?.accessToken ?? '';

    try {
      _connection = HubConnectionBuilder()
          .withUrl(
            url,
            options: HttpConnectionOptions(
              accessTokenFactory: () async => token,
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
      printR('$_logTag SignalR start failed: $e. Fallback REST updates will trigger.');
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
