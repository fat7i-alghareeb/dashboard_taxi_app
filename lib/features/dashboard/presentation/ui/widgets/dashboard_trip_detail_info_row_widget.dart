import 'package:dashboardtaxi/common/imports/imports.dart';

class DashboardTripDetailInfoRowWidget extends StatelessWidget {
  const DashboardTripDetailInfoRowWidget({
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FaIcon(icon, size: 15.r, color: context.primary),
        AppSpacing.sm.horizontalSpace,
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
                value.isEmpty ? AppStrings.tripUnknownAddress : value,
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
