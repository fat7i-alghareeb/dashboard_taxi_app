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
        children: [
          for (int i = 0; i < 3; i++) ...[
            DecoratedBox(
              decoration: BoxDecoration(
                color: context.surface,
                borderRadius: BorderRadius.circular(AppRadii.lg.r),
                border: Border.all(
                  color: context.onSurface.withValues(alpha: 0.08),
                ),
              ),
              child: Padding(
                padding: REdgeInsets.all(AppSpacing.lg),
                child: Padding(
                  padding: REdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.md,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: AppShimmer.box(
                              width: 80,
                              height: 14,
                              borderRadius: AppRadii.sm,
                            ),
                          ),
                          AppSpacing.sm.horizontalSpace,
                          AppShimmer.box(
                            width: 50,
                            height: 14,
                            borderRadius: AppRadii.sm,
                          ),
                        ],
                      ),
                      AppSpacing.xs.verticalSpace,
                      AppShimmer.box(
                        width: 220,
                        height: 12,
                        borderRadius: AppRadii.sm,
                      ),
                      AppSpacing.xs.verticalSpace,
                      AppShimmer.box(
                        width: 170,
                        height: 12,
                        borderRadius: AppRadii.sm,
                      ),
                      AppSpacing.sm.verticalSpace,
                      Row(
                        children: [
                          AppShimmer.box(
                            width: 60,
                            height: 20,
                            borderRadius: AppRadii.xl,
                          ),
                          const Spacer(),
                          AppShimmer.box(
                            width: 12,
                            height: 12,
                            borderRadius: AppRadii.sm,
                          ),
                        ],
                      ),
                      AppSpacing.md.verticalSpace,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (int j = 0; j < 5; j++)
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 1.5.r,
                                          color: j == 0
                                              ? Colors.transparent
                                              : context.onSurface.withValues(
                                                  alpha: 0.08,
                                                ),
                                        ),
                                      ),
                                      AppShimmer.circle(size: 10),
                                      Expanded(
                                        child: Container(
                                          height: 1.5.r,
                                          color: j == 4
                                              ? Colors.transparent
                                              : context.onSurface.withValues(
                                                  alpha: 0.08,
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  AppSpacing.xs.verticalSpace,
                                  AppShimmer.box(
                                    width: 32,
                                    height: 10,
                                    borderRadius: AppRadii.xs,
                                  ),
                                  AppSpacing.xs.verticalSpace,
                                  AppShimmer.box(
                                    width: 24,
                                    height: 10,
                                    borderRadius: AppRadii.xs,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (i != 2) AppSpacing.sm.verticalSpace,
          ],
        ],
      ),
    );
  }
}
