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
          child: Material(
            color: context.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadii.xl.r),
              side: BorderSide(
                color: context.onSurface.withValues(alpha: 0.10),
              ),
            ),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(AppRadii.xl.r),
              child: Padding(
                padding: REdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.sm,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FaIcon(
                      isDriverMode
                          ? FontAwesomeIcons.chartLine
                          : FontAwesomeIcons.carSide,
                      size: 12.r,
                      color: context.primary,
                    ),
                    AppSpacing.sm.horizontalSpace,
                    Text(
                      isDriverMode
                          ? AppStrings.rootAdminMode
                          : AppStrings.rootDriverMode,
                      style: AppTextStyles.s12w500.copyWith(
                        color: context.onSurface,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 280.ms).slideY(begin: -0.15, end: 0);
  }
}
