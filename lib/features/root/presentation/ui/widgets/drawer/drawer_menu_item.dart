import 'package:dashboardtaxi/common/imports/imports.dart';

class DrawerMenuItem extends StatelessWidget {
  const DrawerMenuItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.value,
  });

  final FaIconData icon;
  final String label;
  final VoidCallback onTap;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: REdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),
          child: Row(
            children: [
              Container(
                height: 32.r,
                width: 32.r,
                decoration: BoxDecoration(
                  color: context.onSurface.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(AppRadii.sm.r),
                ),
                child: Center(
                  child: FaIcon(
                    icon,
                    size: 13.r,
                    color: context.onSurface.withValues(alpha: 0.78),
                  ),
                ),
              ),
              AppSpacing.md.horizontalSpace,
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyles.s14w500.copyWith(
                    color: context.onSurface,
                  ),
                ),
              ),
              if (value != null) ...[
                Text(
                  value!,
                  style: AppTextStyles.s12w400.copyWith(
                    color: context.onSurface.withValues(alpha: 0.55),
                  ),
                ),
                AppSpacing.sm.horizontalSpace,
              ],
              FaIcon(
                context.chevronEnd,
                size: 10.r,
                color: context.onSurface.withValues(alpha: 0.35),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn().slideX(begin: 0.04, duration: 240.ms);
  }
}
