import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_section_shell_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_trip_detail_info_row_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_trip_stops_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_trip_timeline_widget.dart';

class DashboardTripDetailsPanelWidget extends StatelessWidget {
  const DashboardTripDetailsPanelWidget({super.key, required this.state});

  final BlocStatus<DashboardTripDetailsEntity> state;

  @override
  Widget build(BuildContext context) {
    return DashboardSectionShellWidget(
      title: AppStrings.dashboardTripDetails,
      icon: FontAwesomeIcons.clipboardList,
      child: StatusBuilder<DashboardTripDetailsEntity>(
        state: state,
        init: () => EmptyStateWidget(text: AppStrings.dashboardSelectTrip),
        loading: () => AppShimmer.box(width: double.infinity, height: 260),
        success: (details) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    details.referenceCode,
                    style: AppTextStyles.s18w600.copyWith(
                      color: context.onSurface,
                    ),
                  ),
                ),
                Text(
                  details.status,
                  style: AppTextStyles.s12w500.copyWith(
                    color: context.primary,
                  ),
                ),
              ],
            ),
            AppSpacing.lg.verticalSpace,
            Wrap(
              spacing: AppSpacing.lg.w,
              runSpacing: AppSpacing.lg.h,
              children: [
                SizedBox(
                  width: 260.w,
                  child: DashboardTripDetailInfoRowWidget(
                    label: AppStrings.dashboardPassenger,
                    value: details.passengerName,
                    icon: FontAwesomeIcons.solidUser,
                  ),
                ),
                SizedBox(
                  width: 260.w,
                  child: DashboardTripDetailInfoRowWidget(
                    label: AppStrings.phoneNumber,
                    value: details.passengerPhone,
                    icon: FontAwesomeIcons.phone,
                  ),
                ),
                SizedBox(
                  width: 260.w,
                  child: DashboardTripDetailInfoRowWidget(
                    label: AppStrings.dashboardDriver,
                    value:
                        details.driverName ?? AppStrings.dashboardUnknownDriver,
                    icon: FontAwesomeIcons.idBadge,
                  ),
                ),
                SizedBox(
                  width: 260.w,
                  child: DashboardTripDetailInfoRowWidget(
                    label: AppStrings.tripVehicleType,
                    value: details.vehicleTypeName,
                    icon: FontAwesomeIcons.taxi,
                  ),
                ),
                SizedBox(
                  width: 260.w,
                  child: DashboardTripDetailInfoRowWidget(
                    label: AppStrings.tripFareLabel,
                    value: details.fareLabel,
                    icon: FontAwesomeIcons.moneyBillWave,
                  ),
                ),
              ],
            ),
            AppSpacing.xl.verticalSpace,
            Text(
              AppStrings.dashboardRoute,
              style: AppTextStyles.s16w600.copyWith(color: context.onSurface),
            ),
            AppSpacing.md.verticalSpace,
            DashboardTripStopsWidget(details: details),
            AppSpacing.xl.verticalSpace,
            Text(
              AppStrings.dashboardTimeline,
              style: AppTextStyles.s16w600.copyWith(color: context.onSurface),
            ),
            AppSpacing.md.verticalSpace,
            DashboardTripTimelineWidget(details: details),
          ],
        ),
      ),
    );
  }
}
