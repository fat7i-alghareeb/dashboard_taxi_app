import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/refund_requests/domain/entities/refund_issue_entity.dart';
import 'package:dashboardtaxi/features/refund_requests/presentation/ui/widgets/refund_requests_formatters.dart';

class RefundRequestStatusBadge extends StatelessWidget {
  const RefundRequestStatusBadge({super.key, required this.issue});

  final RefundIssueEntity issue;

  @override
  Widget build(BuildContext context) {
    final color = _color(context);
    return Container(
      padding: REdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(color: color.withValues(alpha: 0.28), width: 1.w),
      ),
      child: Text(
        RefundRequestsFormatters.statusLabel(issue.reviewStatus),
        style: AppTextStyles.s12w500.copyWith(color: color),
      ),
    );
  }

  Color _color(BuildContext context) {
    if (issue.isOpen) return AppColors.warning;
    if (issue.isResolved) return AppColors.success;
    if (issue.isDismissed) return context.onSurface.withValues(alpha: 0.58);
    return context.primary;
  }
}
