import 'package:injectable/injectable.dart';
import 'package:dashboardtaxi/core/error/global_error_handler.dart';
import 'package:dashboardtaxi/core/utils/result.dart';
import 'package:dashboardtaxi/features/refunds/data/datasources/refunds_remote_datasource.dart';
import 'package:dashboardtaxi/features/refunds/data/mappers/refund_mapper.dart';
import 'package:dashboardtaxi/features/refunds/domain/entities/refund_entity.dart';
import 'package:dashboardtaxi/features/refunds/domain/repositories/refunds_repository.dart';

@LazySingleton(as: RefundsRepository)
class RefundsRepositoryImpl implements RefundsRepository {
  const RefundsRepositoryImpl(this._remote);

  final RefundsRemoteDataSource _remote;

  @override
  Future<Result<List<RefundEntity>>> getRefunds() {
    return runAsResult(() async {
      final models = await _remote.getRefunds();
      return models.map((model) => model.toEntity).toList();
    });
  }

  @override
  Future<Result<RefundEntity>> getRefundDetail(String refundId) {
    return runAsResult(() async {
      final model = await _remote.getRefundDetail(refundId);
      return model.toEntity;
    });
  }

  @override
  Future<Result<RefundEntity>> retryRefund({
    required String refundId,
    String? note,
  }) {
    return runAsResult(() async {
      final model = await _remote.retryRefund(refundId: refundId, note: note);
      return model.toEntity;
    });
  }
}
