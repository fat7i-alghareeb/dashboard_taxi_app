import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_status_chip_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_trip_card_stops_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_trip_card_timeline_widget.dart';
import 'package:dashboardtaxi/features/root/domain/services/root_tab_controller.dart';
import 'package:dashboardtaxi/features/trip/presentation/states/trip_bloc.dart';

class DashboardTripManagementRowWidget extends StatelessWidget {
  const DashboardTripManagementRowWidget({
    super.key,
    required this.trip,
    required this.isSelected,
  });

  final DashboardTripEntity trip;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected
          ? context.primary.withValues(alpha: 0.06)
          : Colors.transparent,
      child: InkWell(
        // Selecting a trip loads it into the Home bottom sheet and jumps to the
        // Home map tab where the status-specific actions live.
        onTap: () {
          getIt<TripBloc>().add(TripEvent.tripSelected(trip.id));
          getIt<RootTabController>().goToHome();
        },
        child: Padding(
          padding: REdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      trip.referenceCode,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.s14w600.copyWith(
                        color: context.onSurface,
                      ),
                    ),
                  ),
                  AppSpacing.sm.horizontalSpace,
                  Text(
                    trip.fareLabel,
                    style: AppTextStyles.s14w600.copyWith(
                      color: context.onSurface,
                    ),
                  ),
                ],
              ),
              AppSpacing.sm.verticalSpace,
              DashboardTripCardStopsWidget(trip: trip),
              AppSpacing.sm.verticalSpace,
              Row(
                children: [
                  DashboardStatusChipWidget(
                    label: trip.status,
                    tone: dashboardToneFromTripStatus(trip.status),
                    dense: true,
                  ),
                  const Spacer(),
                  FaIcon(
                    context.chevronEnd,
                    size: 12.r,
                    color: context.onSurface.withValues(alpha: 0.35),
                  ),
                ],
              ),
              AppSpacing.md.verticalSpace,
              DashboardTripCardTimelineWidget(trip: trip),
            ],
          ),
        ),
      ),
    );
  }
}
