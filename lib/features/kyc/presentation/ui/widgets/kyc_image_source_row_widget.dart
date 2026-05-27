import 'package:dashboardtaxi/common/imports/imports.dart';

class KycImageSourceRowWidget extends StatelessWidget {
  const KycImageSourceRowWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.sm.r),
        side: BorderSide(color: context.onSurface.withValues(alpha: 0.08)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.sm.r),
        child: Padding(
          padding: REdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.lg,
          ),
          child: Row(
            children: [
              Container(
                height: 36.r,
                width: 36.r,
                decoration: BoxDecoration(
                  color: context.primary.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(AppRadii.sm.r),
                ),
                child: Center(
                  child: FaIcon(icon, size: 14.r, color: context.primary),
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
              FaIcon(
                context.chevronEnd,
                size: 10.r,
                color: context.onSurface.withValues(alpha: 0.35),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
