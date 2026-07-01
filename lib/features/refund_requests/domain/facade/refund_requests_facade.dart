import 'package:injectable/injectable.dart';
import 'package:dashboardtaxi/core/utils/result.dart';
import 'package:dashboardtaxi/features/refund_requests/domain/entities/refund_issue_entity.dart';
import 'package:dashboardtaxi/features/refund_requests/domain/entities/refund_issue_enums.dart';
import 'package:dashboardtaxi/features/refund_requests/domain/entities/refund_issues_page_entity.dart';
import 'package:dashboardtaxi/features/refund_requests/domain/repositories/refund_requests_repository.dart';

@lazySingleton
class RefundRequestsFacade {
  const RefundRequestsFacade(this._repository);

  final RefundRequestsRepository _repository;

  Future<Result<RefundIssuesPageEntity>> getRefundIssues({
    required int page,
    required int pageSize,
    RefundIssueReviewStatus? reviewStatus,
    RefundIssueRequestType? requestType,
  }) {
    return _repository.getRefundIssues(
      page: page,
      pageSize: pageSize,
      reviewStatus: reviewStatus,
      requestType: requestType,
    );
  }

  Future<Result<RefundIssueEntity>> reviewRefundIssue({
    required String refundIssueId,
    required RefundIssueReviewStatus reviewStatus,
    String? adminNotes,
  }) {
    return _repository.reviewRefundIssue(
      refundIssueId: refundIssueId,
      reviewStatus: reviewStatus,
      adminNotes: adminNotes,
    );
  }
}
