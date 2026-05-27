import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_divider_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_overview_label_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_status_chip_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_trip_detail_info_row_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_trip_stops_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_trip_timeline_widget.dart';

class DashboardTripDetailsBodyWidget extends StatelessWidget {
  const DashboardTripDetailsBodyWidget({super.key, required this.details});

  final DashboardTripDetailsEntity details;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                details.referenceCode,
                style: AppTextStyles.s20w700.copyWith(color: context.onSurface),
              ),
            ),
            AppSpacing.sm.horizontalSpace,
            DashboardStatusChipWidget(
              label: details.status,
              tone: dashboardToneFromTripStatus(details.status),
            ),
          ],
        ),
        AppSpacing.xs.verticalSpace,
        Text(
          details.fareLabel,
          style: AppTextStyles.s14w500.copyWith(color: context.primary),
        ),
        AppSpacing.lg.verticalSpace,
        const DashboardDividerWidget(),
        AppSpacing.lg.verticalSpace,
        LayoutBuilder(
          builder: (context, constraints) {
            const spacing = AppSpacing.lg;
            final tile = (constraints.maxWidth - spacing.w) / 2;
            final tiles = <Widget>[
              DashboardTripDetailInfoRowWidget(
                label: AppStrings.dashboardPassenger,
                value: details.passengerName,
              ),
              DashboardTripDetailInfoRowWidget(
                label: AppStrings.phoneNumber,
                value: details.passengerPhone,
              ),
              DashboardTripDetailInfoRowWidget(
                label: AppStrings.dashboardDriver,
                value:
                    details.driverName ?? AppStrings.dashboardUnknownDriver,
              ),
              DashboardTripDetailInfoRowWidget(
                label: AppStrings.tripVehicleType,
                value: details.vehicleTypeName,
              ),
            ];
            return Wrap(
              spacing: spacing.w,
              runSpacing: spacing.h,
              children: [
                for (final t in tiles) SizedBox(width: tile, child: t),
              ],
            );
          },
        ),
        AppSpacing.xl.verticalSpace,
        DashboardOverviewLabelWidget(label: AppStrings.dashboardRouteSummary),
        AppSpacing.md.verticalSpace,
        DashboardTripStopsWidget(details: details),
        AppSpacing.xl.verticalSpace,
        DashboardOverviewLabelWidget(label: AppStrings.dashboardLifecycle),
        AppSpacing.md.verticalSpace,
        DashboardTripTimelineWidget(details: details),
      ],
    );
  }
}
