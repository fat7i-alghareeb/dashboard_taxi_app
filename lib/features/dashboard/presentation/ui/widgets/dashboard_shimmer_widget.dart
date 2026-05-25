import 'package:dashboardtaxi/common/imports/imports.dart';

class DashboardShimmerWidget extends StatelessWidget {
  const DashboardShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: REdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppShimmer.box(width: 180, height: 28),
          AppSpacing.sm.verticalSpace,
          AppShimmer.box(width: 240, height: 16),
          AppSpacing.xl.verticalSpace,
          Wrap(
            spacing: AppSpacing.md.w,
            runSpacing: AppSpacing.md.h,
            children: List.generate(
              6,
              (index) => AppShimmer.box(width: 156, height: 112),
            ),
          ),
          AppSpacing.xl.verticalSpace,
          AppShimmer.box(width: double.infinity, height: 180),
          AppSpacing.lg.verticalSpace,
          AppShimmer.box(width: double.infinity, height: 180),
        ],
      ),
    );
  }
}
