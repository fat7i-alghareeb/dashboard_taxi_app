import 'package:dashboardtaxi/common/imports/imports.dart';

class DashboardDocumentsShimmerWidget extends StatelessWidget {
  const DashboardDocumentsShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(
        3,
        (index) => Padding(
          padding: REdgeInsets.only(bottom: AppSpacing.md),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: context.surface,
              borderRadius: BorderRadius.circular(AppRadii.sm.r),
              border: Border.all(
                color: context.onSurface.withValues(alpha: 0.08),
              ),
            ),
            child: Padding(
              padding: REdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      AppShimmer.box(
                        width: 64.w,
                        height: 64.h,
                        borderRadius: AppRadii.sm,
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
                              width: 60,
                              height: 16,
                              borderRadius: AppRadii.sm,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.md.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: AppShimmer.box(
                          height: 40.h,
                          borderRadius: AppRadii.sm,
                        ),
                      ),
                      AppSpacing.sm.horizontalSpace,
                      Expanded(
                        child: AppShimmer.box(
                          height: 40.h,
                          borderRadius: AppRadii.lg,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
