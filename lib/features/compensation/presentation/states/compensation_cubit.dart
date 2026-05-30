import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/utils/bloc_status.dart';
import '../../../../core/utils/result.dart';
import '../../data/datasources/compensation_remote_datasource.dart';
import '../../domain/entities/compensation_claim_entity.dart';

class CompensationState {
  const CompensationState({
    this.claimsState = const BlocStatus<List<CompensationClaimEntity>>.initial(),
    this.reviewState = const BlocStatus<void>.initial(),
  });

  final BlocStatus<List<CompensationClaimEntity>> claimsState;
  final BlocStatus<void> reviewState;

  CompensationState copyWith({
    BlocStatus<List<CompensationClaimEntity>>? claimsState,
    BlocStatus<void>? reviewState,
  }) {
    return CompensationState(
      claimsState: claimsState ?? this.claimsState,
      reviewState: reviewState ?? this.reviewState,
    );
  }
}

@injectable
class CompensationCubit extends Cubit<CompensationState> {
  CompensationCubit(this._dataSource) : super(const CompensationState());

  final CompensationRemoteDataSource _dataSource;

  Future<void> loadPending() async {
    emit(state.copyWith(claimsState: const BlocStatus.loading()));
    final result = await runAsResult(() async {
      final models = await _dataSource.getClaims(status: 'Pending');
      return models.map((m) => m.toEntity).toList();
    });
    result.when(
      success: (claims) =>
          emit(state.copyWith(claimsState: BlocStatus.success(claims))),
      failure: (msg) =>
          emit(state.copyWith(claimsState: BlocStatus.failure(msg))),
    );
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
        await loadPending();
      },
      failure: (msg) async =>
          emit(state.copyWith(reviewState: BlocStatus.failure(msg))),
    );
  }
}
