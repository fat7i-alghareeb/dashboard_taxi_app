import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/refunds/domain/entities/refund_entity.dart';

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
          color: refund.canRetry
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
                refund.canRetry
                    ? FontAwesomeIcons.rotateRight
                    : FontAwesomeIcons.circleInfo,
                size: 16.r,
                color: refund.canRetry ? context.primary : AppColors.warning,
              ),
              AppSpacing.sm.horizontalSpace,
              Expanded(
                child: Text(
                  refund.canRetry
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
            refund.canRetry
                ? AppStrings.refundsRetryBackendApproval
                : refund.retryBlockedReason ??
                    AppStrings.refundsRetryBlockedFallback,
            style: AppTextStyles.s12w400.copyWith(
              color: context.onSurface.withValues(alpha: 0.66),
            ),
          ),
          AppSpacing.lg.verticalSpace,
          AppButton.primaryGradient(
            onTap: onRetry,
            isActive: refund.canRetry,
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
