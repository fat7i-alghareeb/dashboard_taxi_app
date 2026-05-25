import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/states/dashboard_bloc.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/screens/dashboard_admin_operations_screen.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/screens/dashboard_live_map_screen.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/screens/dashboard_trips_screen.dart';

class DashboardHeaderSection extends StatelessWidget {
  const DashboardHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.dashboardTitle,
                style: AppTextStyles.s24w700.copyWith(color: context.onSurface),
              ),
              AppSpacing.xs.verticalSpace,
              Text(
                AppStrings.dashboardSubtitle,
                style: AppTextStyles.s14w400.copyWith(
                  color: context.onSurface.withValues(alpha: 0.62),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            AppButton.primary(
              onTap: () => context.push(DashboardAdminOperationsScreen.pagePath),
              layout: const AppButtonLayout(shape: AppButtonShape.circle),
              child: AppButtonChild.icon(
                IconSource.icon(FontAwesomeIcons.gears),
                size: 18,
              ),
            ),
            AppSpacing.sm.horizontalSpace,
            AppButton.primary(
              onTap: () => context.push(DashboardTripsScreen.pagePath),
              layout: const AppButtonLayout(shape: AppButtonShape.circle),
              child: AppButtonChild.icon(
                IconSource.icon(FontAwesomeIcons.listCheck),
                size: 18,
              ),
            ),
            AppSpacing.sm.horizontalSpace,
            AppButton.primary(
              onTap: () => context.push(DashboardLiveMapScreen.pagePath),
              layout: const AppButtonLayout(shape: AppButtonShape.circle),
              child: AppButtonChild.icon(
                IconSource.icon(FontAwesomeIcons.mapLocationDot),
                size: 18,
              ),
            ),
            AppSpacing.sm.horizontalSpace,
            AppButton.primary(
              onTap: () {
                context.read<DashboardBloc>().add(
                  const DashboardEvent.overviewRequested(),
                );
              },
              layout: const AppButtonLayout(shape: AppButtonShape.circle),
              child: AppButtonChild.icon(
                IconSource.icon(FontAwesomeIcons.arrowsRotate),
                size: 18,
              ),
            ),
          ],
        ),
      ],
    ).animate().fadeIn(duration: AppDurations.normal).slideY(begin: 0.05);
  }
}
