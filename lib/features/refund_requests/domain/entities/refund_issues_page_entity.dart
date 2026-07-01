import 'package:dashboardtaxi/features/refund_requests/domain/entities/refund_issue_entity.dart';

class RefundIssuesPageEntity {
  const RefundIssuesPageEntity({
    required this.items,
    required this.totalCount,
    required this.page,
    required this.pageSize,
  });

  final List<RefundIssueEntity> items;
  final int totalCount;
  final int page;
  final int pageSize;

  bool get hasMore => page * pageSize < totalCount;
}
