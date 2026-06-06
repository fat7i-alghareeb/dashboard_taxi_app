import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_status_chip_widget.dart';

class DashboardMetricCardWidget extends StatelessWidget {
  const DashboardMetricCardWidget({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.tone = DashboardStatusTone.primary,
    this.trailingChip,
  });

  final String label;
  final String value;
  final FaIconData icon;
  final DashboardStatusTone tone;
  final String? trailingChip;

  Color _toneColor(BuildContext context) {
    switch (tone) {
      case DashboardStatusTone.primary:
        return context.primary;
      case DashboardStatusTone.success:
        return AppColors.success;
      case DashboardStatusTone.warning:
        return AppColors.warning;
      case DashboardStatusTone.error:
        return AppColors.error;
      case DashboardStatusTone.info:
        return AppColors.info;
      case DashboardStatusTone.neutral:
        return context.onSurface;
    }
  }

  @override
  Widget build(BuildContext context) {
    final accent = _toneColor(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(
          color: context.onSurface.withValues(alpha: 0.08),
        ),
      ),
      child: Padding(
        padding: REdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 36.r,
                  width: 36.r,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(AppRadii.sm.r),
                  ),
                  child: Center(
                    child: FaIcon(icon, size: 16.r, color: accent),
                  ),
                ),
                const Spacer(),
                if (trailingChip != null)
                  DashboardStatusChipWidget(
                    label: trailingChip!,
                    tone: tone,
                    dense: true,
                  ),
              ],
            ),
            AppSpacing.lg.verticalSpace,
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.s28w700.copyWith(color: context.onSurface),
            ),
            AppSpacing.xs.verticalSpace,
            Text(
              label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.s12w400.copyWith(
                color: context.onSurface.withValues(alpha: 0.60),
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
