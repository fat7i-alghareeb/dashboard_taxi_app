import 'package:injectable/injectable.dart';
import 'package:dashboardtaxi/core/error/global_error_handler.dart';
import 'package:dashboardtaxi/core/utils/result.dart';
import 'package:dashboardtaxi/features/refund_requests/data/datasources/refund_requests_remote_datasource.dart';
import 'package:dashboardtaxi/features/refund_requests/data/mappers/refund_issue_mapper.dart';
import 'package:dashboardtaxi/features/refund_requests/data/models/refund_issues_query_model.dart';
import 'package:dashboardtaxi/features/refund_requests/data/models/review_refund_issue_request_model.dart';
import 'package:dashboardtaxi/features/refund_requests/domain/entities/refund_issue_entity.dart';
import 'package:dashboardtaxi/features/refund_requests/domain/entities/refund_issue_enums.dart';
import 'package:dashboardtaxi/features/refund_requests/domain/entities/refund_issues_page_entity.dart';
import 'package:dashboardtaxi/features/refund_requests/domain/repositories/refund_requests_repository.dart';

@LazySingleton(as: RefundRequestsRepository)
class RefundRequestsRepositoryImpl implements RefundRequestsRepository {
  const RefundRequestsRepositoryImpl(this._remote);

  final RefundRequestsRemoteDataSource _remote;

  @override
  Future<Result<RefundIssuesPageEntity>> getRefundIssues({
    required int page,
    required int pageSize,
    RefundIssueReviewStatus? reviewStatus,
    RefundIssueRequestType? requestType,
  }) {
    return runAsResult(() async {
      final model = await _remote.getRefundIssues(
        RefundIssuesQueryModel(
          page: page,
          pageSize: pageSize,
          reviewStatus: reviewStatus?.toJson(),
          requestType: requestType?.toJson(),
        ),
      );
      return RefundIssuesPageEntity(
        items: model.items.map((item) => item.toEntity).toList(),
        totalCount: model.totalCount,
        page: model.page,
        pageSize: model.pageSize,
      );
    });
  }

  @override
  Future<Result<RefundIssueEntity>> reviewRefundIssue({
    required String refundIssueId,
    required RefundIssueReviewStatus reviewStatus,
    String? adminNotes,
  }) {
    return runAsResult(() async {
      final model = await _remote.reviewRefundIssue(
        refundIssueId: refundIssueId,
        request: ReviewRefundIssueRequestModel(
          reviewStatus: reviewStatus.toJson(),
          adminNotes: adminNotes,
        ),
      );
      return model.toEntity;
    });
  }
}
