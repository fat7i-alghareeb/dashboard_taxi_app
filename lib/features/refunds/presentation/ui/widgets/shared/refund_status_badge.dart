import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/refunds/domain/entities/refund_entity.dart';
import 'package:dashboardtaxi/features/refunds/presentation/ui/widgets/shared/refund_ui_formatters.dart';

class RefundStatusBadge extends StatelessWidget {
  const RefundStatusBadge({super.key, required this.refund});

  final RefundEntity refund;

  @override
  Widget build(BuildContext context) {
    final color = _statusColor(context);
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
        RefundUiFormatters.statusLabel(refund),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles.s12w500.copyWith(color: color),
      ),
    );
  }

  Color _statusColor(BuildContext context) {
    if (refund.isSucceeded) return AppColors.success;
    if (refund.isFailedLike) return context.error;
    if (refund.isRequiresAction) return AppColors.warning;
    if (refund.isPendingLike) return context.primary;
    return context.onSurface.withValues(alpha: 0.72);
  }
}
