import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/kyc/presentation/states/kyc_bloc.dart';

class KycSuspendedSection extends StatelessWidget {
  const KycSuspendedSection({super.key});

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
              color: context.error.withValues(alpha: 0.2),
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Shaking crimson warning icon
              FaIcon(
                FontAwesomeIcons.triangleExclamation,
                size: 80.r,
                color: context.error,
              )
                  .animate(onPlay: (controller) => controller.repeat())
                  .shake(duration: 1.5.seconds, hz: 4)
                  .then()
                  .shimmer(duration: 2.seconds),
              AppSpacing.xl.verticalSpace,
              // Title
              Text(
                AppStrings.kycSuspendedTitle,
                style: AppTextStyles.s24w700.copyWith(color: context.error),
                textAlign: TextAlign.center,
              ).animate().fadeIn(duration: 350.ms).slideY(begin: 0.1, end: 0),
              AppSpacing.md.verticalSpace,
              // Description
              Text(
                AppStrings.kycSuspendedSubtitle,
                style: AppTextStyles.s14w400.copyWith(
                  color: context.onSurface.withValues(alpha: 0.6),
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(duration: 450.ms).slideY(begin: 0.1, end: 0),
              AppSpacing.xxl.verticalSpace,
              // Support / Re-verify button
              BlocBuilder<KycBloc, KycState>(
                builder: (context, state) {
                  return AppButton.primaryGradient(
                    child: AppButtonChild.label(AppStrings.retry), // "Recheck Account"
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
