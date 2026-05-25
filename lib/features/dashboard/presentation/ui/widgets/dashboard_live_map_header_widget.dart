import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/states/dashboard_bloc.dart';

class DashboardLiveMapHeaderWidget extends StatelessWidget {
  const DashboardLiveMapHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.surface.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(color: context.onSurface.withValues(alpha: 0.08)),
        boxShadow: context.shadows.grey,
      ),
      child: Padding(
        padding: REdgeInsets.all(AppSpacing.lg),
        child: Row(
          children: [
            AppButton.primary(
              onTap: () => context.pop(),
              layout: const AppButtonLayout(shape: AppButtonShape.circle),
              child: AppButtonChild.icon(
                IconSource.icon(FontAwesomeIcons.arrowLeft),
                size: 16,
              ),
            ),
            AppSpacing.md.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.dashboardLiveMap,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.s16w600.copyWith(
                      color: context.onSurface,
                    ),
                  ),
                  AppSpacing.xs.verticalSpace,
                  Text(
                    AppStrings.dashboardLiveMapSubtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.s12w400.copyWith(
                      color: context.onSurface.withValues(alpha: 0.62),
                    ),
                  ),
                ],
              ),
            ),
            AppSpacing.md.horizontalSpace,
            AppButton.primary(
              onTap: () => context.read<DashboardBloc>().add(
                const DashboardEvent.driverLocationsRequested(),
              ),
              layout: const AppButtonLayout(shape: AppButtonShape.circle),
              child: AppButtonChild.icon(
                IconSource.icon(FontAwesomeIcons.arrowsRotate),
                size: 16,
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: AppDurations.normal).slideY(begin: -0.06);
  }
}
