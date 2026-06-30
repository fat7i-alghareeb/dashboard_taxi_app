import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:dashboardtaxi/core/services/realtime/realtime_event.dart';
import 'package:dashboardtaxi/core/services/realtime/realtime_service.dart';
import 'package:dashboardtaxi/core/utils/bloc_status.dart';
import 'package:dashboardtaxi/core/utils/result.dart';
import 'package:dashboardtaxi/features/refunds/domain/entities/refund_entity.dart';
import 'package:dashboardtaxi/features/refunds/domain/facade/refunds_facade.dart';

enum RefundStatusFilter { all, failed, pending, succeeded, requiresAction }

enum RefundSourceFilter { all, cancellation, manualIncident, compensation }

class RefundsState {
  const RefundsState({
    this.listState = const BlocStatus<List<RefundEntity>>.initial(),
    this.detailState = const BlocStatus<RefundEntity>.initial(),
    this.retryState = const BlocStatus<RefundEntity>.initial(),
    this.statusFilter = RefundStatusFilter.all,
    this.sourceFilter = RefundSourceFilter.all,
    this.search = '',
  });

  final BlocStatus<List<RefundEntity>> listState;
  final BlocStatus<RefundEntity> detailState;
  final BlocStatus<RefundEntity> retryState;
  final RefundStatusFilter statusFilter;
  final RefundSourceFilter sourceFilter;
  final String search;

  List<RefundEntity> get filteredRefunds {
    final refunds = listState.getDataWhenSuccess ?? const <RefundEntity>[];
    final query = search.trim().toLowerCase();
    final filtered = refunds.where((refund) {
      final statusMatches = switch (statusFilter) {
        RefundStatusFilter.all => true,
        RefundStatusFilter.failed => refund.isFailedLike,
        RefundStatusFilter.pending => refund.isPendingLike,
        RefundStatusFilter.succeeded => refund.isSucceeded,
        RefundStatusFilter.requiresAction => refund.isRequiresAction,
      };
      final sourceMatches = switch (sourceFilter) {
        RefundSourceFilter.all => true,
        RefundSourceFilter.cancellation =>
          refund.sourceType.toLowerCase().contains('cancellation'),
        RefundSourceFilter.manualIncident =>
          refund.sourceType.toLowerCase() == 'manualincidentrefund',
        RefundSourceFilter.compensation =>
          refund.sourceType.toLowerCase() == 'compensationclaim',
      };
      final queryMatches =
          query.isEmpty ||
          refund.refundId.toLowerCase().contains(query) ||
          (refund.tripId?.toLowerCase().contains(query) ?? false) ||
          (refund.passengerId?.toLowerCase().contains(query) ?? false) ||
          (refund.paymentMethod?.toLowerCase().contains(query) ?? false);
      return statusMatches && sourceMatches && queryMatches;
    }).toList();
    filtered.sort(_sortRefunds);
    return filtered;
  }

  RefundsState copyWith({
    BlocStatus<List<RefundEntity>>? listState,
    BlocStatus<RefundEntity>? detailState,
    BlocStatus<RefundEntity>? retryState,
    RefundStatusFilter? statusFilter,
    RefundSourceFilter? sourceFilter,
    String? search,
  }) {
    return RefundsState(
      listState: listState ?? this.listState,
      detailState: detailState ?? this.detailState,
      retryState: retryState ?? this.retryState,
      statusFilter: statusFilter ?? this.statusFilter,
      sourceFilter: sourceFilter ?? this.sourceFilter,
      search: search ?? this.search,
    );
  }

  static int _sortRefunds(RefundEntity a, RefundEntity b) {
    final actionCompare = _priority(a).compareTo(_priority(b));
    if (actionCompare != 0) return actionCompare;
    final aDate = a.requestedAtUtc ?? DateTime.fromMillisecondsSinceEpoch(0);
    final bDate = b.requestedAtUtc ?? DateTime.fromMillisecondsSinceEpoch(0);
    return bDate.compareTo(aDate);
  }

  static int _priority(RefundEntity refund) {
    if (refund.isRequiresAction) return 0;
    if (refund.isFailedLike) return 1;
    if (refund.isPendingLike) return 2;
    return 3;
  }
}

@injectable
class RefundsCubit extends Cubit<RefundsState> {
  RefundsCubit(this._facade, this._realtimeService)
    : super(const RefundsState()) {
    _realtimeSub = _realtimeService.events.listen(_onRealtimeEvent);
  }

  final RefundsFacade _facade;
  final RealtimeService _realtimeService;
  StreamSubscription<RealtimeEvent>? _realtimeSub;

  Future<void> loadRefunds() async {
    emit(state.copyWith(listState: const BlocStatus.loading()));
    final result = await _facade.getRefunds();
    result.map(
      success: (value) =>
          emit(state.copyWith(listState: BlocStatus.success(value.data))),
      failure: (value) =>
          emit(state.copyWith(listState: BlocStatus.failure(value.message))),
    );
  }

  Future<void> loadRefundDetail(String refundId) async {
    emit(state.copyWith(detailState: const BlocStatus.loading()));
    final result = await _facade.getRefundDetail(refundId);
    result.map(
      success: (value) =>
          emit(state.copyWith(detailState: BlocStatus.success(value.data))),
      failure: (value) =>
          emit(state.copyWith(detailState: BlocStatus.failure(value.message))),
    );
  }

  Future<void> retryRefund(String refundId, {String? note}) async {
    emit(state.copyWith(retryState: const BlocStatus.loading()));
    final result = await _facade.retryRefund(refundId: refundId, note: note);
    result.map(
      success: (value) {
        final refund = value.data;
        final current = state.listState.getDataWhenSuccess;
        emit(
          state.copyWith(
            retryState: BlocStatus.success(refund),
            detailState: BlocStatus.success(refund),
            listState: current == null
                ? state.listState
                : BlocStatus.success(_replaceRefund(current, refund)),
          ),
        );
      },
      failure: (value) =>
          emit(state.copyWith(retryState: BlocStatus.failure(value.message))),
    );
  }

  void setStatusFilter(RefundStatusFilter filter) {
    emit(state.copyWith(statusFilter: filter));
  }

  void setSourceFilter(RefundSourceFilter filter) {
    emit(state.copyWith(sourceFilter: filter));
  }

  void setSearch(String value) {
    emit(state.copyWith(search: value));
  }

  void clearRetryState() {
    emit(state.copyWith(retryState: const BlocStatus.initial()));
  }

  @override
  Future<void> close() async {
    await _realtimeSub?.cancel();
    return super.close();
  }

  void _onRealtimeEvent(RealtimeEvent event) {
    switch (event) {
      case RealtimeRefundLifecycleChanged(:final refundId):
        unawaited(loadRefunds());
        final currentDetail = state.detailState.getDataWhenSuccess;
        if (currentDetail?.refundId == refundId) {
          unawaited(loadRefundDetail(refundId));
        }
        break;
      case RealtimeRefundIssueCreated():
        unawaited(loadRefunds());
        break;
      default:
        break;
    }
  }

  List<RefundEntity> _replaceRefund(
    List<RefundEntity> current,
    RefundEntity refund,
  ) {
    return current
        .map((item) => item.refundId == refund.refundId ? refund : item)
        .toList();
  }
}
