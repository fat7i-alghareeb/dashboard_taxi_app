import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

import '../../../utils/helpers/colored_print.dart';
import '../../network/api_config.dart';
import '../session/jwt_token_storage.dart';
import 'realtime_connection_state.dart';
import 'realtime_event.dart';
import 'realtime_service.dart';

/// `signalr_netcore`-backed implementation of [RealtimeService].
///
/// Connects to the backend `TripHub` at `/hubs/trips`. The access token is
/// supplied on every (re)connect via [JwtTokenStorage], so refresh-bot
/// rotations are picked up automatically the next time the transport
/// reconnects.
@LazySingleton(as: RealtimeService)
class SignalRRealtimeService implements RealtimeService {
  SignalRRealtimeService(this._tokenStorage);

  static const String _hubPath = '/hubs/trips';
  static const String _logTag = '[Realtime]';
  static const int _requestTimeoutMs = 15000;
  static const Duration _retryDelay = Duration(seconds: 3);

  final JwtTokenStorage _tokenStorage;

  HubConnection? _connection;
  Future<void>? _pendingConnect;
  Timer? _retryTimer;
  bool _connectRequested = false;
  bool _explicitlyDisconnected = false;
  final Set<String> _joinedTripGroups = <String>{};

  final StreamController<RealtimeEvent> _eventsController =
      StreamController<RealtimeEvent>.broadcast();
  final StreamController<RealtimeConnectionState> _stateController =
      StreamController<RealtimeConnectionState>.broadcast();

  RealtimeConnectionState _state = RealtimeConnectionState.disconnected;

  @override
  Stream<RealtimeEvent> get events => _eventsController.stream;

  @override
  Stream<RealtimeConnectionState> get connectionState =>
      _stateController.stream;

  @override
  RealtimeConnectionState get currentConnectionState => _state;

  @override
  Future<void> connect() async {
    _connectRequested = true;
    _explicitlyDisconnected = false;
    _retryTimer?.cancel();
    _retryTimer = null;

    if (_state == RealtimeConnectionState.connected ||
        _state == RealtimeConnectionState.connecting) {
      return;
    }

    final pending = _pendingConnect;
    if (pending != null) return pending;

    final completer = Completer<void>();
    _pendingConnect = completer.future;
    _setState(RealtimeConnectionState.connecting);

    try {
      final hub = _buildConnection();
      _wireHandlers(hub);
      _connection = hub;
      await hub.start();
      if (_connection != hub || !_connectRequested || _explicitlyDisconnected) {
        await hub.stop();
        _setState(RealtimeConnectionState.disconnected);
        completer.complete();
        return;
      }
      _setState(RealtimeConnectionState.connected);
      printG('$_logTag connected');
      await _rejoinTripGroups();
      completer.complete();
    } catch (error, stack) {
      printR('$_logTag connect failed: $error');
      printR(stack.toString());
      _connection = null;
      _setState(RealtimeConnectionState.disconnected);
      completer.complete();
    } finally {
      _pendingConnect = null;
      if (_connectRequested &&
          !_explicitlyDisconnected &&
          _state == RealtimeConnectionState.disconnected) {
        _scheduleRetry();
      }
    }
  }

  @override
  Future<void> disconnect() async {
    _connectRequested = false;
    _explicitlyDisconnected = true;
    _retryTimer?.cancel();
    _retryTimer = null;

    final hub = _connection;
    _connection = null;
    if (hub == null) {
      _setState(RealtimeConnectionState.disconnected);
      return;
    }

    try {
      await hub.stop();
    } catch (error) {
      printY('$_logTag stop error (ignored): $error');
    } finally {
      _setState(RealtimeConnectionState.disconnected);
      printY('$_logTag disconnected');
    }
  }

  @override
  Future<void> joinTripGroup(String tripId) async {
    _joinedTripGroups.add(tripId);
    final hub = _connection;
    if (hub == null || _state != RealtimeConnectionState.connected) {
      printC('$_logTag queued Trip_$tripId join until connected');
      return;
    }
    try {
      await hub.invoke('JoinTripGroup', args: <Object>[tripId]);
      printG('$_logTag joined Trip_$tripId');
    } catch (error) {
      printY('$_logTag joinTripGroup($tripId) failed: $error');
    }
  }

  @override
  Future<void> leaveTripGroup(String tripId) async {
    _joinedTripGroups.remove(tripId);
    final hub = _connection;
    if (hub == null || _state != RealtimeConnectionState.connected) return;
    try {
      await hub.invoke('LeaveTripGroup', args: <Object>[tripId]);
      printC('$_logTag left Trip_$tripId');
    } catch (error) {
      printY('$_logTag leaveTripGroup($tripId) failed: $error');
    }
  }

  HubConnection _buildConnection() {
    final url = '${ApiConfig.baseUrl}$_hubPath';
    final tokenLen = _tokenStorage.cachedToken?.accessToken.length ?? 0;
    printM(
      '$_logTag building connection url=$url tokenPresent=${tokenLen > 0} tokenLen=$tokenLen',
    );
    return HubConnectionBuilder()
        .withUrl(
          url,
          options: HttpConnectionOptions(
            accessTokenFactory: () async =>
                _tokenStorage.cachedToken?.accessToken ?? '',
            requestTimeout: _requestTimeoutMs,
          ),
        )
        .withAutomaticReconnect()
        .build();
  }

  void _scheduleRetry() {
    if (_retryTimer != null) return;
    printY('$_logTag scheduling reconnect retry in ${_retryDelay.inSeconds}s');
    _retryTimer = Timer(_retryDelay, () {
      _retryTimer = null;
      if (_connectRequested && !_explicitlyDisconnected) {
        unawaited(connect());
      }
    });
  }

  void _wireHandlers(HubConnection hub) {
    hub.on(RealtimeMethodNames.tripRequested, _onTripRequested);
    hub.on(RealtimeMethodNames.driverAssigned, _onDriverAssigned);
    hub.on(RealtimeMethodNames.tripStarted, _onTripStarted);
    hub.on(RealtimeMethodNames.tripCompleted, _onTripCompleted);
    hub.on(RealtimeMethodNames.tripCancelled, _onTripCancelled);
    hub.on(RealtimeMethodNames.paymentConfirmed, _onPaymentConfirmed);
    hub.on(RealtimeMethodNames.paymentFailed, _onPaymentFailed);
    hub.on(RealtimeMethodNames.tripRefunded, _onTripRefunded);
    hub.on(RealtimeMethodNames.driverEnRoute, _onDriverEnRoute);
    hub.on(RealtimeMethodNames.driverArrived, _onDriverArrived);
    hub.on(RealtimeMethodNames.driverLocationUpdated, _onDriverLocationUpdated);
    hub.on(RealtimeMethodNames.tripStopCompleted, _onTripStopCompleted);

    hub.onclose(({Exception? error}) {
      printY('$_logTag connection closed (error=$error)');
      if (_explicitlyDisconnected) {
        _setState(RealtimeConnectionState.disconnected);
      } else {
        // Automatic-reconnect policy will retry; expose reconnecting state
        // until onreconnected resolves.
        _setState(RealtimeConnectionState.reconnecting);
      }
    });
    hub.onreconnecting(({Exception? error}) {
      printY('$_logTag reconnecting (error=$error)');
      _setState(RealtimeConnectionState.reconnecting);
    });
    hub.onreconnected(({String? connectionId}) {
      printG('$_logTag reconnected connectionId=$connectionId');
      _setState(RealtimeConnectionState.connected);
      // After a reconnect SignalR drops group membership — rejoin.
      unawaited(_rejoinTripGroups());
    });
  }

  Future<void> _rejoinTripGroups() async {
    final hub = _connection;
    if (hub == null || _state != RealtimeConnectionState.connected) return;
    for (final tripId in _joinedTripGroups.toList(growable: false)) {
      try {
        await hub.invoke('JoinTripGroup', args: <Object>[tripId]);
        printC('$_logTag re-joined Trip_$tripId');
      } catch (error) {
        printY('$_logTag re-join Trip_$tripId failed: $error');
      }
    }
  }

  void _setState(RealtimeConnectionState next) {
    if (_state == next) return;
    _state = next;
    _stateController.add(next);
  }

  Map<String, dynamic>? _payload(List<Object?>? args) {
    if (args == null || args.isEmpty) return null;
    final first = args.first;
    if (first is Map<String, dynamic>) return first;
    if (first is Map) return Map<String, dynamic>.from(first);
    return null;
  }

  String _readString(Map<String, dynamic> map, String camel) {
    final value = map[camel] ?? map[_pascal(camel)];
    return value?.toString() ?? '';
  }

  double _readDouble(Map<String, dynamic> map, String camel) {
    final value = map[camel] ?? map[_pascal(camel)];
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0;
    return 0;
  }

  String _pascal(String camel) =>
      camel.isEmpty ? camel : '${camel[0].toUpperCase()}${camel.substring(1)}';

  void _onTripRequested(List<Object?>? args) {
    final p = _payload(args);
    if (p == null) {
      printY('$_logTag <= TripRequested (empty payload, ignored)');
      return;
    }
    printM(
      '$_logTag <= TripRequested trip=${_readString(p, 'tripId')} vehicleType=${_readString(p, 'vehicleTypeId')}',
    );
    _eventsController.add(
      RealtimeEvent.tripRequested(
        tripId: _readString(p, 'tripId'),
        vehicleTypeId: _readString(p, 'vehicleTypeId'),
        passengerId: _readString(p, 'passengerId'),
      ),
    );
  }

  void _onDriverAssigned(List<Object?>? args) {
    final p = _payload(args);
    if (p == null) {
      printY('$_logTag <= DriverAssigned (empty payload, ignored)');
      return;
    }
    printM(
      '$_logTag <= DriverAssigned trip=${_readString(p, 'tripId')} driver=${_readString(p, 'driverId')}',
    );
    _eventsController.add(
      RealtimeEvent.driverAssigned(
        tripId: _readString(p, 'tripId'),
        passengerId: _readString(p, 'passengerId'),
        driverId: _readString(p, 'driverId'),
      ),
    );
  }

  void _onTripStarted(List<Object?>? args) {
    final p = _payload(args);
    if (p == null) {
      printY('$_logTag <= TripStarted (empty payload, ignored)');
      return;
    }
    printM(
      '$_logTag <= TripStarted trip=${_readString(p, 'tripId')} passenger=${_readString(p, 'passengerId')}',
    );
    _eventsController.add(
      RealtimeEvent.tripStarted(
        tripId: _readString(p, 'tripId'),
        passengerId: _readString(p, 'passengerId'),
      ),
    );
  }

  void _onTripCompleted(List<Object?>? args) {
    final p = _payload(args);
    if (p == null) {
      printY('$_logTag <= TripCompleted (empty payload, ignored)');
      return;
    }
    printG(
      '$_logTag <= TripCompleted trip=${_readString(p, 'tripId')} passenger=${_readString(p, 'passengerId')}',
    );
    _eventsController.add(
      RealtimeEvent.tripCompleted(
        tripId: _readString(p, 'tripId'),
        passengerId: _readString(p, 'passengerId'),
      ),
    );
  }

  void _onTripCancelled(List<Object?>? args) {
    final p = _payload(args);
    if (p == null) {
      printY('$_logTag <= TripCancelled (empty payload, ignored)');
      return;
    }
    printM(
      '$_logTag <= TripCancelled trip=${_readString(p, 'tripId')} passenger=${_readString(p, 'passengerId')}',
    );
    _eventsController.add(
      RealtimeEvent.tripCancelled(
        tripId: _readString(p, 'tripId'),
        passengerId: _readString(p, 'passengerId'),
      ),
    );
  }

  void _onPaymentConfirmed(List<Object?>? args) {
    final p = _payload(args);
    if (p == null) {
      printY('$_logTag <= PaymentConfirmed (empty payload, ignored)');
      return;
    }
    printM(
      '$_logTag <= PaymentConfirmed trip=${_readString(p, 'tripId')} passenger=${_readString(p, 'passengerId')}',
    );
    _eventsController.add(
      RealtimeEvent.paymentConfirmed(
        tripId: _readString(p, 'tripId'),
        passengerId: _readString(p, 'passengerId'),
      ),
    );
  }

  void _onPaymentFailed(List<Object?>? args) {
    final p = _payload(args);
    if (p == null) {
      printY('$_logTag <= PaymentFailed (empty payload, ignored)');
      return;
    }
    printM(
      '$_logTag <= PaymentFailed trip=${_readString(p, 'tripId')} reason=${_readString(p, 'reason')}',
    );
    _eventsController.add(
      RealtimeEvent.paymentFailed(
        tripId: _readString(p, 'tripId'),
        passengerId: _readString(p, 'passengerId'),
        reason: _readString(p, 'reason'),
      ),
    );
  }

  void _onTripRefunded(List<Object?>? args) {
    final p = _payload(args);
    if (p == null) {
      printY('$_logTag <= TripRefunded (empty payload, ignored)');
      return;
    }
    printM(
      '$_logTag <= TripRefunded trip=${_readString(p, 'tripId')} amount=${_readDouble(p, 'amount')}',
    );
    _eventsController.add(
      RealtimeEvent.tripRefunded(
        tripId: _readString(p, 'tripId'),
        passengerId: _readString(p, 'passengerId'),
        amount: _readDouble(p, 'amount'),
      ),
    );
  }

  void _onDriverEnRoute(List<Object?>? args) {
    final p = _payload(args);
    if (p == null) {
      printY('$_logTag <= DriverEnRoute (empty payload, ignored)');
      return;
    }
    printM(
      '$_logTag <= DriverEnRoute trip=${_readString(p, 'tripId')} driver=${_readString(p, 'driverId')}',
    );
    _eventsController.add(
      RealtimeEvent.driverEnRoute(
        tripId: _readString(p, 'tripId'),
        passengerId: _readString(p, 'passengerId'),
        driverId: _readString(p, 'driverId'),
      ),
    );
  }

  void _onDriverArrived(List<Object?>? args) {
    final p = _payload(args);
    if (p == null) {
      printY('$_logTag <= DriverArrived (empty payload, ignored)');
      return;
    }
    printM(
      '$_logTag <= DriverArrived trip=${_readString(p, 'tripId')} driver=${_readString(p, 'driverId')}',
    );
    _eventsController.add(
      RealtimeEvent.driverArrived(
        tripId: _readString(p, 'tripId'),
        passengerId: _readString(p, 'passengerId'),
        driverId: _readString(p, 'driverId'),
      ),
    );
  }

  void _onDriverLocationUpdated(List<Object?>? args) {
    final p = _payload(args);
    if (p == null) return;
    // High-frequency event — keep logging terse to avoid flooding the console.
    _eventsController.add(
      RealtimeEvent.driverLocationUpdated(
        tripId: _readString(p, 'tripId'),
        driverId: _readString(p, 'driverId'),
        latitude: _readDouble(p, 'latitude'),
        longitude: _readDouble(p, 'longitude'),
      ),
    );
  }

  void _onTripStopCompleted(List<Object?>? args) {
    final p = _payload(args);
    if (p == null) {
      printY('$_logTag <= TripStopCompleted (empty payload, ignored)');
      return;
    }
    printM(
      '$_logTag <= TripStopCompleted trip=${_readString(p, 'tripId')} seq=${p['sequence'] ?? p['Sequence']}',
    );
    final rawSequence = p['sequence'] ?? p['Sequence'];
    final sequence = rawSequence is num
        ? rawSequence.toInt()
        : int.tryParse(rawSequence?.toString() ?? '') ?? 0;
    _eventsController.add(
      RealtimeEvent.tripStopCompleted(
        tripId: _readString(p, 'tripId'),
        passengerId: _readString(p, 'passengerId'),
        driverId: _readString(p, 'driverId'),
        sequence: sequence,
      ),
    );
  }
}
