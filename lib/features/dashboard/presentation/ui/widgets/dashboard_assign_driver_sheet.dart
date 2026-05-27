import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/core/services/session/auth_manager.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/states/dashboard_bloc.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_assign_driver_option_widget.dart';

class DashboardAssignDriverSheet extends StatelessWidget {
  const DashboardAssignDriverSheet({
    super.key,
    required this.trip,
    required this.drivers,
    this.driverDistances = const {},
  });

  final DashboardTripEntity trip;
  final List<DashboardDriverEntity> drivers;
  final Map<String, double> driverDistances;

  static Future<void> show(
    BuildContext context, {
    required DashboardTripEntity trip,
    required List<DashboardDriverEntity> drivers,
    Map<String, double> driverDistances = const {},
  }) async {
    final bloc = context.read<DashboardBloc>();

    await AppBottomSheet.show<void>(
      context,
      sheet: AppBottomSheet.basic(
        title: AppStrings.dashboardAssignDriver,
        child: BlocProvider.value(
          value: bloc,
          child: DashboardAssignDriverSheet(
            trip: trip,
            drivers: drivers,
            driverDistances: driverDistances,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        final compatibleDrivers = drivers
            .where((driver) => driver.vehicleTypeId == trip.vehicleTypeId)
            .toList();
        final rankedDrivers = List<DashboardDriverEntity>.of(compatibleDrivers)
          ..sort((left, right) {
            final leftDistance = driverDistances[left.id] ?? double.infinity;
            final rightDistance = driverDistances[right.id] ?? double.infinity;
            return leftDistance.compareTo(rightDistance);
          });
        final currentUser = getIt<AuthManager>().currentUser;
        final selfDriverMatches = rankedDrivers.where(
          (driver) =>
              driver.id == currentUser?.driverId ||
              driver.userId == currentUser?.id,
        );
        final selfDriver = selfDriverMatches.isEmpty
            ? null
            : selfDriverMatches.first;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trip.referenceCode,
                        style: AppTextStyles.s16w600.copyWith(
                          color: context.onSurface,
                        ),
                      ),
                      AppSpacing.xs.verticalSpace,
                      Text(
                        trip.fareLabel,
                        style: AppTextStyles.s12w400.copyWith(
                          color: context.onSurface.withValues(alpha: 0.55),
                        ),
                      ),
                    ],
                  ),
                ),
                if (driverDistances.isNotEmpty)
                  Text(
                    AppStrings.dashboardNearestDrivers,
                    style: AppTextStyles.s11w500.copyWith(
                      color: context.onSurface.withValues(alpha: 0.45),
                      letterSpacing: 0.8,
                    ),
                  ),
              ],
            ),
            AppSpacing.lg.verticalSpace,
            if (compatibleDrivers.isEmpty)
              EmptyStateWidget(text: AppStrings.dashboardNoAssignableDrivers)
            else ...[
              if (selfDriver != null) ...[
                DashboardAssignDriverOptionWidget(
                  trip: trip,
                  driver: selfDriver,
                  distanceKm: driverDistances[selfDriver.id],
                  isLoading: state.tripAssignmentState.isLoading,
                  isSelfAssignment: true,
                ),
                AppSpacing.sm.verticalSpace,
              ],
              ...rankedDrivers
                  .where((driver) => driver.id != selfDriver?.id)
                  .map(
                    (driver) => Padding(
                      padding: REdgeInsets.only(bottom: AppSpacing.sm),
                      child: DashboardAssignDriverOptionWidget(
                        trip: trip,
                        driver: driver,
                        distanceKm: driverDistances[driver.id],
                        isLoading: state.tripAssignmentState.isLoading,
                      ),
                    ),
                  ),
            ],
          ],
        );
      },
    );
  }
}
