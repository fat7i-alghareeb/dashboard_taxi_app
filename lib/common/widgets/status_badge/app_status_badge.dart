import 'package:dashboardtaxi/common/imports/imports.dart';

/// Shared colored-pill status badge. Callers resolve their own
/// entity-specific `(color, label)` pair and pass it in here.
class AppStatusBadge extends StatelessWidget {
  const AppStatusBadge({super.key, required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(color: color.withValues(alpha: 0.28), width: 1.w),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles.s12w500.copyWith(color: color),
      ),
    );
  }
}
