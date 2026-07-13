import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/utils/bloc_status.dart';
import '../../../../core/utils/result.dart';
import '../../data/datasources/compensation_remote_datasource.dart';
import '../../domain/entities/compensation_claim_entity.dart';

enum CompensationStatusFilter { all, pending, approved, rejected }

class CompensationState {
  const CompensationState({
    this.claimsState = const BlocStatus<List<CompensationClaimEntity>>.initial(),
    this.reviewState = const BlocStatus<void>.initial(),
    this.statusFilter = CompensationStatusFilter.pending,
    this.search = '',
  });

  final BlocStatus<List<CompensationClaimEntity>> claimsState;
  final BlocStatus<void> reviewState;
  final CompensationStatusFilter statusFilter;
  final String search;

  List<CompensationClaimEntity> get filteredClaims {
    final claims =
        claimsState.getDataWhenSuccess ?? const <CompensationClaimEntity>[];
    final query = search.trim().toLowerCase();
    if (query.isEmpty) return claims;
    return claims
        .where(
          (claim) =>
              claim.tripId.toLowerCase().contains(query) ||
              claim.note.toLowerCase().contains(query),
        )
        .toList();
  }

  CompensationState copyWith({
    BlocStatus<List<CompensationClaimEntity>>? claimsState,
    BlocStatus<void>? reviewState,
    CompensationStatusFilter? statusFilter,
    String? search,
  }) {
    return CompensationState(
      claimsState: claimsState ?? this.claimsState,
      reviewState: reviewState ?? this.reviewState,
      statusFilter: statusFilter ?? this.statusFilter,
      search: search ?? this.search,
    );
  }
}

@injectable
class CompensationCubit extends Cubit<CompensationState> {
  CompensationCubit(this._dataSource) : super(const CompensationState());

  final CompensationRemoteDataSource _dataSource;

  Future<void> loadClaims() async {
    emit(state.copyWith(claimsState: const BlocStatus.loading()));
    final result = await runAsResult(() async {
      final models = await _dataSource.getClaims(
        status: _statusQuery(state.statusFilter),
      );
      return models.map((m) => m.toEntity).toList();
    });
    result.when(
      success: (claims) =>
          emit(state.copyWith(claimsState: BlocStatus.success(claims))),
      failure: (msg) =>
          emit(state.copyWith(claimsState: BlocStatus.failure(msg))),
    );
  }

  void setStatusFilter(CompensationStatusFilter filter) {
    emit(state.copyWith(statusFilter: filter));
    unawaited(loadClaims());
  }

  void setSearch(String value) {
    emit(state.copyWith(search: value));
  }

  String? _statusQuery(CompensationStatusFilter filter) {
    return switch (filter) {
      CompensationStatusFilter.all => null,
      CompensationStatusFilter.pending => 'Pending',
      CompensationStatusFilter.approved => 'Approved',
      CompensationStatusFilter.rejected => 'Rejected',
    };
  }

  Future<void> review({
    required String claimId,
    required bool approved,
    String? notes,
  }) async {
    emit(state.copyWith(reviewState: const BlocStatus.loading()));
    final result = await runAsResult(
      () => _dataSource.reviewClaim(
        claimId: claimId,
        approved: approved,
        notes: notes,
      ),
    );
    await result.when(
      success: (_) async {
        emit(state.copyWith(reviewState: const BlocStatus.success(null)));
        await loadClaims();
      },
      failure: (msg) async =>
          emit(state.copyWith(reviewState: BlocStatus.failure(msg))),
    );
  }
}
