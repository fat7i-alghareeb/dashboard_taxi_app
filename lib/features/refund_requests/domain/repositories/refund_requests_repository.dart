import 'package:dashboardtaxi/core/utils/result.dart';
import 'package:dashboardtaxi/features/refund_requests/domain/entities/refund_issue_entity.dart';
import 'package:dashboardtaxi/features/refund_requests/domain/entities/refund_issue_enums.dart';
import 'package:dashboardtaxi/features/refund_requests/domain/entities/refund_issues_page_entity.dart';

abstract class RefundRequestsRepository {
  Future<Result<RefundIssuesPageEntity>> getRefundIssues({
    required int page,
    required int pageSize,
    RefundIssueReviewStatus? reviewStatus,
    RefundIssueRequestType? requestType,
  });

  Future<Result<RefundIssueEntity>> reviewRefundIssue({
    required String refundIssueId,
    required RefundIssueReviewStatus reviewStatus,
    String? adminNotes,
  });
}
