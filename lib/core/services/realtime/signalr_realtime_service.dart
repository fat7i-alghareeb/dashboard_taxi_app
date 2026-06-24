import 'dart:async';
import 'dart:math';

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
  static const Duration _maxRetryDelay = Duration(seconds: 30);

  final JwtTokenStorage _tokenStorage;

  HubConnection? _connection;
  Future<void>? _pendingConnect;
  Timer? _retryTimer;
  bool _connectRequested = false;
  bool _explicitlyDisconnected = false;
  int _connectionGeneration = 0;
  int _retryAttempt = 0;
  final Set<String> _joinedTripGroups = <String>{};
  final Set<String> _joinedVehicleTypeGroups = <String>{};
  final Set<String> _seenEventIds = <String>{};

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
      _retryAttempt = 0;
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
    _connectionGeneration++;
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

  @override
  Future<void> joinVehicleTypeGroup(String vehicleTypeId) async {
    _joinedVehicleTypeGroups.add(vehicleTypeId);
    final hub = _connection;
    if (hub == null || _state != RealtimeConnectionState.connected) {
      printC(
        '$_logTag queued VehicleType_$vehicleTypeId join until connected',
      );
      return;
    }
    try {
      await hub.invoke('JoinVehicleTypeGroup', args: <Object>[vehicleTypeId]);
      printG('$_logTag joined VehicleType_$vehicleTypeId');
    } catch (error) {
      printY(
        '$_logTag joinVehicleTypeGroup($vehicleTypeId) failed: $error',
      );
    }
  }

  @override
  Future<void> leaveVehicleTypeGroup(String vehicleTypeId) async {
    _joinedVehicleTypeGroups.remove(vehicleTypeId);
    final hub = _connection;
    if (hub == null || _state != RealtimeConnectionState.connected) return;
    try {
      await hub.invoke('LeaveVehicleTypeGroup', args: <Object>[vehicleTypeId]);
      printC('$_logTag left VehicleType_$vehicleTypeId');
    } catch (error) {
      printY(
        '$_logTag leaveVehicleTypeGroup($vehicleTypeId) failed: $error',
      );
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
    final exponent = min(_retryAttempt, 4);
    final baseSeconds = min(
      _retryDelay.inSeconds * (1 << exponent),
      _maxRetryDelay.inSeconds,
    );
    final delay = Duration(
      milliseconds: baseSeconds * 1000 + Random().nextInt(750),
    );
    _retryAttempt++;
    printY('$_logTag scheduling reconnect retry in ${delay.inMilliseconds}ms');
    _retryTimer = Timer(delay, () {
      _retryTimer = null;
      if (_connectRequested && !_explicitlyDisconnected) {
        unawaited(connect());
      }
    });
  }

  void _wireHandlers(HubConnection hub) {
    final generation = ++_connectionGeneration;
    hub.on(RealtimeMethodNames.tripRequested, _onTripRequested);
    hub.on(
      RealtimeMethodNames.tripAwaitingAdminAcceptance,
      _onTripAwaitingAdminAcceptance,
    );
    hub.on(RealtimeMethodNames.tripAccepted, _onTripAccepted);
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
    hub.on(RealtimeMethodNames.tripMessageReceived, _onTripMessageReceived);
    hub.on(RealtimeMethodNames.chatClosed, _onChatClosed);

    hub.onclose(({Exception? error}) {
      if (_connection != hub || generation != _connectionGeneration) return;
      printY('$_logTag connection closed (error=$error)');
      if (_explicitlyDisconnected) {
        _setState(RealtimeConnectionState.disconnected);
      } else {
        _connection = null;
        _setState(RealtimeConnectionState.disconnected);
        _scheduleRetry();
      }
    });
    hub.onreconnecting(({Exception? error}) {
      if (_connection != hub || generation != _connectionGeneration) return;
      printY('$_logTag reconnecting (error=$error)');
      _setState(RealtimeConnectionState.reconnecting);
    });
    hub.onreconnected(({String? connectionId}) {
      if (_connection != hub || generation != _connectionGeneration) return;
      printG('$_logTag reconnected connectionId=$connectionId');
      _setState(RealtimeConnectionState.connected);
      _retryAttempt = 0;
      // After a reconnect SignalR drops group membership — rejoin.
      unawaited(_rejoinTripGroups());
    });
  }

  Future<void> _rejoinTripGroups() async {
    final hub = _connection;
    if (hub == null || _state != RealtimeConnectionState.connected) return;
    for (final tripId in _joinedTripGroups) {
      try {
        await hub.invoke('JoinTripGroup', args: <Object>[tripId]);
        printC('$_logTag re-joined Trip_$tripId');
      } catch (error) {
        printY('$_logTag re-join Trip_$tripId failed: $error');
      }
    }
    for (final vehicleTypeId in _joinedVehicleTypeGroups) {
      try {
        await hub.invoke(
          'JoinVehicleTypeGroup',
          args: <Object>[vehicleTypeId],
        );
        printC('$_logTag re-joined VehicleType_$vehicleTypeId');
      } catch (error) {
        printY(
          '$_logTag re-join VehicleType_$vehicleTypeId failed: $error',
        );
      }
    }
  }

  void _setState(RealtimeConnectionState next) {
    if (_state == next) return;
    _state = next;
    _stateController.add(next);
  }

  Map<String, dynamic>? _payload(
    List<Object?>? args, {
    bool requireTripId = true,
  }) {
    if (args == null || args.isEmpty) return null;
    final first = args.first;
    final payload = first is Map<String, dynamic>
        ? first
        : first is Map
        ? Map<String, dynamic>.from(first)
        : null;
    if (payload == null) return null;
    if (requireTripId && !_hasRequiredStrings(payload, const ['tripId'])) {
      return null;
    }

    final eventId = _readNullableString(payload, 'eventId');
    if (eventId != null) {
      if (_seenEventIds.length > 512) _seenEventIds.clear();
      if (!_seenEventIds.add(eventId)) return null;
    }
    return payload;
  }

  bool _hasRequiredStrings(
    Map<String, dynamic> payload,
    List<String> fields,
  ) {
    for (final field in fields) {
      if (_readNullableString(payload, field) == null) {
        printY('$_logTag malformed payload missing $field: $payload');
        return false;
      }
    }
    return true;
  }

  String _readString(Map<String, dynamic> map, String camel) {
    final value = map[camel] ?? map[_pascal(camel)];
    return value?.toString() ?? '';
  }

  String? _readNullableString(Map<String, dynamic> map, String camel) {
    final value = map[camel] ?? map[_pascal(camel)];
    final text = value?.toString();
    return (text == null || text.isEmpty) ? null : text;
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

  void _onTripAwaitingAdminAcceptance(List<Object?>? args) {
    final p = _payload(args);
    if (p == null) return;
    _eventsController.add(
      RealtimeEvent.tripAwaitingAdminAcceptance(
        tripId: _readString(p, 'tripId'),
        vehicleTypeId: _readString(p, 'vehicleTypeId'),
        passengerId: _readString(p, 'passengerId'),
        scheduledAtUtc: _readNullableString(p, 'scheduledAtUtc'),
      ),
    );
  }

  void _onTripAccepted(List<Object?>? args) {
    final p = _payload(args);
    if (p == null) return;
    _eventsController.add(
      RealtimeEvent.tripAccepted(
        tripId: _readString(p, 'tripId'),
        passengerId: _readString(p, 'passengerId'),
        adminId: _readString(p, 'adminId'),
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
    final p = _payload(args, requireTripId: false);
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

  void _onTripMessageReceived(List<Object?>? args) {
    final p = _payload(args);
    if (p == null) {
      printY('$_logTag <= TripMessageReceived (empty payload, ignored)');
      return;
    }
    printM(
      '$_logTag <= TripMessageReceived trip=${_readString(p, 'tripId')} sender=${_readString(p, 'senderId')}',
    );
    _eventsController.add(
      RealtimeEvent.tripMessageReceived(
        tripId: _readString(p, 'tripId'),
        messageId: _readString(p, 'messageId'),
        senderId: _readString(p, 'senderId'),
        senderRole: _readString(p, 'senderRole'),
        content: _readNullableString(p, 'content'),
        photoUrl: _readNullableString(p, 'photoUrl'),
        sentAtUtc: _readString(p, 'sentAtUtc'),
      ),
    );
  }

  void _onChatClosed(List<Object?>? args) {
    final p = _payload(args);
    if (p == null) {
      printY('$_logTag <= ChatClosed (empty payload, ignored)');
      return;
    }
    printM('$_logTag <= ChatClosed trip=${_readString(p, 'tripId')}');
    _eventsController.add(
      RealtimeEvent.chatClosed(tripId: _readString(p, 'tripId')),
    );
  }
}
