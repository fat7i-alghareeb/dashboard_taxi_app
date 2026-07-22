import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/refund_requests/domain/entities/refund_issue_entity.dart';
import 'package:dashboardtaxi/features/refund_requests/domain/entities/refund_issue_enums.dart';
import 'package:dashboardtaxi/features/refund_requests/presentation/ui/widgets/refund_request_status_badge.dart';
import 'package:dashboardtaxi/features/refund_requests/presentation/ui/widgets/refund_requests_formatters.dart';

class RefundRequestCardWidget extends StatelessWidget {
  const RefundRequestCardWidget({
    super.key,
    required this.issue,
    required this.isReviewing,
    required this.onReview,
  });

  final RefundIssueEntity issue;
  final bool isReviewing;
  final ValueChanged<RefundIssueReviewStatus> onReview;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: context.surfaceContainer,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(color: _borderColor(context), width: 1.w),
        boxShadow: context.shadows.primary,
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
                  color: context.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppRadii.lg.r),
                ),
                child: FaIcon(
                  FontAwesomeIcons.inbox,
                  size: 17.r,
                  color: context.primary,
                ),
              ),
              AppSpacing.md.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      issue.customerReason.isEmpty
                          ? issue.requestType.title()
                          : issue.customerReason,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.s16w600.copyWith(
                        color: context.onSurface,
                      ),
                    ),
                    AppSpacing.xs.verticalSpace,
                    Text(
                      RefundRequestsFormatters.date(issue.createdAtUtc),
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
              RefundRequestStatusBadge(issue: issue),
            ],
          ),
          AppSpacing.lg.verticalSpace,
          AppCardInfoRow(
            label: AppStrings.refundsTrip,
            value: issue.tripReferenceCode?.isNotEmpty == true
                ? issue.tripReferenceCode!
                : AppStrings.refundsNotAvailable,
            labelWidth: 118,
            valueMaxLines: 2,
          ),
          AppSpacing.sm.verticalSpace,
          AppCardInfoRow(
            label: AppStrings.refundsPassenger,
            value: issue.passengerName?.isNotEmpty == true
                ? issue.passengerName!
                : AppStrings.refundsNotAvailable,
            labelWidth: 118,
            valueMaxLines: 2,
          ),
          AppSpacing.sm.verticalSpace,
          AppCardInfoRow(
            label: AppStrings.refundRequestsSnapshotAmount,
            value: RefundRequestsFormatters.amount(
              issue.refundAmountSnapshot,
              issue.refundCurrencySnapshot,
            ),
            labelWidth: 118,
            valueMaxLines: 2,
          ),
          AppSpacing.sm.verticalSpace,
          AppCardInfoRow(
            label: AppStrings.refundRequestsSnapshotStatus,
            value: issue.refundStatusSnapshot ?? AppStrings.refundsNotAvailable,
            labelWidth: 118,
            valueMaxLines: 2,
          ),
          if (issue.note?.isNotEmpty == true) ...[
            AppSpacing.lg.verticalSpace,
            Text(
              issue.note!,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.s12w400.copyWith(
                color: context.onSurface.withValues(alpha: 0.76),
              ),
            ),
          ],
          if (!issue.isResolved && !issue.isDismissed) ...[
            AppSpacing.lg.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: AppButton.grey(
                    onTap: () => onReview(RefundIssueReviewStatus.dismissed),
                    isLoading: isReviewing,
                    child: AppButtonChild.labelIcon(
                      label: AppStrings.refundRequestsDismiss,
                      icon: IconSource.builder(
                        (_) => FaIcon(FontAwesomeIcons.xmark, size: 14.r),
                      ),
                    ),
                  ),
                ),
                AppSpacing.sm.horizontalSpace,
                Expanded(
                  child: AppButton.primaryGradient(
                    onTap: () => onReview(RefundIssueReviewStatus.resolved),
                    isLoading: isReviewing,
                    child: AppButtonChild.labelIcon(
                      label: AppStrings.refundRequestsResolve,
                      icon: IconSource.builder(
                        (_) => FaIcon(FontAwesomeIcons.check, size: 14.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Color _borderColor(BuildContext context) {
    if (issue.isOpen) return AppColors.warning.withValues(alpha: 0.24);
    return context.onSurface.withValues(alpha: 0.08);
  }
}
