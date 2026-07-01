import 'package:injectable/injectable.dart';
import 'package:dashboardtaxi/core/utils/result.dart';
import 'package:dashboardtaxi/features/refunds/domain/entities/refund_entity.dart';
import 'package:dashboardtaxi/features/refunds/domain/entities/refund_enums.dart';
import 'package:dashboardtaxi/features/refunds/domain/entities/refunds_page_entity.dart';
import 'package:dashboardtaxi/features/refunds/domain/repositories/refunds_repository.dart';

@lazySingleton
class RefundsFacade {
  const RefundsFacade(this._repository);

  final RefundsRepository _repository;

  Future<Result<RefundsPageEntity>> getRefunds({
    required int page,
    required int pageSize,
    RefundStatus? status,
    RefundSourceType? sourceType,
  }) {
    return _repository.getRefunds(
      page: page,
      pageSize: pageSize,
      status: status,
      sourceType: sourceType,
    );
  }

  Future<Result<RefundEntity>> getRefundDetail(String refundId) =>
      _repository.getRefundDetail(refundId);

  Future<Result<RefundEntity>> getCancellationRefundDetail(
    String tripCancellationId,
  ) {
    return _repository.getCancellationRefundDetail(tripCancellationId);
  }

  Future<Result<RefundEntity>> retryRefund({
    required String refundId,
    String? note,
  }) {
    return _repository.retryRefund(refundId: refundId, note: note);
  }
}
