import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/driver/domain/entities/driver_entity.dart';
import 'package:dashboardtaxi/features/driver_home/presentation/states/driver_home_bloc.dart';
import 'package:dashboardtaxi/features/driver_home/presentation/ui/widgets/driver_home_metric_column_widget.dart';
import 'package:dashboardtaxi/features/driver_home/presentation/ui/widgets/driver_status_switch_widget.dart';

class DriverHomeControlsPanelWidget extends StatelessWidget {
  const DriverHomeControlsPanelWidget({
    super.key,
    required this.state,
    required this.isOnline,
    required this.isLoading,
  });

  final DriverHomeState state;
  final bool isOnline;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final earnings =
        state.earningsState.getDataWhenSuccess ??
        const DriverEarningsEntity(
          totalTrips: 0,
          totalEarnings: 0,
          currencyCode: 'EUR',
          trips: [],
        );
    final earningsValue = state.earningsState.isLoading
        ? AppStrings.uploading
        : earnings.totalEarningsLabel;
    final tripsValue = state.earningsState.isLoading
        ? AppStrings.uploading
        : earnings.totalTrips.toString();

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(color: context.onSurface.withValues(alpha: 0.08)),
      ),
      child: Padding(
        padding: REdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: DriverHomeMetricColumnWidget(
                    label: AppStrings.earningsToday,
                    value: earningsValue,
                    accentColor: AppColors.success,
                  ),
                ),
                AppSpacing.md.horizontalSpace,
                Expanded(
                  child: DriverHomeMetricColumnWidget(
                    label: AppStrings.tripsCompletedToday,
                    value: tripsValue,
                  ),
                ),
              ],
            ),
            AppSpacing.lg.verticalSpace,
            Container(
              height: 1,
              color: context.onSurface.withValues(alpha: 0.06),
            ),
            AppSpacing.lg.verticalSpace,
            DriverStatusSwitchWidget(
              isOnline: isOnline,
              isLoading: isLoading,
              onToggle: (nextState) {
                context.read<DriverHomeBloc>().add(
                  DriverHomeEvent.toggleStatusRequested(nextState),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
