import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/refund_requests/domain/entities/refund_issue_entity.dart';
import 'package:dashboardtaxi/features/refund_requests/presentation/ui/widgets/refund_requests_formatters.dart';

class RefundRequestStatusBadge extends StatelessWidget {
  const RefundRequestStatusBadge({super.key, required this.issue});

  final RefundIssueEntity issue;

  @override
  Widget build(BuildContext context) {
    return AppStatusBadge(
      color: _color(context),
      label: RefundRequestsFormatters.statusLabel(issue.reviewStatus),
    );
  }

  Color _color(BuildContext context) {
    if (issue.isOpen) return AppColors.warning;
    if (issue.isResolved) return AppColors.success;
    if (issue.isDismissed) return context.onSurface.withValues(alpha: 0.58);
    return context.primary;
  }
}
