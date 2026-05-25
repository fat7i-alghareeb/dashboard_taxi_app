import 'package:dashboardtaxi/common/imports/imports.dart';

class DashboardTripStopLineWidget extends StatelessWidget {
  const DashboardTripStopLineWidget({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: context.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppRadii.sm.r),
          ),
          child: Padding(
            padding: REdgeInsets.all(AppSpacing.sm),
            child: FaIcon(icon, size: 14.r, color: context.primary),
          ),
        ),
        AppSpacing.md.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.s12w400.copyWith(
                  color: context.onSurface.withValues(alpha: 0.62),
                ),
              ),
              AppSpacing.xs.verticalSpace,
              Text(
                value,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.s14w600.copyWith(color: context.onSurface),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
