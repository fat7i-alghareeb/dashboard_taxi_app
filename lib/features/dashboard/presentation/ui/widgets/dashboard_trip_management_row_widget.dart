import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/states/dashboard_bloc.dart';

class DashboardTripManagementRowWidget extends StatelessWidget {
  const DashboardTripManagementRowWidget({
    super.key,
    required this.trip,
    required this.isSelected,
  });

  final DashboardTripEntity trip;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: isSelected
            ? context.primary.withValues(alpha: 0.08)
            : context.surface,
        borderRadius: BorderRadius.circular(AppRadii.sm.r),
        border: Border.all(
          color: isSelected
              ? context.primary.withValues(alpha: 0.35)
              : context.onSurface.withValues(alpha: 0.08),
        ),
      ),
      child: Padding(
        padding: REdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            FaIcon(FontAwesomeIcons.taxi, size: 18.r, color: context.primary),
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
                  Text(
                    trip.pickupLabel ?? AppStrings.tripUnknownAddress,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  trip.fareLabel,
                  style: AppTextStyles.s14w600.copyWith(
                    color: context.onSurface,
                  ),
                ),
                AppSpacing.xs.verticalSpace,
                Text(
                  trip.status,
                  style: AppTextStyles.s12w400.copyWith(
                    color: context.onSurface.withValues(alpha: 0.62),
                  ),
                ),
              ],
            ),
            AppSpacing.md.horizontalSpace,
            AppButton.outline(
              onTap: () {
                context.read<DashboardBloc>().add(
                  DashboardEvent.tripDetailsRequested(trip.id),
                );
              },
              child: AppButtonChild.labelIcon(
                label: AppStrings.dashboardDetails,
                icon: IconSource.icon(FontAwesomeIcons.circleInfo),
                iconSize: 14,
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: AppDurations.normal).slideY(begin: 0.04);
  }
}
