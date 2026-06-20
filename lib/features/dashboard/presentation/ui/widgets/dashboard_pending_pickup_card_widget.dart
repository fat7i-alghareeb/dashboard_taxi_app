import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_status_chip_widget.dart';
import 'package:dashboardtaxi/features/root/domain/services/root_tab_controller.dart';
import 'package:dashboardtaxi/features/trip/presentation/states/trip_bloc.dart';

class DashboardPendingPickupCardWidget extends StatelessWidget {
  const DashboardPendingPickupCardWidget({
    super.key,
    required this.trip,
    required this.drivers,
    required this.liveDrivers,
  });

  final DashboardTripEntity trip;
  final List<DashboardDriverEntity> drivers;
  final List<DashboardDriverLocationEntity> liveDrivers;

  @override
  Widget build(BuildContext context) {
    final pickup = trip.pickupLabel == null || trip.pickupLabel!.isEmpty
        ? AppStrings.dashboardNoPickupLocation
        : trip.pickupLabel!;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(color: context.onSurface.withValues(alpha: 0.08)),
      ),
      child: Padding(
        padding: REdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  height: 40.r,
                  width: 40.r,
                  decoration: BoxDecoration(
                    color: AppColors.warning.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(AppRadii.sm.r),
                  ),
                  child: Center(
                    child: FaIcon(
                      FontAwesomeIcons.locationDot,
                      size: 14.r,
                      color: AppColors.warning,
                    ),
                  ),
                ),
                AppSpacing.md.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trip.referenceCode,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.s14w600.copyWith(
                          color: context.onSurface,
                        ),
                      ),
                      AppSpacing.xs.verticalSpace,
                      Row(
                        children: [
                          Text(
                            trip.fareLabel,
                            style: AppTextStyles.s12w500.copyWith(
                              color: context.onSurface.withValues(alpha: 0.78),
                            ),
                          ),
                          AppSpacing.sm.horizontalSpace,
                          DashboardStatusChipWidget(
                            label: trip.status,
                            tone: DashboardStatusTone.warning,
                            dense: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            AppSpacing.md.verticalSpace,
            Text(
              pickup,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.s12w400.copyWith(
                color: context.onSurface.withValues(alpha: 0.60),
              ),
            ),
            AppSpacing.lg.verticalSpace,
            AppButton.primary(
              onTap: () {
                getIt<TripBloc>().add(
                  TripEvent.adminSelfAssignRequested(trip.id),
                );
                getIt<RootTabController>().goToHome();
              },
              layout: const AppButtonLayout(height: 40),
              child: AppButtonChild.label(AppStrings.adminTakeTrip),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 280.ms).slideY(begin: 0.05, end: 0);
  }

}
