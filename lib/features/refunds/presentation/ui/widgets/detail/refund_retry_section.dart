import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/refunds/domain/entities/refund_entity.dart';
import 'package:dashboardtaxi/features/refunds/domain/entities/refund_enums.dart';
import 'package:dashboardtaxi/features/refunds/presentation/ui/widgets/shared/refund_ui_formatters.dart';

class RefundRetrySection extends StatelessWidget {
  const RefundRetrySection({
    super.key,
    required this.refund,
    required this.isLoading,
    required this.onRetry,
  });

  final RefundEntity refund;
  final bool isLoading;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: context.surfaceContainer,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(
          color: refund.canRetrySafely
              ? context.primary.withValues(alpha: 0.22)
              : context.onSurface.withValues(alpha: 0.08),
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              FaIcon(
                refund.canRetrySafely
                    ? FontAwesomeIcons.rotateRight
                    : FontAwesomeIcons.circleInfo,
                size: 16.r,
                color: refund.canRetrySafely
                    ? context.primary
                    : AppColors.warning,
              ),
              AppSpacing.sm.horizontalSpace,
              Expanded(
                child: Text(
                  refund.canRetrySafely
                      ? AppStrings.refundsRetryAvailable
                      : AppStrings.refundsRetryUnavailable,
                  style: AppTextStyles.s14w600.copyWith(
                    color: context.onSurface,
                  ),
                ),
              ),
            ],
          ),
          AppSpacing.sm.verticalSpace,
          Text(
            refund.canRetrySafely
                ? AppStrings.refundsRetryBackendApproval
                : refund.retryBlockedReason == RefundFailureCode.unknown
                ? AppStrings.refundsRetryBlockedFallback
                : RefundUiFormatters.failureLabel(refund.retryBlockedReason),
            style: AppTextStyles.s12w400.copyWith(
              color: context.onSurface.withValues(alpha: 0.66),
            ),
          ),
          AppSpacing.lg.verticalSpace,
          AppButton.primaryGradient(
            onTap: onRetry,
            isActive: refund.canRetrySafely,
            isLoading: isLoading,
            child: AppButtonChild.labelIcon(
              label: AppStrings.refundsRetry,
              icon: IconSource.builder(
                (_) => FaIcon(FontAwesomeIcons.rotateRight, size: 15.r),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 240.ms).slideY(begin: 0.04, end: 0);
  }
}
