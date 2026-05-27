import 'package:dashboardtaxi/common/imports/imports.dart';

class DashboardTripStopLineWidget extends StatelessWidget {
  const DashboardTripStopLineWidget({
    super.key,
    required this.label,
    required this.value,
    required this.isPickup,
    required this.isLast,
  });

  final String label;
  final String value;
  final bool isPickup;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final dotColor = isPickup
        ? context.primary
        : context.onSurface.withValues(alpha: 0.45);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 10.r,
                height: 10.r,
                margin: REdgeInsets.only(top: AppSpacing.xs),
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
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
                    label.toUpperCase(),
                    style: AppTextStyles.s11w500.copyWith(
                      color: context.onSurface.withValues(alpha: 0.50),
                      letterSpacing: 1.1,
                    ),
                  ),
                  AppSpacing.xs.verticalSpace,
                  Text(
                    value,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.s14w500.copyWith(
                      color: context.onSurface,
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
