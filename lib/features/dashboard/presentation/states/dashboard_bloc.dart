import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/services/realtime/realtime_event.dart';
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
    on<_TripDetailsRequested>(_onTripDetailsRequested);
    on<_AdminOperationsRequested>(_onAdminOperationsRequested);
    on<_DriverSuspensionRequested>(_onDriverSuspensionRequested);
    on<_DriverVehicleTypeAssignmentRequested>(
      _onDriverVehicleTypeAssignmentRequested,
    );
    on<_VehicleTypeStatusToggleRequested>(_onVehicleTypeStatusToggleRequested);
    on<_VehicleTypeRemovalRequested>(_onVehicleTypeRemovalRequested);
    on<_TripDiscountUpdateRequested>(_onTripDiscountUpdateRequested);
    on<_CurrencyUpdateRequested>(_onCurrencyUpdateRequested);

    _realtimeSub = _realtimeService.events.listen((final event) {
      if (event case RealtimeDriverLocationUpdated(
        :final driverId,
        :final latitude,
        :final longitude,
      )) {
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
      }
    });
  }

  final DashboardFacade _facade;
  final RealtimeService _realtimeService;
  final RootModeService _rootModeService;
  StreamSubscription<RealtimeEvent>? _realtimeSub;

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
    emit(state.copyWith(adminTripsState: const BlocStatus.loading()));

    final result = await _facade.getAdminTrips(status: event.status);
    result.when(
      success: (data) {
        printG('[DashboardBloc] admin trips success count=${data.length}');
        emit(state.copyWith(adminTripsState: BlocStatus.success(data)));
      },
      failure: (message) {
        printY('[DashboardBloc] admin trips failed: $message');
        emit(state.copyWith(adminTripsState: BlocStatus.failure(message)));
      },
    );
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

  Future<void> _onAdminOperationsRequested(
    _AdminOperationsRequested event,
    Emitter<DashboardState> emit,
  ) async {
    printM('[DashboardBloc] admin operations requested');
    emit(state.copyWith(adminOperationsState: const BlocStatus.loading()));

    final result = await _facade.getAdminOperations();
    result.when(
      success: (data) {
        printG(
          '[DashboardBloc] admin operations success drivers=${data.drivers.length} vehicleTypes=${data.vehicleTypes.length}',
        );
        emit(state.copyWith(adminOperationsState: BlocStatus.success(data)));
      },
      failure: (message) {
        printY('[DashboardBloc] admin operations failed: $message');
        emit(state.copyWith(adminOperationsState: BlocStatus.failure(message)));
      },
    );
  }

  Future<void> _runAdminAction(
    Emitter<DashboardState> emit,
    String actionName,
    Future<Result<void>> Function() action,
  ) async {
    printM('[DashboardBloc] admin action requested action=$actionName');
    emit(state.copyWith(adminActionState: const BlocStatus.loading()));

    final result = await action();
    await result.when(
      success: (_) async {
        printG('[DashboardBloc] admin action success action=$actionName');
        emit(state.copyWith(adminActionState: const BlocStatus.success(null)));
        add(const DashboardEvent.adminOperationsRequested());
        add(const DashboardEvent.overviewRequested());
      },
      failure: (message) async {
        printY(
          '[DashboardBloc] admin action failed action=$actionName: $message',
        );
        emit(state.copyWith(adminActionState: BlocStatus.failure(message)));
      },
    );
  }

  Future<void> _onDriverSuspensionRequested(
    _DriverSuspensionRequested event,
    Emitter<DashboardState> emit,
  ) {
    return _runAdminAction(
      emit,
      'suspendDriver:${event.driverId}',
      () => _facade.suspendDriver(event.driverId),
    );
  }

  Future<void> _onDriverVehicleTypeAssignmentRequested(
    _DriverVehicleTypeAssignmentRequested event,
    Emitter<DashboardState> emit,
  ) {
    return _runAdminAction(
      emit,
      'assignDriverVehicleType:${event.driverId}:${event.vehicleTypeId}',
      () => _facade.assignDriverVehicleType(
        driverId: event.driverId,
        vehicleTypeId: event.vehicleTypeId,
      ),
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
    return _runAdminAction(
      emit,
      'toggleVehicleType:${vehicleType.id}:${nextVehicleType.isActive}',
      () => _facade.updateVehicleType(nextVehicleType),
    );
  }

  Future<void> _onVehicleTypeRemovalRequested(
    _VehicleTypeRemovalRequested event,
    Emitter<DashboardState> emit,
  ) {
    return _runAdminAction(
      emit,
      'removeVehicleType:${event.vehicleTypeId}',
      () => _facade.removeVehicleType(event.vehicleTypeId),
    );
  }

  Future<void> _onTripDiscountUpdateRequested(
    _TripDiscountUpdateRequested event,
    Emitter<DashboardState> emit,
  ) {
    return _runAdminAction(
      emit,
      'updateTripDiscount:${event.discountPercent}',
      () => _facade.updateTripDiscount(event.discountPercent),
    );
  }

  Future<void> _onCurrencyUpdateRequested(
    _CurrencyUpdateRequested event,
    Emitter<DashboardState> emit,
  ) {
    return _runAdminAction(
      emit,
      'updateCurrency:${event.currencyCode}',
      () => _facade.updateCurrency(event.currencyCode),
    );
  }

  @override
  Future<void> close() {
    _realtimeSub?.cancel();
    return super.close();
  }
}
