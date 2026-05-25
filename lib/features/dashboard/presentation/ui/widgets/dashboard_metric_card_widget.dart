import 'package:dashboardtaxi/common/imports/imports.dart';

class DashboardMetricCardWidget extends StatelessWidget {
  const DashboardMetricCardWidget({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 156.w,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.surface,
          borderRadius: BorderRadius.circular(AppRadii.sm.r),
          border: Border.all(color: context.onSurface.withValues(alpha: 0.08)),
          boxShadow: context.shadows.grey,
        ),
        child: Padding(
          padding: REdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FaIcon(icon, size: 18.r, color: context.primary),
              AppSpacing.md.verticalSpace,
              Text(
                value,
                style: AppTextStyles.s24w700.copyWith(color: context.onSurface),
              ),
              AppSpacing.xs.verticalSpace,
              Text(
                label,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.s12w400.copyWith(
                  color: context.onSurface.withValues(alpha: 0.62),
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: AppDurations.normal).slideY(begin: 0.08);
  }
}
