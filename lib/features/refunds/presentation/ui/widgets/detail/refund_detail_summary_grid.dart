import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/refunds/domain/entities/refund_entity.dart';
import 'package:dashboardtaxi/features/refunds/presentation/ui/widgets/detail/refund_summary_tile.dart';
import 'package:dashboardtaxi/features/refunds/presentation/ui/widgets/shared/refund_status_badge.dart';
import 'package:dashboardtaxi/features/refunds/presentation/ui/widgets/shared/refund_ui_formatters.dart';

class RefundDetailSummaryGrid extends StatelessWidget {
  const RefundDetailSummaryGrid({super.key, required this.refund});

  final RefundEntity refund;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: context.surfaceContainer,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(
          color: context.onSurface.withValues(alpha: 0.08),
          width: 1.w,
        ),
        boxShadow: context.shadows.primary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  RefundUiFormatters.amount(refund.amount, refund.currency),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.s24w700.copyWith(
                    color: context.onSurface,
                  ),
                ),
              ),
              AppSpacing.md.horizontalSpace,
              RefundStatusBadge(refund: refund),
            ],
          ),
          AppSpacing.xs.verticalSpace,
          Text(
            refund.isFullRefund
                ? AppStrings.refundsFullRefund
                : AppStrings.refundsPartialRefund,
            style: AppTextStyles.s12w500.copyWith(
              color: context.primary,
            ),
          ),
          AppSpacing.lg.verticalSpace,
          Wrap(
            spacing: AppSpacing.md.w,
            runSpacing: AppSpacing.md.h,
            children: [
              RefundSummaryTile(
                label: AppStrings.refundsSource,
                value: RefundUiFormatters.sourceLabel(refund.sourceType),
              ),
              RefundSummaryTile(
                label: AppStrings.refundsRefundPercent,
                value: refund.refundPercent == null
                    ? AppStrings.refundsNotAvailable
                    : '${refund.refundPercent!.toStringAsFixed(0)}%',
              ),
              RefundSummaryTile(
                label: AppStrings.refundsRemainingBalance,
                value: RefundUiFormatters.optionalAmount(
                  refund.remainingRefundableBalance,
                  refund.currency,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 240.ms).slideY(begin: 0.04, end: 0);
  }
}
