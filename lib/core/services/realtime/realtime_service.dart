import 'realtime_connection_state.dart';
import 'realtime_event.dart';

/// Transport-agnostic abstraction for real-time push from the backend.
///
/// The concrete implementation ([`SignalRRealtimeService`]) wraps a
/// SignalR `HubConnection`. Higher-level code (BLoCs, lifecycle
/// coordinator) depends on this interface only.
///
/// Connection lifecycle is owned by
/// [`RealtimeLifecycleCoordinator`] — features must NOT call
/// [connect]/[disconnect] directly.
abstract interface class RealtimeService {
  /// Opens the hub connection and registers handlers for every event in
  /// [RealtimeMethodNames.all]. Safe to call when already connected — it
  /// will no-op. Throws nothing: failures are surfaced via
  /// [connectionState] transitions back to [RealtimeConnectionState.disconnected].
  Future<void> connect();

  /// Closes the hub connection. Safe to call when already disconnected.
  Future<void> disconnect();

  /// Subscribes the current connection to the per-trip group on the
  /// server (`Trip_{tripId}`) so trip lifecycle and payment pushes for
  /// this trip are routed to this client.
  ///
  /// No-op if the connection is not currently
  /// [RealtimeConnectionState.connected].
  Future<void> joinTripGroup(String tripId);

  /// Reverse of [joinTripGroup]. No-op if not connected.
  Future<void> leaveTripGroup(String tripId);

  /// Broadcast stream of every push received from the hub, mapped to
  /// the typed [RealtimeEvent] union. Multiple subscribers are allowed.
  Stream<RealtimeEvent> get events;

  /// Broadcast stream of connection-state transitions. Always emits the
  /// current value to new subscribers (use `valueOf` on the
  /// implementation if a synchronous read is needed).
  Stream<RealtimeConnectionState> get connectionState;

  /// Synchronous read of the current connection state.
  RealtimeConnectionState get currentConnectionState;
}
