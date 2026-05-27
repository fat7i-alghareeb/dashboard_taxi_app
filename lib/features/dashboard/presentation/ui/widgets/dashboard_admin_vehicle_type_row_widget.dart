import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/states/dashboard_bloc.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_status_chip_widget.dart';

class DashboardAdminVehicleTypeRowWidget extends StatelessWidget {
  const DashboardAdminVehicleTypeRowWidget({
    super.key,
    required this.vehicleType,
    required this.isActionLoading,
  });

  final DashboardVehicleTypeEntity vehicleType;
  final bool isActionLoading;

  @override
  Widget build(BuildContext context) {
    final capacity = AppStrings.dashboardCapacityValue.replaceAll(
      '{value}',
      vehicleType.capacity.toString(),
    );
    final minFare = AppStrings.dashboardMinFareValue.replaceAll(
      '{value}',
      vehicleType.minFare.toStringAsFixed(2),
    );

    return Padding(
      padding: REdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                height: 40.r,
                width: 40.r,
                decoration: BoxDecoration(
                  color: context.primary.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(AppRadii.sm.r),
                ),
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.carSide,
                    size: 14.r,
                    color: context.primary,
                  ),
                ),
              ),
              AppSpacing.md.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vehicleType.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.s14w600.copyWith(
                        color: context.onSurface,
                      ),
                    ),
                    AppSpacing.xs.verticalSpace,
                    Text(
                      '$capacity · $minFare',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.s12w400.copyWith(
                        color: context.onSurface.withValues(alpha: 0.60),
                      ),
                    ),
                  ],
                ),
              ),
              AppSpacing.sm.horizontalSpace,
              DashboardStatusChipWidget(
                label: vehicleType.isActive
                    ? AppStrings.dashboardEnabled
                    : AppStrings.dashboardDisabled,
                tone: vehicleType.isActive
                    ? DashboardStatusTone.success
                    : DashboardStatusTone.error,
                dense: true,
              ),
            ],
          ),
          AppSpacing.md.verticalSpace,
          Row(
            children: [
              Expanded(
                child: AppButton.outline(
                  onTap: () {
                    context.read<DashboardBloc>().add(
                      DashboardEvent.vehicleTypeStatusToggleRequested(
                        vehicleType,
                      ),
                    );
                  },
                  isLoading: isActionLoading,
                  layout: const AppButtonLayout(height: 36),
                  child: AppButtonChild.label(
                    AppStrings.dashboardToggle,
                    maxLines: 1,
                  ),
                ),
              ),
              AppSpacing.sm.horizontalSpace,
              Expanded(
                child: AppButton.error(
                  onTap: () {
                    context.read<DashboardBloc>().add(
                      DashboardEvent.vehicleTypeRemovalRequested(
                        vehicleType.id,
                      ),
                    );
                  },
                  isLoading: isActionLoading,
                  layout: const AppButtonLayout(height: 36),
                  child: AppButtonChild.label(
                    AppStrings.dashboardRemove,
                    maxLines: 1,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
