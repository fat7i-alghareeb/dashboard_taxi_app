import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/utils/bloc_status.dart';
import '../../../../core/utils/result.dart';
import '../../data/datasources/customer_incidents_remote_datasource.dart';
import '../../domain/entities/customer_incident_entity.dart';

class CustomerIncidentDetailState {
  const CustomerIncidentDetailState({
    this.detailState = const BlocStatus<CustomerIncidentDetailEntity>.initial(),
    this.actionState = const BlocStatus<void>.initial(),
  });

  final BlocStatus<CustomerIncidentDetailEntity> detailState;
  final BlocStatus<void> actionState;

  CustomerIncidentDetailState copyWith({
    BlocStatus<CustomerIncidentDetailEntity>? detailState,
    BlocStatus<void>? actionState,
  }) {
    return CustomerIncidentDetailState(
      detailState: detailState ?? this.detailState,
      actionState: actionState ?? this.actionState,
    );
  }
}

@injectable
class CustomerIncidentDetailCubit extends Cubit<CustomerIncidentDetailState> {
  CustomerIncidentDetailCubit(this._dataSource)
    : super(const CustomerIncidentDetailState());

  final CustomerIncidentsRemoteDataSource _dataSource;

  Future<void> load(String incidentId) async {
    emit(state.copyWith(detailState: const BlocStatus.loading()));
    final result = await runAsResult(() async {
      final model = await _dataSource.getDetail(incidentId);
      return model.toEntity;
    });
    result.when(
      success: (detail) =>
          emit(state.copyWith(detailState: BlocStatus.success(detail))),
      failure: (msg) =>
          emit(state.copyWith(detailState: BlocStatus.failure(msg))),
    );
  }

  Future<void> changeStatus({
    required String incidentId,
    required String status,
    String? note,
  }) async {
    await _runAction(
      () => _dataSource.changeStatus(
        incidentId: incidentId,
        status: status,
        note: note,
      ),
      reloadId: incidentId,
    );
  }

  Future<void> refund({required String incidentId, double? amount}) async {
    await _runAction(
      () => _dataSource.refund(incidentId: incidentId, amount: amount),
      reloadId: incidentId,
    );
  }

  Future<void> contact({
    required String incidentId,
    required String title,
    required String body,
  }) async {
    await _runAction(
      () =>
          _dataSource.contactPassenger(incidentId: incidentId, title: title, body: body),
    );
  }

  Future<void> suspend({required String userId, String? reason}) async {
    await _runAction(
      () => _dataSource.suspendPassenger(userId: userId, reason: reason),
    );
  }

  Future<void> reactivate({required String userId}) async {
    await _runAction(() => _dataSource.reactivatePassenger(userId: userId));
  }

  Future<void> _runAction(
    Future<void> Function() action, {
    String? reloadId,
  }) async {
    emit(state.copyWith(actionState: const BlocStatus.loading()));
    final result = await runAsResult(action);
    await result.when(
      success: (_) async {
        emit(state.copyWith(actionState: const BlocStatus.success(null)));
        if (reloadId != null) {
          await load(reloadId);
        }
      },
      failure: (msg) async =>
          emit(state.copyWith(actionState: BlocStatus.failure(msg))),
    );
  }
}
