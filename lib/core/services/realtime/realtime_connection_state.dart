/// High-level connection state exposed by [RealtimeService].
///
/// Maps onto the underlying SignalR `HubConnection` lifecycle but stays
/// independent of the transport so consumers do not depend on
/// `signalr_netcore` directly.
enum RealtimeConnectionState {
  /// The service has not started a connection, or has been explicitly
  /// disconnected (e.g. after logout or app backgrounding).
  disconnected,

  /// `start()` is in flight.
  connecting,

  /// Connection is open and ready to receive pushes.
  connected,

  /// SignalR's automatic-reconnect policy is retrying after a transport
  /// failure. New pushes are not received until [connected] resumes.
  reconnecting,
}
