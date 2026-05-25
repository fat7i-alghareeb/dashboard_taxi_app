import 'package:dashboardtaxi/common/imports/imports.dart';

class DashboardTripTimelineRowWidget extends StatelessWidget {
  const DashboardTripTimelineRowWidget({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    final isComplete = value != null && value!.isNotEmpty;

    return Padding(
      padding: REdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        children: [
          FaIcon(
            isComplete ? FontAwesomeIcons.circleCheck : FontAwesomeIcons.clock,
            size: 14.r,
            color: isComplete ? AppColors.success : context.onSurfaceVariant,
          ),
          AppSpacing.sm.horizontalSpace,
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.s12w500.copyWith(color: context.onSurface),
            ),
          ),
          AppSpacing.sm.horizontalSpace,
          Text(
            value ?? AppStrings.dashboardNotReached,
            style: AppTextStyles.s12w400.copyWith(
              color: context.onSurface.withValues(alpha: 0.62),
            ),
          ),
        ],
      ),
    );
  }
}
