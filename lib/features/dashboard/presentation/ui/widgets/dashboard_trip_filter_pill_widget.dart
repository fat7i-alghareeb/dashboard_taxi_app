import 'package:dashboardtaxi/common/imports/imports.dart';

class DashboardTripFilterPillWidget extends StatelessWidget {
  const DashboardTripFilterPillWidget({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bg = isSelected
        ? context.primary
        : context.onSurface.withValues(alpha: 0.04);
    final fg = isSelected
        ? context.onSurface
        : context.onSurface.withValues(alpha: 0.72);
    final borderColor = isSelected
        ? context.primary
        : context.onSurface.withValues(alpha: 0.10);

    return Material(
      color: bg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.xl.r),
        side: BorderSide(color: borderColor),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.xl.r),
        child: AnimatedContainer(
          duration: AppDurations.fast,
          padding: REdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
          child: Text(
            label,
            style: AppTextStyles.s12w500.copyWith(color: fg),
          ),
        ),
      ),
    );
  }
}
