import 'package:dashboardtaxi/common/imports/imports.dart';

import '../../../../domain/entities/compensation_claim_entity.dart';
import '../../../states/compensation_cubit.dart';
import '../compensation_status_badge.dart';
import 'compensation_evidence_link.dart';

class CompensationClaimCardWidget extends StatelessWidget {
  const CompensationClaimCardWidget({
    super.key,
    required this.claim,
    required this.isReviewing,
  });

  final CompensationClaimEntity claim;
  final bool isReviewing;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: context.surface,
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
                  color: AppColors.success.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppRadii.lg.r),
                ),
                child: FaIcon(
                  FontAwesomeIcons.handHoldingDollar,
                  size: 17.r,
                  color: AppColors.success,
                ),
              ),
              AppSpacing.md.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      claim.amountLabel,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.s18w600.copyWith(
                        color: context.onSurface,
                      ),
                    ),
                    if (claim.createdAt != null) ...[
                      AppSpacing.xs.verticalSpace,
                      Text(
                        claim.createdAt!.toSmartDateTime(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.s12w400.copyWith(
                          color: context.onSurface.withValues(alpha: 0.62),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              AppSpacing.md.horizontalSpace,
              CompensationStatusBadge(claim: claim),
            ],
          ),
          AppSpacing.lg.verticalSpace,
          AppCardInfoRow(
            label: AppStrings.refundsTrip,
            value: claim.tripId,
            labelWidth: 118,
            valueMaxLines: 2,
          ),
          AppSpacing.md.verticalSpace,
          Text(
            claim.note,
            style: AppTextStyles.s14w400.copyWith(color: context.onSurface),
          ),
          if (claim.evidenceUrls.isNotEmpty) ...[
            AppSpacing.md.verticalSpace,
            Text(
              AppStrings.compensationEvidence,
              style: AppTextStyles.s12w500.copyWith(
                color: context.onSurface.withValues(alpha: 0.60),
              ),
            ),
            AppSpacing.xs.verticalSpace,
            for (var i = 0; i < claim.evidenceUrls.length; i++)
              CompensationEvidenceLink(url: claim.evidenceUrls[i], index: i + 1),
          ],
          if (claim.isPending) ...[
            AppSpacing.lg.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: AppButton.outline(
                    variant: AppButtonVariant.error,
                    layout: const AppButtonLayout(height: 44),
                    onTap: isReviewing
                        ? null
                        : () => context.read<CompensationCubit>().review(
                            claimId: claim.id,
                            approved: false,
                          ),
                    child: AppButtonChild.label(
                      AppStrings.dashboardRejectClaim,
                      textStyle: AppTextStyles.s14w500,
                    ),
                  ),
                ),
                AppSpacing.md.horizontalSpace,
                Expanded(
                  child: AppButton.primary(
                    isLoading: isReviewing,
                    layout: const AppButtonLayout(height: 44),
                    onTap: isReviewing
                        ? null
                        : () => context.read<CompensationCubit>().review(
                            claimId: claim.id,
                            approved: true,
                          ),
                    child: AppButtonChild.label(
                      AppStrings.dashboardApproveClaim,
                      textStyle: AppTextStyles.s14w600,
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
    if (claim.isPending) return AppColors.warning.withValues(alpha: 0.24);
    return context.onSurface.withValues(alpha: 0.08);
  }
}
