import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/common/widgets/show_overlay.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/entities/compensation_claim_entity.dart';
import '../../states/compensation_cubit.dart';

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
                loading: () => const Center(child: CircularProgressIndicator()),
                success: (claims) {
                  if (claims.isEmpty) {
                    return Center(
                      child: EmptyStateWidget(text: AppStrings.dashboardNoPendingClaims),
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
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.sm,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: FaIcon(context.chevronStart, size: 18.r, color: context.onSurface),
          ),
          Expanded(
            child: Text(
              AppStrings.dashboardCompensationClaims,
              style: AppTextStyles.s18w600.copyWith(color: context.onSurface),
            ),
          ),
          IconButton(
            onPressed: onRefresh,
            icon: FaIcon(
              FontAwesomeIcons.arrowsRotate,
              size: 18.r,
              color: context.onSurface.withValues(alpha: 0.70),
            ),
          ),
        ],
      ),
    );
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
        border: Border.all(color: context.onSurface.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  AppStrings.compensationPercentage,
                  style: AppTextStyles.s12w500.copyWith(
                    color: context.onSurface.withValues(alpha: 0.60),
                  ),
                ),
              ),
              Text(
                claim.amountLabel,
                style: AppTextStyles.s16w600.copyWith(color: AppColors.success),
              ),
            ],
          ),
          AppSpacing.sm.verticalSpace,
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
      ),
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
        final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
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
                AppStrings.compensationEvidenceItem(index),
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
