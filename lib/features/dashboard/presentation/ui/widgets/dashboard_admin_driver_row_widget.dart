import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/states/dashboard_bloc.dart';

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
    final summary = AppStrings.dashboardDriverSummary
        .replaceAll('{status}', driver.status)
        .replaceAll('{approval}', driver.approvalStatus)
        .replaceAll(
          '{vehicleType}',
          assignedType?.name ?? AppStrings.dashboardNoVehicleTypeAssigned,
        );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.onSurface.withValues(alpha: 0.035),
        borderRadius: BorderRadius.circular(AppRadii.sm.r),
      ),
      child: Padding(
        padding: REdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            FaIcon(FontAwesomeIcons.solidUser, size: 16.r, color: context.primary),
            AppSpacing.md.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    driver.fullName.isEmpty
                        ? AppStrings.dashboardUnknownDriver
                        : driver.fullName,
                    style: AppTextStyles.s14w600.copyWith(
                      color: context.onSurface,
                    ),
                  ),
                  AppSpacing.xs.verticalSpace,
                  Text(
                    summary,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.s12w400.copyWith(
                      color: context.onSurface.withValues(alpha: 0.62),
                    ),
                  ),
                ],
              ),
            ),
            AppSpacing.sm.horizontalSpace,
            AppButton.outline(
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
              child: AppButtonChild.label(AppStrings.dashboardAssignType),
            ),
            AppSpacing.sm.horizontalSpace,
            AppButton.warning(
              onTap: () {
                context.read<DashboardBloc>().add(
                  DashboardEvent.driverSuspensionRequested(driver.id),
                );
              },
              isLoading: isActionLoading,
              child: AppButtonChild.label(AppStrings.dashboardSuspend),
            ),
          ],
        ),
      ),
    );
  }
}
