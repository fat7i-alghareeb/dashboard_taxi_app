import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/kyc/presentation/states/kyc_bloc.dart';

class KycReviewLockSection extends StatelessWidget {
  const KycReviewLockSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: REdgeInsets.all(AppSpacing.xl),
        child: Container(
          padding: REdgeInsets.all(AppSpacing.xl),
          decoration: BoxDecoration(
            color: context.surface.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(AppRadii.lg.r),
            boxShadow: context.shadows.primary,
            border: Border.all(
              color: context.primary.withValues(alpha: 0.1),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Rotating premium gear icons
              Stack(
                alignment: Alignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.gears,
                    size: 80.r,
                    color: context.primary.withValues(alpha: 0.2),
                  ),
                  FaIcon(
                    FontAwesomeIcons.gear,
                    size: 40.r,
                    color: context.primary,
                  )
                      .animate(onPlay: (controller) => controller.repeat())
                      .rotate(duration: 4.seconds, curve: Curves.linear),
                ],
              ),
              AppSpacing.xl.verticalSpace,
              // Title
              Text(
                AppStrings.kycUnderReviewTitle,
                style: AppTextStyles.s24w700.copyWith(color: context.onSurface),
                textAlign: TextAlign.center,
              ).animate().fadeIn(duration: 350.ms).slideY(begin: 0.1, end: 0),
              AppSpacing.md.verticalSpace,
              // Description
              Text(
                AppStrings.kycUnderReviewSubtitle,
                style: AppTextStyles.s14w400.copyWith(
                  color: context.onSurface.withValues(alpha: 0.6),
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(duration: 450.ms).slideY(begin: 0.1, end: 0),
              AppSpacing.xxl.verticalSpace,
              // Refresh CTA Button
              BlocBuilder<KycBloc, KycState>(
                builder: (context, state) {
                  return AppButton.primaryGradient(
                    child: AppButtonChild.label(AppStrings.retry), // "Check Status"
                    isLoading: state.refreshState.isLoading,
                    isActive: !state.refreshState.isLoading,
                    onTap: () {
                      context.read<KycBloc>().add(
                            const KycEvent.refreshStatusRequested(),
                          );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
