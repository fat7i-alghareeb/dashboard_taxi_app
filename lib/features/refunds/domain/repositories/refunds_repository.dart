import 'package:dashboardtaxi/core/utils/result.dart';
import 'package:dashboardtaxi/features/refunds/domain/entities/refund_entity.dart';

abstract class RefundsRepository {
  Future<Result<List<RefundEntity>>> getRefunds();
  Future<Result<RefundEntity>> getRefundDetail(String refundId);
  Future<Result<RefundEntity>> retryRefund({
    required String refundId,
    String? note,
  });
}
