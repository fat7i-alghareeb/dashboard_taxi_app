import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/common/widgets/stop_address_actions_widget.dart';

class TripStopRowWidget extends StatelessWidget {
  const TripStopRowWidget({
    super.key,
    required this.label,
    required this.value,
    required this.isPickup,
    required this.isLast,
    this.isCompleted = false,
    this.isNext = false,
    this.latitude,
    this.longitude,
  });

  final String label;
  final String value;
  final bool isPickup;
  final bool isLast;
  final bool isCompleted;
  final bool isNext;
  final double? latitude;
  final double? longitude;

  @override
  Widget build(BuildContext context) {
    final dotColor = isCompleted
        ? AppColors.success
        : isNext
        ? context.primary
        : context.onSurface.withValues(alpha: 0.45);

    final lineColor = isCompleted
        ? AppColors.success.withValues(alpha: 0.4)
        : context.onSurface.withValues(alpha: 0.15);

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
                    color: lineColor,
                  ),
                ),
            ],
          ),
          AppSpacing.md.horizontalSpace,
          Expanded(
            child: Padding(
              padding: REdgeInsets.only(bottom: isLast ? 0 : AppSpacing.lg),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label.toUpperCase(),
                          style: AppTextStyles.s11w500.copyWith(
                            color: isNext
                                ? context.primary
                                : context.onSurface.withValues(alpha: 0.50),
                            fontWeight: isNext
                                ? FontWeight.w700
                                : FontWeight.w500,
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
                            fontWeight: isNext
                                ? FontWeight.w700
                                : FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppSpacing.sm.horizontalSpace,
                  StopAddressActionsWidget(
                    address: value,
                    latitude: latitude,
                    longitude: longitude,
                    highlight: isNext,
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
