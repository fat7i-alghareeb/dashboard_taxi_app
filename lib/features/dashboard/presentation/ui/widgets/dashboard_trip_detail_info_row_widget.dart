import 'package:dashboardtaxi/common/imports/imports.dart';

class DashboardTripDetailInfoRowWidget extends StatelessWidget {
  const DashboardTripDetailInfoRowWidget({
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
      children: [
        Text(
          label.toUpperCase(),
          style: AppTextStyles.s11w500.copyWith(
            color: context.onSurface.withValues(alpha: 0.50),
            letterSpacing: 1.1,
          ),
        ),
        AppSpacing.xs.verticalSpace,
        Text(
          value.isEmpty ? AppStrings.tripUnknownAddress : value,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.s14w500.copyWith(color: context.onSurface),
        ),
      ],
    );
  }
}
