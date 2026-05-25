import 'package:dashboardtaxi/common/imports/imports.dart';

class DashboardAdminConfigTileWidget extends StatelessWidget {
  const DashboardAdminConfigTileWidget({
    super.key,
    required this.label,
    required this.value,
    required this.actionLabel,
    required this.isLoading,
    required this.onTap,
    this.isActive = true,
  });

  final String label;
  final String value;
  final String actionLabel;
  final bool isLoading;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220.w,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.onSurface.withValues(alpha: 0.035),
          borderRadius: BorderRadius.circular(AppRadii.sm.r),
        ),
        child: Padding(
          padding: REdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                label,
                style: AppTextStyles.s12w400.copyWith(
                  color: context.onSurface.withValues(alpha: 0.62),
                ),
              ),
              AppSpacing.xs.verticalSpace,
              Text(
                value,
                style: AppTextStyles.s18w600.copyWith(color: context.onSurface),
              ),
              AppSpacing.md.verticalSpace,
              AppButton.outline(
                onTap: onTap,
                isActive: isActive,
                isLoading: isLoading,
                child: AppButtonChild.label(actionLabel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
