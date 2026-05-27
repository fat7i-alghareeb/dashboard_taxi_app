import 'package:dashboardtaxi/common/imports/imports.dart';

class DriverHomeMetricColumnWidget extends StatelessWidget {
  const DriverHomeMetricColumnWidget({
    super.key,
    required this.label,
    required this.value,
    this.accentColor,
  });

  final String label;
  final String value;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    final dotColor = accentColor ?? context.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Container(
              width: 6.r,
              height: 6.r,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
            AppSpacing.sm.horizontalSpace,
            Flexible(
              child: Text(
                label.toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.s11w500.copyWith(
                  color: context.onSurface.withValues(alpha: 0.55),
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
