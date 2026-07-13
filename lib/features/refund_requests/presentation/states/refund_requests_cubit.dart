import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:dashboardtaxi/core/services/realtime/realtime_event.dart';
import 'package:dashboardtaxi/core/services/realtime/realtime_service.dart';
import 'package:dashboardtaxi/core/utils/bloc_status.dart';
import 'package:dashboardtaxi/core/utils/result.dart';
import 'package:dashboardtaxi/features/refund_requests/domain/entities/refund_issue_entity.dart';
import 'package:dashboardtaxi/features/refund_requests/domain/entities/refund_issue_enums.dart';
import 'package:dashboardtaxi/features/refund_requests/domain/facade/refund_requests_facade.dart';

enum RefundRequestStatusFilter { all, open, inReview, resolved, dismissed }

class RefundRequestsState {
  const RefundRequestsState({
    this.listState = const BlocStatus<List<RefundIssueEntity>>.initial(),
    this.reviewState = const BlocStatus<RefundIssueEntity>.initial(),
    this.statusFilter = RefundRequestStatusFilter.all,
    this.search = '',
    this.page = 1,
    this.pageSize = 20,
    this.totalCount = 0,
    this.hasMore = false,
    this.isLoadingMore = false,
  });

  final BlocStatus<List<RefundIssueEntity>> listState;
  final BlocStatus<RefundIssueEntity> reviewState;
  final RefundRequestStatusFilter statusFilter;
  final String search;
  final int page;
  final int pageSize;
  final int totalCount;
  final bool hasMore;
  final bool isLoadingMore;

  List<RefundIssueEntity> get sortedItems {
    final items = [...?listState.getDataWhenSuccess];
    items.sort((a, b) {
      final statusCompare = _priority(a).compareTo(_priority(b));
      if (statusCompare != 0) return statusCompare;
      return b.createdAtUtc.compareTo(a.createdAtUtc);
    });
    return items;
  }

  List<RefundIssueEntity> get filteredItems {
    final query = search.trim().toLowerCase();
    if (query.isEmpty) return sortedItems;
    return sortedItems
        .where(
          (issue) =>
              issue.tripId.toLowerCase().contains(query) ||
              (issue.tripReferenceCode?.toLowerCase().contains(query) ??
                  false) ||
              issue.passengerId.toLowerCase().contains(query) ||
              (issue.passengerName?.toLowerCase().contains(query) ?? false),
        )
        .toList();
  }

  RefundRequestsState copyWith({
    BlocStatus<List<RefundIssueEntity>>? listState,
    BlocStatus<RefundIssueEntity>? reviewState,
    RefundRequestStatusFilter? statusFilter,
    String? search,
    int? page,
    int? pageSize,
    int? totalCount,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return RefundRequestsState(
      listState: listState ?? this.listState,
      reviewState: reviewState ?? this.reviewState,
      statusFilter: statusFilter ?? this.statusFilter,
      search: search ?? this.search,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      totalCount: totalCount ?? this.totalCount,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  static int _priority(RefundIssueEntity issue) {
    if (issue.isOpen) return 0;
    if (issue.reviewStatus.isInReview) return 1;
    if (issue.isResolved) return 2;
    return 3;
  }
}

@injectable
class RefundRequestsCubit extends Cubit<RefundRequestsState> {
  RefundRequestsCubit(this._facade, this._realtimeService)
    : super(const RefundRequestsState()) {
    _realtimeSub = _realtimeService.events.listen(_onRealtimeEvent);
  }

  final RefundRequestsFacade _facade;
  final RealtimeService _realtimeService;
  StreamSubscription<RealtimeEvent>? _realtimeSub;

  Future<void> loadRequests() async {
    emit(
      state.copyWith(
        listState: const BlocStatus.loading(),
        page: 1,
        totalCount: 0,
        hasMore: false,
        isLoadingMore: false,
      ),
    );
    final result = await _facade.getRefundIssues(
      page: 1,
      pageSize: state.pageSize,
      reviewStatus: _statusQuery(state.statusFilter),
    );
    result.map(
      success: (value) => emit(
        state.copyWith(
          listState: BlocStatus.success(value.data.items),
          page: value.data.page,
          pageSize: value.data.pageSize,
          totalCount: value.data.totalCount,
          hasMore: value.data.hasMore,
        ),
      ),
      failure: (value) =>
          emit(state.copyWith(listState: BlocStatus.failure(value.message))),
    );
  }

  Future<void> loadMoreRequests() async {
    if (!state.hasMore || state.isLoadingMore || state.listState.isLoading) {
      return;
    }

    final current =
        state.listState.getDataWhenSuccess ?? const <RefundIssueEntity>[];
    emit(state.copyWith(isLoadingMore: true));
    final result = await _facade.getRefundIssues(
      page: state.page + 1,
      pageSize: state.pageSize,
      reviewStatus: _statusQuery(state.statusFilter),
    );
    result.map(
      success: (value) => emit(
        state.copyWith(
          listState: BlocStatus.success([...current, ...value.data.items]),
          page: value.data.page,
          pageSize: value.data.pageSize,
          totalCount: value.data.totalCount,
          hasMore: value.data.hasMore,
          isLoadingMore: false,
        ),
      ),
      failure: (_) => emit(state.copyWith(isLoadingMore: false)),
    );
  }

  void setStatusFilter(RefundRequestStatusFilter filter) {
    emit(state.copyWith(statusFilter: filter));
    unawaited(loadRequests());
  }

  void setSearch(String value) {
    emit(state.copyWith(search: value));
  }

  Future<void> reviewRequest({
    required RefundIssueEntity issue,
    required RefundIssueReviewStatus reviewStatus,
  }) async {
    emit(state.copyWith(reviewState: const BlocStatus.loading()));
    final result = await _facade.reviewRefundIssue(
      refundIssueId: issue.id,
      reviewStatus: reviewStatus,
    );
    result.map(
      success: (value) {
        final current =
            state.listState.getDataWhenSuccess ?? const <RefundIssueEntity>[];
        emit(
          state.copyWith(
            reviewState: BlocStatus.success(value.data),
            listState: BlocStatus.success(
              current
                  .map((item) => item.id == value.data.id ? value.data : item)
                  .toList(),
            ),
          ),
        );
      },
      failure: (value) =>
          emit(state.copyWith(reviewState: BlocStatus.failure(value.message))),
    );
  }

  void clearReviewState() {
    emit(state.copyWith(reviewState: const BlocStatus.initial()));
  }

  @override
  Future<void> close() async {
    await _realtimeSub?.cancel();
    return super.close();
  }

  void _onRealtimeEvent(RealtimeEvent event) {
    if (event is RealtimeRefundIssueCreated) {
      unawaited(loadRequests());
    }
  }

  RefundIssueReviewStatus? _statusQuery(RefundRequestStatusFilter filter) {
    return switch (filter) {
      RefundRequestStatusFilter.all => null,
      RefundRequestStatusFilter.open => RefundIssueReviewStatus.open,
      RefundRequestStatusFilter.inReview => RefundIssueReviewStatus.inReview,
      RefundRequestStatusFilter.resolved => RefundIssueReviewStatus.resolved,
      RefundRequestStatusFilter.dismissed => RefundIssueReviewStatus.dismissed,
    };
  }
}
