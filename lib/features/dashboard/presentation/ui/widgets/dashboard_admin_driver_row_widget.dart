import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/states/dashboard_bloc.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_status_chip_widget.dart';

class DashboardAdminDriverRowWidget extends StatelessWidget {
  const DashboardAdminDriverRowWidget({
    super.key,
    required this.driver,
    required this.vehicleTypes,
    required this.isActionLoading,
  });

  final DashboardDriverEntity driver;
  final List<DashboardVehicleTypeEntity> vehicleTypes;
  final bool isActionLoading;

  @override
  Widget build(BuildContext context) {
    final assignedType = vehicleTypes
        .where((type) => type.id == driver.vehicleTypeId)
        .firstOrNull;
    final fallbackType = vehicleTypes.firstOrNull;
    final vehicleLabel =
        assignedType?.name ?? AppStrings.dashboardNoVehicleTypeAssigned;

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
                    FontAwesomeIcons.solidUser,
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
                      driver.fullName.isEmpty
                          ? AppStrings.dashboardUnknownDriver
                          : driver.fullName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.s14w600.copyWith(
                        color: context.onSurface,
                      ),
                    ),
                    AppSpacing.xs.verticalSpace,
                    Text(
                      vehicleLabel,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.s12w400.copyWith(
                        color: context.onSurface.withValues(alpha: 0.60),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          AppSpacing.sm.verticalSpace,
          Wrap(
            spacing: AppSpacing.sm.w,
            runSpacing: AppSpacing.xs.h,
            children: [
              DashboardStatusChipWidget(
                label: driver.status,
                tone: dashboardToneFromDriverStatus(driver.status),
                dense: true,
              ),
              DashboardStatusChipWidget(
                label: driver.approvalStatus,
                tone: dashboardToneFromApprovalStatus(driver.approvalStatus),
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
                    if (fallbackType == null) return;
                    context.read<DashboardBloc>().add(
                      DashboardEvent.driverVehicleTypeAssignmentRequested(
                        driverId: driver.id,
                        vehicleTypeId: fallbackType.id,
                      ),
                    );
                  },
                  isActive: fallbackType != null,
                  isLoading: isActionLoading,
                  layout: const AppButtonLayout(height: 36),
                  child: AppButtonChild.label(
                    AppStrings.dashboardAssignType,
                    maxLines: 1,
                  ),
                ),
              ),
              AppSpacing.sm.horizontalSpace,
              Expanded(
                child: AppButton.warning(
                  onTap: () {
                    context.read<DashboardBloc>().add(
                      DashboardEvent.driverSuspensionRequested(driver.id),
                    );
                  },
                  isLoading: isActionLoading,
                  layout: const AppButtonLayout(height: 36),
                  child: AppButtonChild.label(
                    AppStrings.dashboardSuspend,
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
