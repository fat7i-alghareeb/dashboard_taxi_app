import 'package:dashboardtaxi/core/utils/result.dart';
import 'package:dashboardtaxi/features/refunds/domain/entities/refund_entity.dart';
import 'package:dashboardtaxi/features/refunds/domain/entities/refund_enums.dart';
import 'package:dashboardtaxi/features/refunds/domain/entities/refunds_page_entity.dart';

abstract class RefundsRepository {
  Future<Result<RefundsPageEntity>> getRefunds({
    required int page,
    required int pageSize,
    RefundStatus? status,
    RefundSourceType? sourceType,
  });

  Future<Result<RefundEntity>> getRefundDetail(String refundId);

  Future<Result<RefundEntity>> getCancellationRefundDetail(
    String tripCancellationId,
  );

  Future<Result<RefundEntity>> retryRefund({
    required String refundId,
    String? note,
  });
}
