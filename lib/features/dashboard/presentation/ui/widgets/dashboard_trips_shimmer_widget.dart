import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_section_shell_widget.dart';

class DashboardTripsShimmerWidget extends StatelessWidget {
  const DashboardTripsShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardSectionShellWidget(
      title: AppStrings.dashboardAllTrips,
      icon: FontAwesomeIcons.route,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate(5, (i) {
          return Padding(
            padding: REdgeInsets.symmetric(vertical: AppSpacing.sm),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    AppShimmer.circle(size: 8),
                    AppSpacing.xs.verticalSpace,
                    AppShimmer.box(width: 2, height: 16, borderRadius: 1),
                    AppSpacing.xs.verticalSpace,
                    AppShimmer.circle(size: 8),
                  ],
                ),
                AppSpacing.md.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppShimmer.box(
                        width: 120,
                        height: 14,
                        borderRadius: AppRadii.sm,
                      ),
                      AppSpacing.xs.verticalSpace,
                      AppShimmer.box(
                        width: double.infinity,
                        height: 12,
                        borderRadius: AppRadii.sm,
                      ),
                      AppSpacing.xs.verticalSpace,
                      AppShimmer.box(
                        width: 180,
                        height: 12,
                        borderRadius: AppRadii.sm,
                      ),
                      AppSpacing.sm.verticalSpace,
                      AppShimmer.box(
                        width: 70,
                        height: 18,
                        borderRadius: AppRadii.xl,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
