import 'package:dashboardtaxi/common/imports/imports.dart';

class DashboardSectionShellWidget extends StatelessWidget {
  const DashboardSectionShellWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
  });

  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(AppRadii.sm.r),
        border: Border.all(color: context.onSurface.withValues(alpha: 0.08)),
        boxShadow: context.shadows.grey,
      ),
      child: Padding(
        padding: REdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                FaIcon(icon, size: 16.r, color: context.primary),
                AppSpacing.sm.horizontalSpace,
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyles.s16w600.copyWith(
                      color: context.onSurface,
                    ),
                  ),
                ),
              ],
            ),
            AppSpacing.lg.verticalSpace,
            child,
          ],
        ),
      ),
    ).animate().fadeIn(duration: AppDurations.normal).slideY(begin: 0.08);
  }
}
