import 'package:dashboardtaxi/common/imports/imports.dart';

class DrawerMenuItem extends StatelessWidget {
  const DrawerMenuItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.value,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: REdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: context.onSurface.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(
          color: context.onSurface.withValues(alpha: 0.05),
          width: 1.r,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        child: Padding(
          padding: REdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.lg,
          ),
          child: Row(
            children: [
              SizedBox(
                width: 24.sp,
                child: Center(
                  child: FaIcon(icon, size: 18.r, color: context.primary),
                ),
              ),
              AppSpacing.md.horizontalSpace,
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyles.s16w600.copyWith(
                    color: context.onSurface,
                  ),
                ),
              ),
              if (value != null) ...[
                Text(
                  value!,
                  style: AppTextStyles.s14w400.copyWith(
                    color: context.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                AppSpacing.sm.horizontalSpace,
              ],
              FaIcon(
                FontAwesomeIcons.chevronRight,
                size: 12.r,
                color: context.primary,
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn().slideX(begin: 0.05, duration: AppDurations.normal);
  }
}
