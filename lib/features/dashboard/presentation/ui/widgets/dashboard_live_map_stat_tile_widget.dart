import 'package:dashboardtaxi/common/imports/imports.dart';

class DashboardLiveMapStatTileWidget extends StatelessWidget {
  const DashboardLiveMapStatTileWidget({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Container(
              width: 6.r,
              height: 6.r,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            AppSpacing.sm.horizontalSpace,
            Flexible(
              child: Text(
                label.toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.s11w500.copyWith(
                  color: context.onSurface.withValues(alpha: 0.50),
                  letterSpacing: 1.1,
                ),
              ),
            ),
          ],
        ),
        AppSpacing.sm.verticalSpace,
        Text(
          value,
          style: AppTextStyles.s24w700.copyWith(color: context.onSurface),
        ),
      ],
    );
  }
}
