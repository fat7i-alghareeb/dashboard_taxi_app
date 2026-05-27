import 'package:dashboardtaxi/common/imports/imports.dart';

class DashboardHeaderQuickLinkWidget extends StatelessWidget {
  const DashboardHeaderQuickLinkWidget({
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
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        side: BorderSide(color: context.onSurface.withValues(alpha: 0.08)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        child: Padding(
          padding: REdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(icon, size: 14.r, color: context.primary),
              AppSpacing.sm.verticalSpace,
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.s12w500.copyWith(color: context.onSurface),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
