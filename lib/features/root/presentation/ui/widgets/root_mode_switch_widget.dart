import 'package:dashboardtaxi/common/imports/imports.dart';

class RootModeSwitchWidget extends StatelessWidget {
  const RootModeSwitchWidget({
    super.key,
    required this.isDriverMode,
    required this.onTap,
  });

  final bool isDriverMode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: REdgeInsets.only(top: AppSpacing.md),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: context.surface.withValues(alpha: 0.90),
              borderRadius: BorderRadius.circular(AppRadii.xl.r),
              border: Border.all(
                color: context.onSurface.withValues(alpha: 0.08),
              ),
              boxShadow: context.shadows.grey,
            ),
            child: Padding(
              padding: REdgeInsets.all(AppSpacing.xs),
              child: AppButton.primary(
                onTap: onTap,
                noShadow: true,
                layout: AppButtonLayout(
                  height: 40,
                  contentPadding: REdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.sm,
                  ),
                ),
                child: AppButtonChild.labelIcon(
                  label: isDriverMode
                      ? AppStrings.rootAdminMode
                      : AppStrings.rootDriverMode,
                  icon: IconSource.icon(
                    isDriverMode
                        ? FontAwesomeIcons.chartLine
                        : FontAwesomeIcons.carSide,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: AppDurations.normal).slideY(begin: -0.20);
  }
}
