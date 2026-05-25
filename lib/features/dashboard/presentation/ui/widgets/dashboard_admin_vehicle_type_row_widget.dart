import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/states/dashboard_bloc.dart';

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
    final pricingSummary = AppStrings.dashboardVehicleTypePricingSummary
        .replaceAll('{capacity}', capacity)
        .replaceAll('{minFare}', minFare);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.onSurface.withValues(alpha: 0.035),
        borderRadius: BorderRadius.circular(AppRadii.sm.r),
      ),
      child: Padding(
        padding: REdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            FaIcon(FontAwesomeIcons.carSide, size: 16.r, color: context.primary),
            AppSpacing.md.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vehicleType.name,
                    style: AppTextStyles.s14w600.copyWith(
                      color: context.onSurface,
                    ),
                  ),
                  AppSpacing.xs.verticalSpace,
                  Text(
                    pricingSummary,
                    style: AppTextStyles.s12w400.copyWith(
                      color: context.onSurface.withValues(alpha: 0.62),
                    ),
                  ),
                ],
              ),
            ),
            AppSpacing.sm.horizontalSpace,
            Text(
              vehicleType.isActive
                  ? AppStrings.dashboardEnabled
                  : AppStrings.dashboardDisabled,
              style: AppTextStyles.s12w500.copyWith(
                color: vehicleType.isActive ? AppColors.success : AppColors.error,
              ),
            ),
            AppSpacing.md.horizontalSpace,
            AppButton.outline(
              onTap: () {
                context.read<DashboardBloc>().add(
                  DashboardEvent.vehicleTypeStatusToggleRequested(vehicleType),
                );
              },
              isLoading: isActionLoading,
              child: AppButtonChild.label(AppStrings.dashboardToggle),
            ),
            AppSpacing.sm.horizontalSpace,
            AppButton.error(
              onTap: () {
                context.read<DashboardBloc>().add(
                  DashboardEvent.vehicleTypeRemovalRequested(vehicleType.id),
                );
              },
              isLoading: isActionLoading,
              child: AppButtonChild.label(AppStrings.dashboardRemove),
            ),
          ],
        ),
      ),
    );
  }
}
