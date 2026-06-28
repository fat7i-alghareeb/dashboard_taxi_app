import 'package:dashboardtaxi/common/imports/imports.dart';

enum DashboardStatusTone { neutral, primary, success, warning, error, info }

class DashboardStatusChipWidget extends StatelessWidget {
  const DashboardStatusChipWidget({
    super.key,
    required this.label,
    this.tone = DashboardStatusTone.neutral,
    this.icon,
    this.dense = false,
  });

  final String label;
  final DashboardStatusTone tone;
  final FaIconData? icon;
  final bool dense;

  Color _resolveColor(BuildContext context) {
    switch (tone) {
      case DashboardStatusTone.neutral:
        return context.onSurface.withValues(alpha: 0.72);
      case DashboardStatusTone.primary:
        return context.primary;
      case DashboardStatusTone.success:
        return AppColors.success;
      case DashboardStatusTone.warning:
        return AppColors.warning;
      case DashboardStatusTone.error:
        return AppColors.error;
      case DashboardStatusTone.info:
        return AppColors.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _resolveColor(context);
    final hPad = dense ? AppSpacing.sm : AppSpacing.md;
    final vPad = dense ? AppSpacing.xs / 2 : AppSpacing.xs;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(AppRadii.sm.r),
      ),
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              FaIcon(icon, size: (dense ? 10 : 11).r, color: color),
              AppSpacing.xs.horizontalSpace,
            ],
            Text(label, style: AppTextStyles.s12w500.copyWith(color: color)),
          ],
        ),
      ),
    );
  }
}

/// Maps a raw backend [TripStatus] enum string (e.g. `Accepted`, `EnRoute`,
/// `InProgress`) to a localized label. Falls back to the raw value for unknown
/// statuses so the chip is never blank.
String dashboardTripStatusLabel(String status) {
  switch (status.toLowerCase()) {
    case 'pendingquote':
      return AppStrings.tripStatusPendingQuote;
    case 'awaitingadminacceptance':
      return AppStrings.tripStatusPendingDriver;
    case 'accepted':
      return AppStrings.tripStatusDriverAssigned;
    case 'enroute':
      return AppStrings.tripStatusDriverEnRoute;
    case 'arrived':
      return AppStrings.tripStatusDriverArrived;
    case 'inprogress':
      return AppStrings.tripStatusInProgress;
    case 'completed':
      return AppStrings.tripStatusCompleted;
    case 'cancelled':
    case 'canceled':
      return AppStrings.tripStatusCancelled;
    case 'awaitingpayment':
      return AppStrings.tripStatusAwaitingPayment;
    case 'paymentfailed':
    case 'failed':
      return AppStrings.tripStatusPaymentFailed;
    case 'refunded':
      return AppStrings.tripStatusRefunded;
    default:
      return status;
  }
}

DashboardStatusTone dashboardToneFromTripStatus(String status) {
  switch (status.toLowerCase()) {
    case 'completed':
    case 'arrived':
      return DashboardStatusTone.success;
    case 'awaitingadminacceptance':
      return DashboardStatusTone.warning;
    case 'cancelled':
    case 'canceled':
    case 'failed':
    case 'paymentfailed':
      return DashboardStatusTone.error;
    case 'enroute':
    case 'accepted':
    case 'inprogress':
      return DashboardStatusTone.primary;
    default:
      return DashboardStatusTone.neutral;
  }
}

DashboardStatusTone dashboardToneFromDriverStatus(String status) {
  switch (status.toLowerCase()) {
    case 'online':
      return DashboardStatusTone.success;
    case 'busy':
      return DashboardStatusTone.warning;
    case 'offline':
      return DashboardStatusTone.neutral;
    default:
      return DashboardStatusTone.neutral;
  }
}

DashboardStatusTone dashboardToneFromApprovalStatus(String status) {
  switch (status.toLowerCase()) {
    case 'approved':
      return DashboardStatusTone.success;
    case 'pending':
      return DashboardStatusTone.warning;
    case 'rejected':
      return DashboardStatusTone.error;
    default:
      return DashboardStatusTone.neutral;
  }
}
