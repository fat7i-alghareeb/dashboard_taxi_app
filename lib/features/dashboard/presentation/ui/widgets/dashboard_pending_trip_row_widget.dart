import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_assign_driver_sheet.dart';

class DashboardPendingTripRowWidget extends StatelessWidget {
  const DashboardPendingTripRowWidget({
    super.key,
    required this.trip,
    required this.drivers,
  });

  final DashboardTripEntity trip;
  final List<DashboardDriverEntity> drivers;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.surface.withValues(alpha: 0.58),
        borderRadius: BorderRadius.circular(AppRadii.sm.r),
        border: Border.all(color: context.onSurface.withValues(alpha: 0.08)),
      ),
      child: Padding(
        padding: REdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            FaIcon(FontAwesomeIcons.route, size: 16.r, color: context.primary),
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
                    '${trip.fareLabel} • ${trip.status}',
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
            AppButton.primary(
              onTap: () => DashboardAssignDriverSheet.show(
                context,
                trip: trip,
                drivers: drivers,
              ),
              layout: AppButtonLayout(
                height: 34,
                contentPadding: REdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs,
                ),
              ),
              child: AppButtonChild.label(AppStrings.dashboardAssignDriver),
            ),
          ],
        ),
      ),
    );
  }
}
