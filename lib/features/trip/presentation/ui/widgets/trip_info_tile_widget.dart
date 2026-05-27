import 'package:dashboardtaxi/common/imports/imports.dart';

class TripInfoTileWidget extends StatelessWidget {
  const TripInfoTileWidget({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label.toUpperCase(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.s11w500.copyWith(
            color: context.onSurface.withValues(alpha: 0.50),
            letterSpacing: 1.1,
          ),
        ),
        AppSpacing.xs.verticalSpace,
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.s16w600.copyWith(color: context.onSurface),
        ),
      ],
    );
  }
}
