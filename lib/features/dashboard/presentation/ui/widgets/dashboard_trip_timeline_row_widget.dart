import 'package:dashboardtaxi/common/imports/imports.dart';

class DashboardTripTimelineRowWidget extends StatelessWidget {
  const DashboardTripTimelineRowWidget({
    super.key,
    required this.label,
    required this.value,
    required this.isLast,
  });

  final String label;
  final String? value;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final isComplete = value != null && value!.isNotEmpty;
    final dotColor = isComplete
        ? AppColors.success
        : context.onSurface.withValues(alpha: 0.25);
    final fillColor = isComplete ? AppColors.success : Colors.transparent;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 12.r,
                height: 12.r,
                margin: REdgeInsets.only(top: AppSpacing.xs / 2),
                decoration: BoxDecoration(
                  color: fillColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: dotColor, width: 1.5),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 1.5.r,
                    margin: REdgeInsets.symmetric(vertical: AppSpacing.xs / 2),
                    color: context.onSurface.withValues(alpha: 0.15),
                  ),
                ),
            ],
          ),
          AppSpacing.md.horizontalSpace,
          Expanded(
            child: Padding(
              padding: REdgeInsets.only(bottom: isLast ? 0 : AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTextStyles.s12w500.copyWith(
                      color: context.onSurface.withValues(
                        alpha: isComplete ? 0.85 : 0.50,
                      ),
                    ),
                  ),
                  AppSpacing.xs.verticalSpace,
                  Text(
                    value ?? AppStrings.dashboardNotReached,
                    style: AppTextStyles.s12w400.copyWith(
                      color: context.onSurface.withValues(
                        alpha: isComplete ? 0.62 : 0.35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
