import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/services/realtime/realtime_event.dart';
import '../../../../core/services/realtime/realtime_connection_state.dart';
import '../../../../core/services/realtime/realtime_service.dart';
import '../../../../core/utils/bloc_status.dart';
import '../../../../core/utils/result.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../../../root/domain/services/root_mode_service.dart';
import '../../domain/entities/dashboard_entity.dart';
import '../../domain/facade/dashboard_facade.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';
part 'dashboard_bloc.freezed.dart';

@injectable
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc(this._facade, this._realtimeService, this._rootModeService)
    : super(const DashboardState()) {
    on<_Started>(_onStarted);
    on<_OverviewRequested>(_onOverviewRequested);
    on<_DriverDocumentsRequested>(_onDriverDocumentsRequested);
    on<_DocumentReviewRequested>(_onDocumentReviewRequested);
    on<_DriverApprovalRequested>(_onDriverApprovalRequested);
    on<_TripAssignmentRequested>(_onTripAssignmentRequested);
    on<_DriverLocationsRequested>(_onDriverLocationsRequested);
    on<_DriverLocationReceived>(_onDriverLocationReceived);
    on<_AdminTripsRequested>(_onAdminTripsRequested);
    on<_AdminTripsNextPageRequested>(_onAdminTripsNextPageRequested);
    on<_AdminTripsSearchChanged>(_onAdminTripsSearchChanged);
    on<_AdminTripsCustomerChanged>(_onAdminTripsCustomerChanged);
    on<_AdminTripStatusPatched>(_onAdminTripStatusPatched);
    on<_TripDetailsRequested>(_onTripDetailsRequested);
    on<_TripFinancialsRequested>(_onTripFinancialsRequested);
    on<_UserWalletRequested>(_onUserWalletRequested);
    on<_AdminConfigRequested>(_onAdminConfigRequested);
    on<_AdminVehicleTypesRequested>(_onAdminVehicleTypesRequested);
    on<_VehicleTypeStatusToggleRequested>(_onVehicleTypeStatusToggleRequested);
    on<_VehicleTypeRemovalRequested>(_onVehicleTypeRemovalRequested);
    on<_VehicleTypeCreateRequested>(_onVehicleTypeCreateRequested);
    on<_VehicleTypeUpdateRequested>(_onVehicleTypeUpdateRequested);
    on<_TripDiscountUpdateRequested>(_onTripDiscountUpdateRequested);
    on<_CurrencyUpdateRequested>(_onCurrencyUpdateRequested);

    _realtimeSub = _realtimeService.events.listen((final event) {
      switch (event) {
        case RealtimeDriverLocationUpdated(
          :final driverId,
          :final latitude,
          :final longitude,
        ):
          printC(
            '[DashboardBloc] realtime location driver=$driverId lat=$latitude lng=$longitude',
          );
          add(
            DashboardEvent.driverLocationReceived(
              driverId: driverId,
              latitude: latitude,
              longitude: longitude,
            ),
          );
        // Legacy pre-payment event; retained only for compatibility.
        case RealtimeTripRequested():
          _scheduleAdminTripsRefresh();
          _scheduleOverviewRefresh();
        // Paid trip is now eligible for admin acceptance.
        case RealtimeTripAwaitingAdminAcceptance():
          _scheduleAdminTripsRefresh();
          _scheduleOverviewRefresh();
        // Refresh instead of only patching so owner and dispatch fields are
        // immediately authoritative for every admin.
        case RealtimeTripAccepted():
          _scheduleAdminTripsRefresh();
          _scheduleOverviewRefresh();
        // Status transitions: patch the in-memory list in-place to avoid a
        // flicker. The overview counters also need a refresh.
        case RealtimeDriverAssigned(:final tripId):
          _applyTripStatusInPlace(tripId, 'Accepted');
          _scheduleOverviewRefresh();
        case RealtimeDriverEnRoute(:final tripId):
          _applyTripStatusInPlace(tripId, 'EnRoute');
        case RealtimeDriverArrived(:final tripId):
          _applyTripStatusInPlace(tripId, 'Arrived');
        case RealtimeTripStarted(:final tripId):
          _applyTripStatusInPlace(tripId, 'InProgress');
          _scheduleAdminTripsRefresh();
          if (state.selectedTripId == tripId) {
            add(DashboardEvent.tripDetailsRequested(tripId));
          }
        case RealtimeTripStopCompleted():
          break;
        case RealtimeTripCompleted(:final tripId):
          _applyTripStatusInPlace(tripId, 'Completed');
          _scheduleOverviewRefresh();
        case RealtimeTripCancelled(:final tripId):
          _applyTripStatusInPlace(tripId, 'Cancelled');
          _scheduleOverviewRefresh();
        case RealtimePaymentConfirmed():
        case RealtimePaymentFailed():
        case RealtimeTripRefunded():
        case RealtimeRefundLifecycleChanged():
        case RealtimeRefundIssueCreated():
        // Chat events are handled by ChatBloc, not the dashboard.
        case RealtimeTripMessageReceived():
        case RealtimeChatClosed():
        // Incidents have their own screen/cubit that live-refreshes.
        case RealtimeCustomerIncidentRaised():
          break;
      }
    });
    _connectionSub = _realtimeService.connectionState.listen((connectionState) {
      if (connectionState != RealtimeConnectionState.connected || isClosed) {
        return;
      }
      add(const DashboardEvent.adminTripsRequested());
      add(const DashboardEvent.overviewRequested());
      final selectedTripId = state.selectedTripId;
      if (selectedTripId != null) {
        add(DashboardEvent.tripDetailsRequested(selectedTripId));
      }
    });
  }

  void _scheduleAdminTripsRefresh() {
    _adminTripsRefreshTimer?.cancel();
    _adminTripsRefreshTimer = Timer(const Duration(milliseconds: 600), () {
      if (isClosed) return;
      printC('[DashboardBloc] realtime trip event → admin trips refresh');
      add(const DashboardEvent.adminTripsRequested());
    });
  }

  void _applyTripStatusInPlace(String tripId, String newStatus) {
    if (isClosed) return;
    add(
      DashboardEvent.adminTripStatusPatched(
        tripId: tripId,
        newStatus: newStatus,
      ),
    );
  }

  void _onAdminTripStatusPatched(
    _AdminTripStatusPatched event,
    Emitter<DashboardState> emit,
  ) {
    final current = state.adminTripsState.maybeWhen(
      success: (data) => data,
      orElse: () => const <DashboardTripEntity>[],
    );
    final index = current.indexWhere((t) => t.id == event.tripId);
    if (index < 0) return;
    final updated = List<DashboardTripEntity>.of(current);
    updated[index] = current[index].copyWithStatus(event.newStatus);
    printC(
      '[DashboardBloc] realtime in-place status trip=${event.tripId} → ${event.newStatus}',
    );
    emit(state.copyWith(adminTripsState: BlocStatus.success(updated)));
  }

  void _scheduleOverviewRefresh() {
    _overviewRefreshTimer?.cancel();
    _overviewRefreshTimer = Timer(const Duration(milliseconds: 800), () {
      if (isClosed) return;
      printC('[DashboardBloc] realtime trip event → overview refresh');
      add(const DashboardEvent.overviewRequested());
    });
  }

  final DashboardFacade _facade;
  final RealtimeService _realtimeService;
  final RootModeService _rootModeService;
  StreamSubscription<RealtimeEvent>? _realtimeSub;
  StreamSubscription<RealtimeConnectionState>? _connectionSub;
  Timer? _overviewRefreshTimer;
  Timer? _adminTripsRefreshTimer;
  Timer? _adminSearchDebounce;
  final Set<String> _joinedTripGroups = <String>{};

  static const int _adminTripsPageSize = 20;

  Future<void> _onStarted(_Started event, Emitter<DashboardState> emit) {
    return _onOverviewRequested(const _OverviewRequested(), emit);
  }

  Future<void> _onOverviewRequested(
    _OverviewRequested event,
    Emitter<DashboardState> emit,
  ) async {
    printM('[DashboardBloc] overview requested');
    emit(state.copyWith(overviewState: const BlocStatus.loading()));

    final result = await _facade.getOverview();
    result.when(
      success: (data) {
        printG(
          '[DashboardBloc] overview success drivers=${data.totalDrivers} trips=${data.totalTrips}',
        );
        emit(state.copyWith(overviewState: BlocStatus.success(data)));
      },
      failure: (message) {
        printY('[DashboardBloc] overview failed: $message');
        emit(state.copyWith(overviewState: BlocStatus.failure(message)));
      },
    );
  }

  Future<void> _onDriverDocumentsRequested(
    _DriverDocumentsRequested event,
    Emitter<DashboardState> emit,
  ) async {
    printM(
      '[DashboardBloc] driver documents requested driver=${event.driverId}',
    );
    emit(
      state.copyWith(
        selectedDriverId: event.driverId,
        driverDocumentsState: const BlocStatus.loading(),
        documentReviewState: const BlocStatus.initial(),
        driverApprovalState: const BlocStatus.initial(),
      ),
    );

    final result = await _facade.getDriverDocuments(event.driverId);
    result.when(
      success: (data) {
        printG('[DashboardBloc] documents success count=${data.length}');
        emit(state.copyWith(driverDocumentsState: BlocStatus.success(data)));
      },
      failure: (message) {
        printY('[DashboardBloc] documents failed: $message');
        emit(state.copyWith(driverDocumentsState: BlocStatus.failure(message)));
      },
    );
  }

  Future<void> _onDocumentReviewRequested(
    _DocumentReviewRequested event,
    Emitter<DashboardState> emit,
  ) async {
    printM(
      '[DashboardBloc] document review driver=${event.driverId} document=${event.documentId} approved=${event.approved}',
    );
    emit(state.copyWith(documentReviewState: const BlocStatus.loading()));

    final result = await _facade.reviewDriverDocument(
      driverId: event.driverId,
      documentId: event.documentId,
      approved: event.approved,
      notes: event.notes,
    );

    await result.when(
      success: (_) async {
        printG('[DashboardBloc] document review success');
        emit(
          state.copyWith(documentReviewState: const BlocStatus.success(null)),
        );
        add(DashboardEvent.driverDocumentsRequested(event.driverId));
      },
      failure: (message) {
        printY('[DashboardBloc] document review failed: $message');
        emit(state.copyWith(documentReviewState: BlocStatus.failure(message)));
      },
    );
  }

  Future<void> _onDriverApprovalRequested(
    _DriverApprovalRequested event,
    Emitter<DashboardState> emit,
  ) async {
    printM('[DashboardBloc] approve driver requested driver=${event.driverId}');
    emit(state.copyWith(driverApprovalState: const BlocStatus.loading()));

    final result = await _facade.approveDriver(event.driverId);
    await result.when(
      success: (_) async {
        printG('[DashboardBloc] approve driver success');
        emit(
          state.copyWith(driverApprovalState: const BlocStatus.success(null)),
        );
        add(const DashboardEvent.overviewRequested());
        add(DashboardEvent.driverDocumentsRequested(event.driverId));
      },
      failure: (message) {
        printY('[DashboardBloc] approve driver failed: $message');
        emit(state.copyWith(driverApprovalState: BlocStatus.failure(message)));
      },
    );
  }

  Future<void> _onTripAssignmentRequested(
    _TripAssignmentRequested event,
    Emitter<DashboardState> emit,
  ) async {
    printM(
      '[DashboardBloc] assign trip=${event.tripId} driver=${event.driverId} enterDriverMode=${event.enterDriverMode}',
    );
    emit(state.copyWith(tripAssignmentState: const BlocStatus.loading()));

    final result = await _facade.assignDriverToTrip(
      tripId: event.tripId,
      driverId: event.driverId,
    );
    await result.when(
      success: (_) async {
        printG('[DashboardBloc] trip assignment success');
        emit(
          state.copyWith(tripAssignmentState: const BlocStatus.success(null)),
        );
        if (event.enterDriverMode) {
          _rootModeService.showDriverMode();
        }
        add(const DashboardEvent.overviewRequested());
      },
      failure: (message) {
        printY('[DashboardBloc] trip assignment failed: $message');
        emit(state.copyWith(tripAssignmentState: BlocStatus.failure(message)));
      },
    );
  }

  Future<void> _onDriverLocationsRequested(
    _DriverLocationsRequested event,
    Emitter<DashboardState> emit,
  ) async {
    printM('[DashboardBloc] driver locations requested');
    emit(state.copyWith(driverLocationsState: const BlocStatus.loading()));

    final result = await _facade.getDriverLocations();
    result.when(
      success: (data) {
        printG('[DashboardBloc] driver locations success count=${data.length}');
        emit(state.copyWith(driverLocationsState: BlocStatus.success(data)));
      },
      failure: (message) {
        printY('[DashboardBloc] driver locations failed: $message');
        emit(state.copyWith(driverLocationsState: BlocStatus.failure(message)));
      },
    );
  }

  void _onDriverLocationReceived(
    _DriverLocationReceived event,
    Emitter<DashboardState> emit,
  ) {
    final currentLocations = state.driverLocationsState.maybeWhen(
      success: (data) => data,
      orElse: () => const <DashboardDriverLocationEntity>[],
    );

    final existingIndex = currentLocations.indexWhere(
      (driver) => driver.driverId == event.driverId,
    );
    final nextLocations = List<DashboardDriverLocationEntity>.of(
      currentLocations,
    );

    if (existingIndex >= 0) {
      nextLocations[existingIndex] = nextLocations[existingIndex]
          .copyWithLocation(
            latitude: event.latitude,
            longitude: event.longitude,
          );
    } else {
      nextLocations.add(
        DashboardDriverLocationEntity(
          driverId: event.driverId,
          name: '',
          phone: '',
          status: '',
          approvalStatus: '',
          latitude: event.latitude,
          longitude: event.longitude,
          locationUpdatedAt: DateTime.now(),
          vehicleTypeId: null,
          vehicleTypeName: null,
        ),
      );
    }

    emit(
      state.copyWith(driverLocationsState: BlocStatus.success(nextLocations)),
    );
  }

  Future<void> _onAdminTripsRequested(
    _AdminTripsRequested event,
    Emitter<DashboardState> emit,
  ) async {
    printM('[DashboardBloc] admin trips requested status=${event.status}');
    emit(
      state.copyWith(
        adminTripsState: const BlocStatus.loading(),
        adminTripsPage: 1,
        adminTripsHasMore: true,
        adminTripsLoadingMore: false,
      ),
    );

    final search = state.adminTripsSearch.trim();
    final result = await _facade.getAdminTrips(
      page: 1,
      pageSize: _adminTripsPageSize,
      status: event.status,
      search: search.isEmpty ? null : search,
      passengerId: state.adminTripsPassengerId.isEmpty
          ? null
          : state.adminTripsPassengerId,
    );
    result.when(
      success: (paged) {
        printG(
          '[DashboardBloc] admin trips success count=${paged.items.length} total=${paged.totalCount}',
        );
        emit(
          state.copyWith(
            adminTripsState: BlocStatus.success(paged.items),
            adminTripsPage: 1,
            adminTripsHasMore: paged.items.length < paged.totalCount,
          ),
        );
        _syncTripGroupSubscriptions(paged.items.map((t) => t.id).toSet());
      },
      failure: (message) {
        printY('[DashboardBloc] admin trips failed: $message');
        emit(state.copyWith(adminTripsState: BlocStatus.failure(message)));
      },
    );
  }

  Future<void> _onAdminTripsNextPageRequested(
    _AdminTripsNextPageRequested event,
    Emitter<DashboardState> emit,
  ) async {
    if (!state.adminTripsHasMore || state.adminTripsLoadingMore) return;
    final current = state.adminTripsState.maybeWhen(
      success: (data) => data,
      orElse: () => const <DashboardTripEntity>[],
    );
    final nextPage = state.adminTripsPage + 1;
    printM('[DashboardBloc] admin trips next page requested page=$nextPage');
    emit(state.copyWith(adminTripsLoadingMore: true));

    final search = state.adminTripsSearch.trim();
    final result = await _facade.getAdminTrips(
      page: nextPage,
      pageSize: _adminTripsPageSize,
      search: search.isEmpty ? null : search,
      passengerId: state.adminTripsPassengerId.isEmpty
          ? null
          : state.adminTripsPassengerId,
    );
    result.when(
      success: (paged) {
        final merged = <DashboardTripEntity>[...current, ...paged.items];
        printG('[DashboardBloc] admin trips page loaded count=${merged.length}');
        emit(
          state.copyWith(
            adminTripsState: BlocStatus.success(merged),
            adminTripsPage: nextPage,
            adminTripsHasMore: merged.length < paged.totalCount,
            adminTripsLoadingMore: false,
          ),
        );
        _syncTripGroupSubscriptions(merged.map((t) => t.id).toSet());
      },
      failure: (message) {
        printY('[DashboardBloc] admin trips page failed: $message');
        emit(state.copyWith(adminTripsLoadingMore: false));
      },
    );
  }

  void _onAdminTripsSearchChanged(
    _AdminTripsSearchChanged event,
    Emitter<DashboardState> emit,
  ) {
    // Store immediately so the debounced reload uses the latest term.
    emit(state.copyWith(adminTripsSearch: event.query));
    _adminSearchDebounce?.cancel();
    _adminSearchDebounce = Timer(const Duration(milliseconds: 350), () {
      if (isClosed) return;
      add(const DashboardEvent.adminTripsRequested());
    });
  }

  Future<void> _onAdminTripsCustomerChanged(
    _AdminTripsCustomerChanged event,
    Emitter<DashboardState> emit,
  ) {
    emit(
      state.copyWith(
        adminTripsPassengerId: event.passengerId ?? '',
        adminTripsPassengerName: event.name ?? '',
      ),
    );
    return _onAdminTripsRequested(const _AdminTripsRequested(), emit);
  }

  void _syncTripGroupSubscriptions(Set<String> nextIds) {
    final toLeave = _joinedTripGroups.difference(nextIds);
    final toJoin = nextIds.difference(_joinedTripGroups);
    for (final id in toLeave) {
      unawaited(_realtimeService.leaveTripGroup(id));
    }
    for (final id in toJoin) {
      unawaited(_realtimeService.joinTripGroup(id));
    }
    _joinedTripGroups
      ..removeAll(toLeave)
      ..addAll(toJoin);
  }

  Future<void> _onTripDetailsRequested(
    _TripDetailsRequested event,
    Emitter<DashboardState> emit,
  ) async {
    printM('[DashboardBloc] trip details requested trip=${event.tripId}');
    emit(
      state.copyWith(
        selectedTripId: event.tripId,
        tripDetailsState: const BlocStatus.loading(),
      ),
    );

    // Load the read-only money breakdown in parallel with the details.
    add(DashboardEvent.tripFinancialsRequested(event.tripId));

    final result = await _facade.getTripDetails(event.tripId);
    result.when(
      success: (data) {
        printG(
          '[DashboardBloc] trip details success ref=${data.referenceCode}',
        );
        emit(state.copyWith(tripDetailsState: BlocStatus.success(data)));
      },
      failure: (message) {
        printY('[DashboardBloc] trip details failed: $message');
        emit(state.copyWith(tripDetailsState: BlocStatus.failure(message)));
      },
    );
  }

  Future<void> _onTripFinancialsRequested(
    _TripFinancialsRequested event,
    Emitter<DashboardState> emit,
  ) async {
    printM('[DashboardBloc] trip financials requested trip=${event.tripId}');
    emit(state.copyWith(tripFinancialsState: const BlocStatus.loading()));

    final result = await _facade.getTripFinancials(event.tripId);
    result.when(
      success: (data) {
        printG('[DashboardBloc] trip financials success');
        emit(state.copyWith(tripFinancialsState: BlocStatus.success(data)));
      },
      failure: (message) {
        printY('[DashboardBloc] trip financials failed: $message');
        emit(state.copyWith(tripFinancialsState: BlocStatus.failure(message)));
      },
    );
  }

  Future<void> _onUserWalletRequested(
    _UserWalletRequested event,
    Emitter<DashboardState> emit,
  ) async {
    printM('[DashboardBloc] user wallet requested user=${event.userId}');
    emit(state.copyWith(userWalletState: const BlocStatus.loading()));

    final result = await _facade.getUserWallet(event.userId);
    result.when(
      success: (data) {
        printG('[DashboardBloc] user wallet success balance=${data.balance}');
        emit(state.copyWith(userWalletState: BlocStatus.success(data)));
      },
      failure: (message) {
        printY('[DashboardBloc] user wallet failed: $message');
        emit(state.copyWith(userWalletState: BlocStatus.failure(message)));
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Control Center admin fetch handlers
  // ---------------------------------------------------------------------------

  Future<void> _onAdminConfigRequested(
    _AdminConfigRequested event,
    Emitter<DashboardState> emit,
  ) async {
    printM('[DashboardBloc] admin config requested');
    emit(state.copyWith(adminConfigState: const BlocStatus.loading()));
    final result = await _facade.getAdminConfig();
    result.when(
      success: (data) {
        printG('[DashboardBloc] admin config success');
        emit(state.copyWith(adminConfigState: BlocStatus.success(data)));
      },
      failure: (message) {
        printY('[DashboardBloc] admin config failed: $message');
        emit(state.copyWith(adminConfigState: BlocStatus.failure(message)));
      },
    );
  }

  Future<void> _onAdminVehicleTypesRequested(
    _AdminVehicleTypesRequested event,
    Emitter<DashboardState> emit,
  ) async {
    printM('[DashboardBloc] admin vehicle types requested');
    emit(state.copyWith(adminVehicleTypesState: const BlocStatus.loading()));
    final result = await _facade.getAdminVehicleTypes();
    result.when(
      success: (data) {
        printG(
          '[DashboardBloc] admin vehicle types success count=${data.length}',
        );
        emit(state.copyWith(adminVehicleTypesState: BlocStatus.success(data)));
      },
      failure: (message) {
        printY('[DashboardBloc] admin vehicle types failed: $message');
        emit(
          state.copyWith(adminVehicleTypesState: BlocStatus.failure(message)),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Scoped admin action helpers
  // ---------------------------------------------------------------------------

  /// Runs an admin mutation, shows loading on [actionStateField], then
  /// reloads only the affected [reloadEvents] on success.
  Future<void> _runScopedAdminAction({
    required Emitter<DashboardState> emit,
    required String actionName,
    required Future<Result<void>> Function() action,
    required DashboardState Function(DashboardState s, BlocStatus<void> status)
    applyActionState,
    required List<DashboardEvent> reloadEvents,
  }) async {
    printM('[DashboardBloc] admin action requested action=$actionName');
    emit(applyActionState(state, const BlocStatus.loading()));

    final result = await action();
    await result.when(
      success: (_) async {
        printG('[DashboardBloc] admin action success action=$actionName');
        emit(applyActionState(state, const BlocStatus.success(null)));
        for (final event in reloadEvents) {
          add(event);
        }
      },
      failure: (message) async {
        printY(
          '[DashboardBloc] admin action failed action=$actionName: $message',
        );
        emit(applyActionState(state, BlocStatus.failure(message)));
      },
    );
  }

  Future<void> _onVehicleTypeStatusToggleRequested(
    _VehicleTypeStatusToggleRequested event,
    Emitter<DashboardState> emit,
  ) {
    final vehicleType = event.vehicleType;
    final nextVehicleType = DashboardVehicleTypeEntity(
      id: vehicleType.id,
      code: vehicleType.code,
      name: vehicleType.name,
      capacity: vehicleType.capacity,
      ratePerKm: vehicleType.ratePerKm,
      ratePerMin: vehicleType.ratePerMin,
      minFare: vehicleType.minFare,
      sortOrder: vehicleType.sortOrder,
      isActive: !vehicleType.isActive,
    );
    return _runScopedAdminAction(
      emit: emit,
      actionName:
          'toggleVehicleType:${vehicleType.id}:${nextVehicleType.isActive}',
      action: () => _facade.updateVehicleType(nextVehicleType),
      applyActionState: (s, status) =>
          s.copyWith(vehicleTypeActionState: status),
      reloadEvents: [const DashboardEvent.adminVehicleTypesRequested()],
    );
  }

  Future<void> _onVehicleTypeRemovalRequested(
    _VehicleTypeRemovalRequested event,
    Emitter<DashboardState> emit,
  ) {
    return _runScopedAdminAction(
      emit: emit,
      actionName: 'removeVehicleType:${event.vehicleTypeId}',
      action: () => _facade.removeVehicleType(event.vehicleTypeId),
      applyActionState: (s, status) =>
          s.copyWith(vehicleTypeActionState: status),
      reloadEvents: [const DashboardEvent.adminVehicleTypesRequested()],
    );
  }

  Future<void> _onVehicleTypeCreateRequested(
    _VehicleTypeCreateRequested event,
    Emitter<DashboardState> emit,
  ) {
    return _runScopedAdminAction(
      emit: emit,
      actionName: 'createVehicleType:${event.code}',
      action: () => _facade.createVehicleType(
        code: event.code,
        name: event.name,
        capacity: event.capacity,
        ratePerKm: event.ratePerKm,
        ratePerMin: event.ratePerMin,
        minFare: event.minFare,
        sortOrder: event.sortOrder,
      ),
      applyActionState: (s, status) =>
          s.copyWith(vehicleTypeActionState: status),
      reloadEvents: [const DashboardEvent.adminVehicleTypesRequested()],
    );
  }

  Future<void> _onVehicleTypeUpdateRequested(
    _VehicleTypeUpdateRequested event,
    Emitter<DashboardState> emit,
  ) {
    return _runScopedAdminAction(
      emit: emit,
      actionName: 'updateVehicleType:${event.vehicleType.id}',
      action: () => _facade.updateVehicleType(event.vehicleType),
      applyActionState: (s, status) =>
          s.copyWith(vehicleTypeActionState: status),
      reloadEvents: [const DashboardEvent.adminVehicleTypesRequested()],
    );
  }

  Future<void> _onTripDiscountUpdateRequested(
    _TripDiscountUpdateRequested event,
    Emitter<DashboardState> emit,
  ) {
    return _runScopedAdminAction(
      emit: emit,
      actionName: 'updateTripDiscount:${event.discountPercent}',
      action: () => _facade.updateTripDiscount(event.discountPercent),
      applyActionState: (s, status) => s.copyWith(configActionState: status),
      reloadEvents: [const DashboardEvent.adminConfigRequested()],
    );
  }

  Future<void> _onCurrencyUpdateRequested(
    _CurrencyUpdateRequested event,
    Emitter<DashboardState> emit,
  ) {
    return _runScopedAdminAction(
      emit: emit,
      actionName: 'updateCurrency:${event.currencyCode}',
      action: () => _facade.updateCurrency(event.currencyCode),
      applyActionState: (s, status) => s.copyWith(configActionState: status),
      reloadEvents: [const DashboardEvent.adminConfigRequested()],
    );
  }

  @override
  Future<void> close() {
    _realtimeSub?.cancel();
    _connectionSub?.cancel();
    _overviewRefreshTimer?.cancel();
    _adminTripsRefreshTimer?.cancel();
    _adminSearchDebounce?.cancel();
    for (final id in _joinedTripGroups) {
      unawaited(_realtimeService.leaveTripGroup(id));
    }
    _joinedTripGroups.clear();
    return super.close();
  }
}
