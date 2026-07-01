import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/common/widgets/show_overlay.dart';
import 'package:dashboardtaxi/features/refunds/presentation/ui/widgets/list/refunds_shimmer_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/entities/compensation_claim_entity.dart';
import '../../states/compensation_cubit.dart';
import '../widgets/compensation_status_badge.dart';

class CompensationClaimsScreen extends StatelessWidget {
  const CompensationClaimsScreen({super.key});

  static const String pagePath = '/compensation_claims';
  static const String pageName = 'CompensationClaimsScreen';

  @override
  Widget build(BuildContext context) {
    return AppScaffold.body(
      child: BlocProvider(
        create: (_) => getIt<CompensationCubit>()..loadPending(),
        child: const _CompensationClaimsBody(),
      ),
    );
  }
}

class _CompensationClaimsBody extends StatelessWidget {
  const _CompensationClaimsBody();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompensationCubit, CompensationState>(
      listenWhen: (prev, curr) => prev.reviewState != curr.reviewState,
      listener: (context, state) {
        state.reviewState.maybeWhen(
          orElse: () {},
          loading: () => showLoadingOverlay(context, AppStrings.uploading),
          success: (_) {
            clearAllOverlays();
            showSuccessOverlay(context, AppStrings.done);
          },
          failure: (msg) {
            clearAllOverlays();
            showErrorOverlay(context, msg);
          },
        );
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Header(
              onBack: () => Navigator.maybePop(context),
              onRefresh: () => context.read<CompensationCubit>().loadPending(),
            ),
            Expanded(
              child: StatusBuilder<List<CompensationClaimEntity>>(
                state: state.claimsState,
                loading: () => SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: REdgeInsets.all(AppSpacing.lg),
                  child: const RefundsShimmerWidget(),
                ),
                success: (claims) {
                  if (claims.isEmpty) {
                    return Center(
                      child: EmptyStateWidget(
                        text: AppStrings.dashboardNoPendingClaims,
                      ),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: () =>
                        context.read<CompensationCubit>().loadPending(),
                    child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: REdgeInsets.all(AppSpacing.lg),
                      itemCount: claims.length,
                      separatorBuilder: (_, _) => AppSpacing.md.verticalSpace,
                      itemBuilder: (context, index) => _ClaimCard(
                        claim: claims[index],
                        isReviewing: state.reviewState.isLoading,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.onBack, required this.onRefresh});

  final VoidCallback onBack;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.sm,
      ),
      child: Row(
        children: [
          AppButton.grey(
            onTap: onBack,
            layout: AppButtonLayout(
              width: 44.w,
              height: 44.h,
              shape: AppButtonShape.circle,
              contentPadding: REdgeInsets.all(AppSpacing.sm),
            ),
            child: AppButtonChild.icon(
              IconSource.builder(
                (_) => FaIcon(FontAwesomeIcons.arrowLeft, size: 16.r),
              ),
            ),
          ),
          AppSpacing.md.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.dashboardCompensationClaims,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.s24w700.copyWith(
                    color: context.onSurface,
                  ),
                ),
                AppSpacing.xs.verticalSpace,
                Text(
                  AppStrings.compensationSubtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.s12w400.copyWith(
                    color: context.onSurface.withValues(alpha: 0.64),
                  ),
                ),
              ],
            ),
          ),
          AppSpacing.md.horizontalSpace,
          AppButton.primary(
            onTap: onRefresh,
            layout: AppButtonLayout(
              width: 44.w,
              height: 44.h,
              shape: AppButtonShape.circle,
              contentPadding: REdgeInsets.all(AppSpacing.sm),
            ),
            child: AppButtonChild.icon(
              IconSource.builder(
                (_) => FaIcon(FontAwesomeIcons.arrowsRotate, size: 16.r),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 220.ms).slideY(begin: 0.06, end: 0);
  }
}

class _ClaimCard extends StatelessWidget {
  const _ClaimCard({required this.claim, required this.isReviewing});

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
          _InfoRow(label: AppStrings.refundsTrip, value: claim.tripId),
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
              _EvidenceLink(url: claim.evidenceUrls[i], index: i + 1),
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

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 118.w,
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.s12w400.copyWith(
              color: context.onSurface.withValues(alpha: 0.58),
            ),
          ),
        ),
        AppSpacing.sm.horizontalSpace,
        Expanded(
          child: Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
            style: AppTextStyles.s12w500.copyWith(color: context.onSurface),
          ),
        ),
      ],
    );
  }
}

class _EvidenceLink extends StatelessWidget {
  const _EvidenceLink({required this.url, required this.index});

  final String url;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final uri = Uri.tryParse(url);
        if (uri == null) return;
        final opened = await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
        if (!opened && context.mounted) {
          showErrorOverlay(context, AppStrings.somethingWentWrong);
        }
      },
      child: Padding(
        padding: REdgeInsets.symmetric(vertical: AppSpacing.xs),
        child: Row(
          children: [
            FaIcon(
              FontAwesomeIcons.paperclip,
              size: 12.r,
              color: context.primary,
            ),
            AppSpacing.sm.horizontalSpace,
            Expanded(
              child: Text(
                AppStrings.compensationEvidenceItem.trParams({
                  'index': index,
                }),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.s12w500.copyWith(color: context.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
