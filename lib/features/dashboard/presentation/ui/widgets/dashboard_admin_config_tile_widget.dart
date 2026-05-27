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
    return Container(
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(color: context.onSurface.withValues(alpha: 0.08)),
      ),
      padding: REdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            label.toUpperCase(),
            style: AppTextStyles.s11w500.copyWith(
              color: context.onSurface.withValues(alpha: 0.50),
              letterSpacing: 1.1,
            ),
          ),
          AppSpacing.sm.verticalSpace,
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.s20w700.copyWith(color: context.onSurface),
          ),
          AppSpacing.md.verticalSpace,
          AppButton.outline(
            onTap: onTap,
            isActive: isActive,
            isLoading: isLoading,
            layout: AppButtonLayout(
              height: 36,
              contentPadding: REdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
            ),
            child: AppButtonChild.label(actionLabel, maxLines: 1),
          ),
        ],
      ),
    );
  }
}
