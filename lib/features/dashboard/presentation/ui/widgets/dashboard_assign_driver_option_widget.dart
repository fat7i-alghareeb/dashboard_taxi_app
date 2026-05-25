import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/states/dashboard_bloc.dart';
import 'package:dashboardtaxi/features/root/presentation/ui/screens/root_screen.dart';

class DashboardAssignDriverOptionWidget extends StatelessWidget {
  const DashboardAssignDriverOptionWidget({
    super.key,
    required this.trip,
    required this.driver,
    required this.isLoading,
    this.isSelfAssignment = false,
    this.distanceKm,
  });

  final DashboardTripEntity trip;
  final DashboardDriverEntity driver;
  final bool isLoading;
  final bool isSelfAssignment;
  final double? distanceKm;

  @override
  Widget build(BuildContext context) {
    final distanceText = distanceKm == null
        ? null
        : AppStrings.dashboardDistanceKm.replaceAll(
            '{value}',
            distanceKm!.toStringAsFixed(1),
          );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(AppRadii.sm.r),
        border: Border.all(color: context.onSurface.withValues(alpha: 0.08)),
      ),
      child: Padding(
        padding: REdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            FaIcon(
              FontAwesomeIcons.solidUser,
              size: 16.r,
              color: context.primary,
            ),
            AppSpacing.md.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    driver.fullName.isEmpty ? driver.id : driver.fullName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.s14w600.copyWith(
                      color: context.onSurface,
                    ),
                  ),
                  AppSpacing.xs.verticalSpace,
                  Text(
                    distanceText ?? driver.licenseNumber,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.s12w400.copyWith(
                      color: context.onSurface.withValues(alpha: 0.62),
                    ),
                  ),
                ],
              ),
            ),
            AppSpacing.sm.horizontalSpace,
            AppButton.success(
              isLoading: isLoading,
              onTap: () {
                context.read<DashboardBloc>().add(
                  DashboardEvent.tripAssignmentRequested(
                    tripId: trip.id,
                    driverId: driver.id,
                    enterDriverMode: isSelfAssignment,
                  ),
                );
                context.pop();
                if (isSelfAssignment) {
                  context.go(RootScreen.pagePath);
                }
              },
              child: AppButtonChild.label(
                isSelfAssignment
                    ? AppStrings.dashboardAssignToMe
                    : AppStrings.dashboardAssign,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
