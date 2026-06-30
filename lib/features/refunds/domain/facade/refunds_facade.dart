import 'package:injectable/injectable.dart';
import 'package:dashboardtaxi/core/utils/result.dart';
import 'package:dashboardtaxi/features/refunds/domain/entities/refund_entity.dart';
import 'package:dashboardtaxi/features/refunds/domain/repositories/refunds_repository.dart';

@lazySingleton
class RefundsFacade {
  const RefundsFacade(this._repository);

  final RefundsRepository _repository;

  Future<Result<List<RefundEntity>>> getRefunds() => _repository.getRefunds();

  Future<Result<RefundEntity>> getRefundDetail(String refundId) =>
      _repository.getRefundDetail(refundId);

  Future<Result<RefundEntity>> retryRefund({
    required String refundId,
    String? note,
  }) {
    return _repository.retryRefund(refundId: refundId, note: note);
  }
}
