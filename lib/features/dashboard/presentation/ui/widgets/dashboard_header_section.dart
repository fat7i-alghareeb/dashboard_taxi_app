import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/control_center/presentation/ui/screens/control_center_screen.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/states/dashboard_bloc.dart';
// TRACKING DISABLED: still referenced by the commented-out live-map quick link.
// ignore: unused_import
import 'package:dashboardtaxi/features/dashboard/presentation/ui/screens/dashboard_live_map_screen.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/screens/dashboard_trips_screen.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_header_quick_link_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_icon_action_widget.dart';

class DashboardHeaderSection extends StatelessWidget {
  const DashboardHeaderSection({super.key});

  String _greetingFor(BuildContext context) {
    final hour = DateTime.now().hour;
    if (hour < 12) return AppStrings.dashboardGreetingMorning;
    if (hour < 18) return AppStrings.dashboardGreetingAfternoon;
    return AppStrings.dashboardGreetingEvening;
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _greetingFor(context),
          style: AppTextStyles.s12w500.copyWith(
            color: context.primary,
            letterSpacing: 0.6,
          ),
        ),
        AppSpacing.xs.verticalSpace,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.dashboardTitle,
                    style: AppTextStyles.s28w700.copyWith(
                      color: context.onSurface,
                      height: 1.15,
                    ),
                  ),
                  AppSpacing.xs.verticalSpace,
                  Row(
                    children: [
                      Container(
                        width: 6.r,
                        height: 6.r,
                        decoration: const BoxDecoration(
                          color: AppColors.success,
                          shape: BoxShape.circle,
                        ),
                      ),
                      AppSpacing.sm.horizontalSpace,
                      Flexible(
                        child: Text(
                          '${AppStrings.dashboardOperationsLiveOverview} · ${now.toYmd()}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.s12w400.copyWith(
                            color: context.onSurface.withValues(alpha: 0.55),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            DashboardIconActionWidget(
              icon: FontAwesomeIcons.arrowsRotate,
              tooltip: AppStrings.dashboardRefresh,
              onTap: () {
                context.read<DashboardBloc>().add(
                  const DashboardEvent.overviewRequested(),
                );
              },
            ),
          ],
        ),
        AppSpacing.lg.verticalSpace,
        Row(
          children: [
            Expanded(
              child: DashboardHeaderQuickLinkWidget(
                icon: FontAwesomeIcons.listCheck,
                label: AppStrings.dashboardOpenTrips,
                onTap: () => context.push(DashboardTripsScreen.pagePath),
              ),
            ),
            // TRACKING DISABLED: with driver positions no longer being reported the
            // live fleet map can only ever render an empty map, so its entry point is
            // hidden. The route itself is still registered — uncomment to restore.
            /*
            AppSpacing.sm.horizontalSpace,
            Expanded(
              child: DashboardHeaderQuickLinkWidget(
                icon: FontAwesomeIcons.mapLocationDot,
                label: AppStrings.dashboardOpenLiveMap,
                onTap: () => context.push(DashboardLiveMapScreen.pagePath),
              ),
            ),
            */
            AppSpacing.sm.horizontalSpace,
            Expanded(
              child: DashboardHeaderQuickLinkWidget(
                icon: FontAwesomeIcons.sliders,
                label: AppStrings.controlCenter,
                onTap: () => context.push(ControlCenterScreen.pagePath),
              ),
            ),
          ],
        ),
      ],
    ).animate().fadeIn(duration: 320.ms).slideY(begin: 0.04, end: 0);
  }
}
