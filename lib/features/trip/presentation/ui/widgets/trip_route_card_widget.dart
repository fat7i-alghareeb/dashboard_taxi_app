import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/trip/domain/entities/trip_entity.dart';

class TripRouteCardWidget extends StatelessWidget {
  const TripRouteCardWidget({super.key, required this.trip});

  final TripEntity trip;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.surface.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(color: context.onSurface.withValues(alpha: 0.08)),
      ),
      child: Padding(
        padding: REdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            _TripStopRow(
              icon: FontAwesomeIcons.locationDot,
              label: AppStrings.tripPickup,
              value: trip.pickup?.displayLabel ?? AppStrings.tripUnknownAddress,
              color: AppColors.success,
            ),
            AppSpacing.lg.verticalSpace,
            _TripStopRow(
              icon: FontAwesomeIcons.flagCheckered,
              label: AppStrings.tripDropoff,
              value:
                  trip.dropoff?.displayLabel ?? AppStrings.tripUnknownAddress,
              color: context.primary,
            ),
          ],
        ),
      ),
    );
  }
}

class _TripStopRow extends StatelessWidget {
  const _TripStopRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FaIcon(icon, size: 18.r, color: color),
        AppSpacing.md.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.s14w400.copyWith(
                  color: context.onSurface.withValues(alpha: 0.62),
                ),
              ),
              AppSpacing.xs.verticalSpace,
              Text(
                value,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.s16w600.copyWith(color: context.onSurface),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
