import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/domain/extensions/user_role_extensions.dart';
import '../../../../core/notification/notification_coordinator.dart';
import '../../../../core/services/realtime/realtime_event.dart';
import '../../../../core/services/realtime/realtime_service.dart';
import '../../../../core/services/session/auth_manager.dart';
import '../../../../core/utils/bloc_status.dart';
import '../../../../core/utils/result.dart';
import '../../../../utils/helpers/app_strings.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../../domain/entities/trip_entity.dart';
import '../../domain/facade/trip_facade.dart';

part 'trip_event.dart';
part 'trip_state.dart';
part 'trip_bloc.freezed.dart';

@lazySingleton
class TripBloc extends Bloc<TripEvent, TripState> {
  TripBloc(
    this._facade,
    this._realtimeService,
    this._authManager,
    this._notifications,
  ) : super(const TripState()) {
    on<_Started>(_onStarted);
    on<_GetAllRequested>(_onGetAllRequested);
    on<_RealtimeEventReceived>(_onRealtimeEventReceived);
    on<_FetchActiveRequested>(_onFetchActiveRequested);
    on<_TripSelected>(_onTripSelected);
    on<_SelectionCleared>(_onSelectionCleared);
    on<_MarkEnRouteRequested>(_onMarkEnRouteRequested);
    on<_MarkArrivedRequested>(_onMarkArrivedRequested);
    on<_ResendArrivedNotificationRequested>(_onResendArrivedNotificationRequested);
    on<_StartTripRequested>(_onStartTripRequested);
    on<_CompleteTripRequested>(_onCompleteTripRequested);
    on<_ClearCompletedSummaryRequested>(_onClearCompletedSummaryRequested);
    on<_DriverCancelRequested>(_onDriverCancelRequested);
    on<_CompleteStopRequested>(_onCompleteStopRequested);
    on<_AdminSelfAssignRequested>(_onAdminSelfAssignRequested);
    on<_AdminCancelRequested>(_onAdminCancelRequested);
    on<_DismissPendingTripRequested>(_onDismissPendingTripRequested);

    _eventsSub = _realtimeService.events.listen((event) {
      add(TripEvent.realtimeEventReceived(event));
    });
  }

  final TripFacade _facade;
  final RealtimeService _realtimeService;
  final AuthManager _authManager;
  final NotificationCoordinator _notifications;
  StreamSubscription<RealtimeEvent>? _eventsSub;

  Future<void> _onStarted(_Started event, Emitter<TripState> emit) {
    return _onGetAllRequested(const _GetAllRequested(), emit);
  }

  Future<void> _onGetAllRequested(
    _GetAllRequested event,
    Emitter<TripState> emit,
  ) async {
    printM('[TripBloc] get all trips requested');
    emit(state.copyWith(getAllState: const BlocStatus.loading()));

    final result = await _facade.getAllTrips();
    result.when(
      success: (data) {
        printG('[TripBloc] get all trips success count=${data.length}');
        emit(state.copyWith(getAllState: BlocStatus.success(data)));
      },
      failure: (message) {
        printY('[TripBloc] get all trips failed: $message');
        emit(state.copyWith(getAllState: BlocStatus.failure(message)));
      },
    );
  }

  Future<void> _onRealtimeEventReceived(
    _RealtimeEventReceived event,
    Emitter<TripState> emit,
  ) async {
    switch (event.event) {
      case RealtimeDriverEnRoute(:final tripId):
        printC('[TripBloc] realtime DriverEnRoute trip=$tripId');
        await _refreshOrAdvance(tripId, TripStatus.driverEnRoute, emit);
      case RealtimeDriverArrived(:final tripId):
        printC('[TripBloc] realtime DriverArrived trip=$tripId');
        await _refreshOrAdvance(tripId, TripStatus.driverArrived, emit);
      case RealtimeTripStarted(:final tripId):
        printC('[TripBloc] realtime TripStarted trip=$tripId');
        await _refreshOrAdvance(tripId, TripStatus.inProgress, emit);
      case RealtimeTripCompleted(:final tripId):
        printC('[TripBloc] realtime TripCompleted trip=$tripId');
        await _refreshOrAdvance(tripId, TripStatus.completed, emit);
      case RealtimeTripCancelled(:final tripId):
        printC('[TripBloc] realtime TripCancelled trip=$tripId');
        // Drop it from the pending queue if it was waiting.
        if (state.pendingTrips.any((t) => t.id == tripId)) {
          emit(
            state.copyWith(
              pendingTrips: state.pendingTrips
                  .where((t) => t.id != tripId)
                  .toList(),
            ),
          );
        }
        await _refreshOrAdvance(tripId, TripStatus.cancelled, emit);
      case RealtimeTripStopCompleted(:final tripId, :final sequence):
        printC(
          '[TripBloc] realtime TripStopCompleted trip=$tripId seq=$sequence',
        );
        await _onStopCompletedFromRealtime(tripId, sequence, emit);
      case RealtimeTripRequested(:final tripId):
        if (_authManager.currentUser?.isAdmin == true) {
          printC('[TripBloc] realtime TripRequested (admin) trip=$tripId');
          await _onAdminTripArrived(tripId, emit);
        }
      case RealtimeDriverAssigned(:final tripId):
        printC('[TripBloc] realtime DriverAssigned trip=$tripId');
        // Remove from the pending queue if admin just self-assigned or it got
        // assigned elsewhere.
        if (state.pendingTrips.any((t) => t.id == tripId)) {
          emit(
            state.copyWith(
              pendingTrips: state.pendingTrips
                  .where((t) => t.id != tripId)
                  .toList(),
            ),
          );
        }
        await _loadActiveTrip(tripId, emit, joinGroup: true);
      case RealtimeDriverLocationUpdated():
      case RealtimePaymentConfirmed():
      case RealtimePaymentFailed():
      case RealtimeTripRefunded():
        break;
    }
  }

  Future<void> _onStopCompletedFromRealtime(
    String tripId,
    int sequence,
    Emitter<TripState> emit,
  ) async {
    final active = state.activeTrip;
    if (active == null || active.id != tripId) return;
    emit(
      state.copyWith(
        completedStops: {...state.completedStops, sequence},
      ),
    );
  }

  Future<void> _onCompleteStopRequested(
    _CompleteStopRequested event,
    Emitter<TripState> emit,
  ) async {
    printM(
      '[TripBloc] complete stop requested trip=${event.tripId} '
      'seq=${event.sequence}',
    );
    emit(state.copyWith(completeStopState: const BlocStatus.loading()));
    final result = await _facade.completeStop(event.tripId, event.sequence);
    result.when(
      success: (_) {
        printG(
          '[TripBloc] complete stop success trip=${event.tripId} '
          'seq=${event.sequence}',
        );
        emit(
          state.copyWith(
            completeStopState: const BlocStatus.success(null),
            completedStops: {...state.completedStops, event.sequence},
          ),
        );
      },
      failure: (message) {
        printY(
          '[TripBloc] complete stop failed trip=${event.tripId} '
          'seq=${event.sequence}: $message',
        );
        emit(state.copyWith(completeStopState: BlocStatus.failure(message)));
      },
    );
  }

  Future<void> _onFetchActiveRequested(
    _FetchActiveRequested event,
    Emitter<TripState> emit,
  ) {
    return _loadActiveTrip(event.tripId, emit, joinGroup: true);
  }

  /// Explicit selection (e.g. tapping a trip in the Trips tab). Unlike
  /// [_loadActiveTrip] this shows the trip even when terminal (read-only sheet)
  /// and clears any stale in-session completion summary.
  Future<void> _onTripSelected(
    _TripSelected event,
    Emitter<TripState> emit,
  ) async {
    printM('[TripBloc] trip selected trip=${event.tripId}');
    emit(state.copyWith(activeTripState: const BlocStatus.loading()));
    await _realtimeService.joinTripGroup(event.tripId);

    final result = await _facade.getTripById(event.tripId);
    result.when(
      success: (trip) {
        printG(
          '[TripBloc] trip selected loaded trip=${event.tripId} '
          'status=${trip.status}',
        );
        emit(
          state.copyWith(
            activeTripState: BlocStatus.success(trip),
            activeTrip: trip,
            completedTrip: null,
            arrivedAt: trip.status == TripStatus.driverArrived
                ? (state.arrivedAt ?? DateTime.now())
                : null,
          ),
        );
      },
      failure: (message) {
        printY('[TripBloc] trip selected failed trip=${event.tripId}: $message');
        emit(state.copyWith(activeTripState: BlocStatus.failure(message)));
      },
    );
  }

  Future<void> _onSelectionCleared(
    _SelectionCleared event,
    Emitter<TripState> emit,
  ) async {
    final tripId = state.activeTrip?.id;
    if (tripId != null) {
      await _realtimeService.leaveTripGroup(tripId);
    }
    emit(state.copyWith(activeTrip: null, completedTrip: null, arrivedAt: null));
  }

  Future<void> _onMarkEnRouteRequested(
    _MarkEnRouteRequested event,
    Emitter<TripState> emit,
  ) async {
    printM('[TripBloc] mark en-route requested trip=${event.tripId}');
    emit(state.copyWith(markEnRouteState: const BlocStatus.loading()));
    final result = await _facade.markEnRoute(event.tripId);
    await result.when(
      success: (_) async {
        printG('[TripBloc] mark en-route success trip=${event.tripId}');
        await _realtimeService.joinTripGroup(event.tripId);
        emit(
          state.copyWith(
            markEnRouteState: const BlocStatus.success(null),
            activeTrip: state.activeTrip?.copyWithStatus(
              TripStatus.driverEnRoute,
            ),
          ),
        );
        await _loadActiveTrip(event.tripId, emit);
      },
      failure: (message) async {
        printY(
          '[TripBloc] mark en-route failed trip=${event.tripId}: $message',
        );
        emit(state.copyWith(markEnRouteState: BlocStatus.failure(message)));
      },
    );
  }

  Future<void> _onMarkArrivedRequested(
    _MarkArrivedRequested event,
    Emitter<TripState> emit,
  ) async {
    printM('[TripBloc] mark arrived requested trip=${event.tripId}');
    emit(state.copyWith(markArrivedState: const BlocStatus.loading()));
    final result = await _facade.markArrived(event.tripId);
    await result.when(
      success: (_) async {
        printG('[TripBloc] mark arrived success trip=${event.tripId}');
        emit(
          state.copyWith(
            markArrivedState: const BlocStatus.success(null),
            arrivedAt: DateTime.now(),
            activeTrip: state.activeTrip?.copyWithStatus(
              TripStatus.driverArrived,
            ),
          ),
        );
        await _loadActiveTrip(event.tripId, emit);
      },
      failure: (message) async {
        printY('[TripBloc] mark arrived failed trip=${event.tripId}: $message');
        emit(state.copyWith(markArrivedState: BlocStatus.failure(message)));
      },
    );
  }

  static const Duration _resendArrivedCooldown = Duration(seconds: 30);

  Future<void> _onResendArrivedNotificationRequested(
    _ResendArrivedNotificationRequested event,
    Emitter<TripState> emit,
  ) async {
    final lastSent = state.lastArrivedResendAt;
    if (lastSent != null &&
        DateTime.now().difference(lastSent) < _resendArrivedCooldown) {
      printC('[TripBloc] resend arrived blocked by cooldown trip=${event.tripId}');
      return;
    }
    printM('[TripBloc] resend arrived requested trip=${event.tripId}');
    emit(
      state.copyWith(
        resendArrivedNotificationState: const BlocStatus.loading(),
      ),
    );
    final result = await _facade.resendArrived(event.tripId);
    result.when(
      success: (_) {
        printG('[TripBloc] resend arrived success trip=${event.tripId}');
        emit(
          state.copyWith(
            resendArrivedNotificationState: const BlocStatus.success(null),
            lastArrivedResendAt: DateTime.now(),
          ),
        );
      },
      failure: (message) {
        printY('[TripBloc] resend arrived failed trip=${event.tripId}: $message');
        emit(
          state.copyWith(
            resendArrivedNotificationState: BlocStatus.failure(message),
          ),
        );
      },
    );
  }

  Future<void> _onStartTripRequested(
    _StartTripRequested event,
    Emitter<TripState> emit,
  ) async {
    printM('[TripBloc] start trip requested trip=${event.tripId}');
    emit(state.copyWith(startTripState: const BlocStatus.loading()));
    final result = await _facade.startTrip(event.tripId);
    await result.when(
      success: (_) async {
        printG('[TripBloc] start trip success trip=${event.tripId}');
        emit(
          state.copyWith(
            startTripState: const BlocStatus.success(null),
            activeTrip: state.activeTrip?.copyWithStatus(TripStatus.inProgress),
          ),
        );
        await _loadActiveTrip(event.tripId, emit);
      },
      failure: (message) async {
        printY('[TripBloc] start trip failed trip=${event.tripId}: $message');
        emit(state.copyWith(startTripState: BlocStatus.failure(message)));
      },
    );
  }

  Future<void> _onCompleteTripRequested(
    _CompleteTripRequested event,
    Emitter<TripState> emit,
  ) async {
    printM('[TripBloc] complete trip requested trip=${event.tripId}');
    emit(state.copyWith(completeTripState: const BlocStatus.loading()));
    final result = await _facade.completeTrip(event.tripId);
    await result.when(
      success: (_) async {
        printG('[TripBloc] complete trip success trip=${event.tripId}');
        final completedTrip = state.activeTrip?.copyWithStatus(
          TripStatus.completed,
        );
        await _realtimeService.leaveTripGroup(event.tripId);
        emit(
          state.copyWith(
            completeTripState: const BlocStatus.success(null),
            activeTrip: null,
            completedTrip: completedTrip,
            arrivedAt: null,
          ),
        );
      },
      failure: (message) async {
        printY(
          '[TripBloc] complete trip failed trip=${event.tripId}: $message',
        );
        emit(state.copyWith(completeTripState: BlocStatus.failure(message)));
      },
    );
  }

  void _onClearCompletedSummaryRequested(
    _ClearCompletedSummaryRequested event,
    Emitter<TripState> emit,
  ) {
    printM('[TripBloc] clear completed summary');
    emit(state.copyWith(completedTrip: null));
  }

  Future<void> _onDriverCancelRequested(
    _DriverCancelRequested event,
    Emitter<TripState> emit,
  ) async {
    printM('[TripBloc] driver cancel requested trip=${event.tripId} reason=${event.reason}');
    emit(state.copyWith(driverCancelState: const BlocStatus.loading()));
    final result = await _facade.driverCancelTrip(
      event.tripId,
      event.reason,
      event.note,
    );
    await result.when(
      success: (_) async {
        printG('[TripBloc] driver cancel success trip=${event.tripId}');
        final cancelledTrip = state.activeTrip?.copyWithStatus(TripStatus.cancelled);
        await _realtimeService.leaveTripGroup(event.tripId);
        emit(
          state.copyWith(
            driverCancelState: const BlocStatus.success(null),
            activeTrip: null,
            completedTrip: cancelledTrip,
            arrivedAt: null,
          ),
        );
      },
      failure: (message) async {
        printY('[TripBloc] driver cancel failed trip=${event.tripId}: $message');
        emit(state.copyWith(driverCancelState: BlocStatus.failure(message)));
      },
    );
  }

  Future<void> _refreshOrAdvance(
    String tripId,
    TripStatus nextStatus,
    Emitter<TripState> emit,
  ) async {
    final active = state.activeTrip;
    if (active == null || active.id != tripId) {
      printC(
        '[TripBloc] ignore realtime advance trip=$tripId status=$nextStatus',
      );
      return;
    }

    if (nextStatus == TripStatus.completed || nextStatus.isTerminal) {
      await _realtimeService.leaveTripGroup(tripId);
    }

    emit(state.copyWith(activeTrip: active.copyWithStatus(nextStatus)));
    await _loadActiveTrip(tripId, emit);
  }

  Future<void> _loadActiveTrip(
    String tripId,
    Emitter<TripState> emit, {
    bool joinGroup = false,
  }) async {
    printM('[TripBloc] load active trip=$tripId joinGroup=$joinGroup');
    emit(state.copyWith(activeTripState: const BlocStatus.loading()));
    if (joinGroup) await _realtimeService.joinTripGroup(tripId);

    final result = await _facade.getTripById(tripId);
    result.when(
      success: (trip) {
        printG(
          '[TripBloc] active trip loaded trip=$tripId status=${trip.status}',
        );
        emit(
          state.copyWith(
            activeTripState: BlocStatus.success(trip),
            activeTrip: trip.status.isTerminal ? null : trip,
            completedTrip: trip.status == TripStatus.completed
                ? trip
                : state.completedTrip,
          ),
        );
      },
      failure: (message) {
        printY('[TripBloc] active trip failed trip=$tripId: $message');
        emit(state.copyWith(activeTripState: BlocStatus.failure(message)));
      },
    );
  }

  Future<void> _onAdminTripArrived(
    String tripId,
    Emitter<TripState> emit,
  ) async {
    // Already the active trip, or already queued — ignore duplicates.
    if (state.activeTrip?.id == tripId ||
        state.pendingTrips.any((t) => t.id == tripId)) {
      return;
    }

    final result = await _facade.getTripById(tripId);
    result.when(
      success: (trip) {
        // Guard again post-await: state may have changed while fetching.
        if (state.activeTrip?.id == trip.id ||
            state.pendingTrips.any((t) => t.id == trip.id)) {
          return;
        }
        printG('[TripBloc] admin pending trip queued trip=$tripId');
        emit(state.copyWith(pendingTrips: [...state.pendingTrips, trip]));
        _notifications.showLocal(
          title: AppStrings.adminNewTripArrivedTitle,
          body: AppStrings.adminNewTripArrivedBody,
          data: {'tripId': tripId},
        );
      },
      failure: (message) {
        printY('[TripBloc] admin pending trip load failed: $message');
      },
    );
  }

  Future<void> _onAdminSelfAssignRequested(
    _AdminSelfAssignRequested event,
    Emitter<TripState> emit,
  ) async {
    printM('[TripBloc] admin take trip=${event.tripId}');
    emit(state.copyWith(adminSelfAssignState: const BlocStatus.loading()));

    final result = await _facade.adminTakeTrip(event.tripId);
    await result.when(
      success: (_) async {
        printG('[TripBloc] admin take success trip=${event.tripId}');
        emit(
          state.copyWith(
            adminSelfAssignState: const BlocStatus.success(null),
            pendingTrips: state.pendingTrips
                .where((t) => t.id != event.tripId)
                .toList(),
          ),
        );
        await _loadActiveTrip(event.tripId, emit, joinGroup: true);
      },
      failure: (message) async {
        printY('[TripBloc] admin take failed: $message');
        emit(
          state.copyWith(adminSelfAssignState: BlocStatus.failure(message)),
        );
      },
    );
  }

  Future<void> _onAdminCancelRequested(
    _AdminCancelRequested event,
    Emitter<TripState> emit,
  ) async {
    printM('[TripBloc] admin cancel trip=${event.tripId}');
    emit(state.copyWith(adminCancelState: const BlocStatus.loading()));

    final result = await _facade.adminCancelTrip(event.tripId);
    await result.when(
      success: (_) async {
        printG('[TripBloc] admin cancel success trip=${event.tripId}');
        await _realtimeService.leaveTripGroup(event.tripId);
        emit(
          state.copyWith(
            adminCancelState: const BlocStatus.success(null),
            activeTrip: null,
            completedTrip: null,
            arrivedAt: null,
          ),
        );
      },
      failure: (message) async {
        printY('[TripBloc] admin cancel failed trip=${event.tripId}: $message');
        emit(state.copyWith(adminCancelState: BlocStatus.failure(message)));
      },
    );
  }

  void _onDismissPendingTripRequested(
    _DismissPendingTripRequested event,
    Emitter<TripState> emit,
  ) {
    printM('[TripBloc] dismiss pending trip=${event.tripId}');
    emit(
      state.copyWith(
        pendingTrips: state.pendingTrips
            .where((t) => t.id != event.tripId)
            .toList(),
      ),
    );
  }

  @override
  Future<void> close() {
    _eventsSub?.cancel();
    return super.close();
  }
}
