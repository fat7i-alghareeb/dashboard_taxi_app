import 'package:injectable/injectable.dart';
import 'package:dashboardtaxi/core/error/global_error_handler.dart';
import 'package:dashboardtaxi/core/utils/result.dart';
import 'package:dashboardtaxi/features/refunds/data/datasources/refunds_remote_datasource.dart';
import 'package:dashboardtaxi/features/refunds/data/mappers/refund_mapper.dart';
import 'package:dashboardtaxi/features/refunds/data/models/refunds_query_model.dart';
import 'package:dashboardtaxi/features/refunds/domain/entities/refund_entity.dart';
import 'package:dashboardtaxi/features/refunds/domain/entities/refund_enums.dart';
import 'package:dashboardtaxi/features/refunds/domain/entities/refunds_page_entity.dart';
import 'package:dashboardtaxi/features/refunds/domain/repositories/refunds_repository.dart';

@LazySingleton(as: RefundsRepository)
class RefundsRepositoryImpl implements RefundsRepository {
  const RefundsRepositoryImpl(this._remote);

  final RefundsRemoteDataSource _remote;

  @override
  Future<Result<RefundsPageEntity>> getRefunds({
    required int page,
    required int pageSize,
    RefundStatus? status,
    RefundSourceType? sourceType,
  }) {
    return runAsResult(() async {
      final model = await _remote.getRefunds(
        RefundsQueryModel(
          page: page,
          pageSize: pageSize,
          status: status?.toJson(),
          sourceType: sourceType?.toJson(),
        ),
      );
      return RefundsPageEntity(
        items: model.items.map((item) => item.toEntity).toList(),
        totalCount: model.totalCount,
        page: model.page,
        pageSize: model.pageSize,
      );
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
  Future<Result<RefundEntity>> getCancellationRefundDetail(
    String tripCancellationId,
  ) {
    return runAsResult(() async {
      final model = await _remote.getCancellationRefundDetail(
        tripCancellationId,
      );
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
