import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/refunds/domain/entities/refund_entity.dart';
import 'package:dashboardtaxi/features/refunds/domain/entities/refund_enums.dart';
import 'package:dashboardtaxi/features/refunds/presentation/ui/screens/refund_detail_screen.dart';
import 'package:dashboardtaxi/features/refunds/presentation/ui/widgets/shared/refund_status_badge.dart';
import 'package:dashboardtaxi/features/refunds/presentation/ui/widgets/shared/refund_ui_formatters.dart';

class RefundCardWidget extends StatelessWidget {
  const RefundCardWidget({super.key, required this.refund});

  final RefundEntity refund;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.surfaceContainer,
      borderRadius: BorderRadius.circular(AppRadii.lg.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        onTap: () => context.pushNamed(
          RefundDetailScreen.pageName,
          extra: RefundDetailScreenArgs(
            refundId: refund.refundId,
            tripCancellationId: refund.tripCancellationId,
          ),
        ),
        child: Container(
          padding: REdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadii.lg.r),
            border: Border.all(color: _borderColor(context), width: 1.w),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40.w,
                    height: 40.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: _accentColor(context).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(AppRadii.lg.r),
                    ),
                    child: FaIcon(
                      _accentIcon(),
                      size: 17.r,
                      color: _accentColor(context),
                    ),
                  ),
                  AppSpacing.md.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          RefundUiFormatters.amount(
                            refund.amount,
                            refund.currency,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.s18w600.copyWith(
                            color: context.onSurface,
                          ),
                        ),
                        AppSpacing.xs.verticalSpace,
                        Text(
                          RefundUiFormatters.sourceLabel(refund.sourceType),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.s12w400.copyWith(
                            color: context.onSurface.withValues(alpha: 0.62),
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppSpacing.md.horizontalSpace,
                  RefundStatusBadge(refund: refund),
                ],
              ),
              AppSpacing.lg.verticalSpace,
              AppCardInfoRow(
                label: AppStrings.refundsPaymentMethod,
                value: refund.paymentMethod ?? AppStrings.refundsNotAvailable,
              ),
              AppSpacing.sm.verticalSpace,
              AppCardInfoRow(
                label: AppStrings.refundsRequested,
                value: RefundUiFormatters.date(refund.requestedAtUtc),
              ),
              if (refund.failureCode != RefundFailureCode.unknown ||
                  refund.failureReason?.isNotEmpty == true) ...[
                AppSpacing.lg.verticalSpace,
                Text(
                  RefundUiFormatters.failureLabel(
                    refund.failureCode,
                    fallback: refund.failureReason,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.s12w400.copyWith(color: context.error),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Color _accentColor(BuildContext context) {
    if (refund.isSucceeded) return AppColors.success;
    if (refund.isFailedLike || refund.isRequiresAction) return context.error;
    return context.primary;
  }

  FaIconData _accentIcon() {
    return switch (refund.sourceType) {
      RefundSourceType.compensationClaim => FontAwesomeIcons.handHoldingDollar,
      RefundSourceType.manualIncidentRefund =>
        FontAwesomeIcons.triangleExclamation,
      RefundSourceType.adminRetry => FontAwesomeIcons.arrowsRotate,
      RefundSourceType.passengerCancellation ||
      RefundSourceType.adminCancellation ||
      RefundSourceType.driverCancellation ||
      RefundSourceType.airportWaitCancellation => FontAwesomeIcons.rotateLeft,
      RefundSourceType.unknown => FontAwesomeIcons.moneyBillTransfer,
    };
  }

  Color _borderColor(BuildContext context) {
    if (refund.isFailedLike || refund.isRequiresAction) {
      return context.error.withValues(alpha: 0.24);
    }
    return context.onSurface.withValues(alpha: 0.08);
  }
}
