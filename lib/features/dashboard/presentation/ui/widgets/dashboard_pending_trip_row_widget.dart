import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_status_chip_widget.dart';
import 'package:dashboardtaxi/features/root/domain/services/root_tab_controller.dart';
import 'package:dashboardtaxi/features/trip/presentation/states/trip_bloc.dart';

class DashboardPendingTripRowWidget extends StatelessWidget {
  const DashboardPendingTripRowWidget({
    super.key,
    required this.trip,
    required this.drivers,
  });

  final DashboardTripEntity trip;
  final List<DashboardDriverEntity> drivers;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                height: 36.r,
                width: 36.r,
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(AppRadii.sm.r),
                ),
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.route,
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
                          label: dashboardTripStatusLabel(trip.status),
                          tone: dashboardToneFromTripStatus(trip.status),
                          dense: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (trip.isScheduled) ...[
            AppSpacing.sm.verticalSpace,
            Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.solidCalendarCheck,
                  size: 12.r,
                  color: AppColors.warning,
                ),
                AppSpacing.sm.horizontalSpace,
                Expanded(
                  child: Text(
                    AppStrings.scheduledForLabel.trParams({
                      'when': trip.scheduledAt!.toLocal().toSmartDateTime(),
                    }),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.s12w500.copyWith(
                      color: AppColors.warning,
                    ),
                  ),
                ),
              ],
            ),
          ],
          if ((trip.pickupLabel ?? '').isNotEmpty) ...[
            AppSpacing.sm.verticalSpace,
            Text(
              trip.pickupLabel!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.s12w400.copyWith(
                color: context.onSurface.withValues(alpha: 0.60),
              ),
            ),
          ],
          if (trip.isAirport &&
              trip.flightNumber?.trim().isNotEmpty == true) ...[
            AppSpacing.sm.verticalSpace,
            _AirportFlightSummary(flightNumber: trip.flightNumber!.trim()),
          ],
          AppSpacing.md.verticalSpace,
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: AppButton.outline(
              onTap: () {
                getIt<TripBloc>().add(
                  TripEvent.adminSelfAssignRequested(trip.id),
                );
                getIt<RootTabController>().goToHome();
              },
              layout: AppButtonLayout(
                height: 36,
                contentPadding: REdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.xs,
                ),
              ),
              child: AppButtonChild.label(
                AppStrings.adminTakeTrip,
                maxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AirportFlightSummary extends StatelessWidget {
  const _AirportFlightSummary({required this.flightNumber});

  final String flightNumber;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FaIcon(
          FontAwesomeIcons.planeArrival,
          size: 12.r,
          color: context.primary,
        ),
        AppSpacing.sm.horizontalSpace,
        Text(
          '${AppStrings.flightNumber}: $flightNumber',
          style: AppTextStyles.s12w500.copyWith(
            color: context.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
