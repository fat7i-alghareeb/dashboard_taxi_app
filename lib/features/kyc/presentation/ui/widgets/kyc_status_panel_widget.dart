import 'package:dashboardtaxi/common/imports/imports.dart';

/// Shared flat panel used by KYC review-lock and suspended states.
///
/// Renders a centered panel with a colored status dot + title row, a quiet
/// subtitle, and a single primary refresh action.
class KycStatusPanelWidget extends StatelessWidget {
  const KycStatusPanelWidget({
    super.key,
    required this.tone,
    required this.title,
    required this.subtitle,
    required this.actionLabel,
    required this.isLoading,
    required this.onTap,
  });

  final Color tone;
  final String title;
  final String subtitle;
  final String actionLabel;
  final bool isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: REdgeInsets.all(AppSpacing.xl),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.surface,
            borderRadius: BorderRadius.circular(AppRadii.lg.r),
            border: Border.all(
              color: context.onSurface.withValues(alpha: 0.08),
            ),
          ),
          child: Padding(
            padding: REdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 8.r,
                      height: 8.r,
                      decoration: BoxDecoration(
                        color: tone,
                        shape: BoxShape.circle,
                      ),
                    ),
                    AppSpacing.sm.horizontalSpace,
                    Text(
                      title.toUpperCase(),
                      style: AppTextStyles.s11w500.copyWith(
                        color: tone,
                        letterSpacing: 1.4,
                      ),
                    ),
                  ],
                ),
                AppSpacing.md.verticalSpace,
                Text(
                  title,
                  style: AppTextStyles.s20w700.copyWith(
                    color: context.onSurface,
                  ),
                ),
                AppSpacing.sm.verticalSpace,
                Text(
                  subtitle,
                  style: AppTextStyles.s14w400.copyWith(
                    color: context.onSurface.withValues(alpha: 0.60),
                  ),
                ),
                AppSpacing.xl.verticalSpace,
                AppButton.outline(
                  layout: const AppButtonLayout(height: 48),
                  isLoading: isLoading,
                  isActive: !isLoading,
                  onTap: onTap,
                  child: AppButtonChild.label(actionLabel),
                ),
              ],
            ),
          ),
        )
            .animate()
            .fadeIn(duration: 320.ms)
            .slideY(begin: 0.05, end: 0),
      ),
    );
  }
}
