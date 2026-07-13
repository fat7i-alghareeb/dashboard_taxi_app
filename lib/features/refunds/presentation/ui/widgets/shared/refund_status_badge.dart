import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/refunds/domain/entities/refund_entity.dart';
import 'package:dashboardtaxi/features/refunds/presentation/ui/widgets/shared/refund_ui_formatters.dart';

class RefundStatusBadge extends StatelessWidget {
  const RefundStatusBadge({super.key, required this.refund});

  final RefundEntity refund;

  @override
  Widget build(BuildContext context) {
    return AppStatusBadge(
      color: _statusColor(context),
      label: RefundUiFormatters.statusLabel(refund),
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
