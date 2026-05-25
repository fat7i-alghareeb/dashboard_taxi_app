import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:dashboardtaxi/features/trip/presentation/states/trip_bloc.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_lifecycle_action_widget.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_navigation_button_widget.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_route_card_widget.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_status_chip_widget.dart';

class TripExecutionCardWidget extends StatelessWidget {
  const TripExecutionCardWidget({
    super.key,
    required this.trip,
    required this.state,
  });

  final TripEntity trip;
  final TripState state;

  @override
  Widget build(BuildContext context) {
    final navigationStop = trip.status == TripStatus.inProgress
        ? trip.dropoff
        : trip.pickup;

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadii.lg.r),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.surface.withValues(alpha: 0.88),
          borderRadius: BorderRadius.circular(AppRadii.lg.r),
          border: Border.all(color: context.onSurface.withValues(alpha: 0.08)),
        ),
        child: Padding(
          padding: REdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      AppStrings.tripReferenceCode.replaceAll(
                        '{code}',
                        trip.referenceCode,
                      ),
                      style: AppTextStyles.s18w600.copyWith(
                        color: context.onSurface,
                      ),
                    ),
                  ),
                  TripStatusChipWidget(status: trip.status),
                ],
              ),
              AppSpacing.sm.verticalSpace,
              Text(
                trip.vehicleLabel,
                style: AppTextStyles.s14w400.copyWith(
                  color: context.onSurface.withValues(alpha: 0.66),
                ),
              ),
              AppSpacing.lg.verticalSpace,
              TripRouteCardWidget(trip: trip),
              AppSpacing.md.verticalSpace,
              TripNavigationButtonWidget(stop: navigationStop),
              AppSpacing.lg.verticalSpace,
              TripLifecycleActionWidget(trip: trip, state: state),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: AppDurations.normal).slideY(begin: 0.08);
  }
}
