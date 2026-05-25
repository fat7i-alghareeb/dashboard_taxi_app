import 'package:dashboardtaxi/common/imports/imports.dart';

class DashboardLiveMapStatTileWidget extends StatelessWidget {
  const DashboardLiveMapStatTileWidget({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FaIcon(icon, size: 14.r, color: color),
        AppSpacing.xs.verticalSpace,
        Text(
          value,
          style: AppTextStyles.s20w700.copyWith(color: context.onSurface),
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
    );
  }
}
