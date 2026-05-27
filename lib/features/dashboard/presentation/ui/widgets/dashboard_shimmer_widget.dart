import 'package:dashboardtaxi/common/imports/imports.dart';

class DashboardShimmerWidget extends StatelessWidget {
  const DashboardShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: REdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppShimmer.box(width: 96, height: 14, borderRadius: AppRadii.sm),
          AppSpacing.sm.verticalSpace,
          AppShimmer.box(width: 240, height: 30, borderRadius: AppRadii.sm),
          AppSpacing.sm.verticalSpace,
          AppShimmer.box(width: 180, height: 14, borderRadius: AppRadii.sm),
          AppSpacing.lg.verticalSpace,
          Row(
            children: [
              Expanded(
                child: AppShimmer.box(height: 56, borderRadius: AppRadii.lg),
              ),
              AppSpacing.sm.horizontalSpace,
              Expanded(
                child: AppShimmer.box(height: 56, borderRadius: AppRadii.lg),
              ),
              AppSpacing.sm.horizontalSpace,
              Expanded(
                child: AppShimmer.box(height: 56, borderRadius: AppRadii.lg),
              ),
            ],
          ),
          AppSpacing.xxl.verticalSpace,
          AppShimmer.box(width: 80, height: 12, borderRadius: AppRadii.sm),
          AppSpacing.md.verticalSpace,
          LayoutBuilder(
            builder: (context, constraints) {
              const spacing = AppSpacing.md;
              final tile = (constraints.maxWidth - spacing.w) / 2;
              return Wrap(
                spacing: spacing.w,
                runSpacing: spacing.h,
                children: List.generate(
                  6,
                  (_) => SizedBox(
                    width: tile,
                    child: AppShimmer.box(
                      height: 120,
                      borderRadius: AppRadii.lg,
                    ),
                  ),
                ),
              );
            },
          ),
          AppSpacing.xxl.verticalSpace,
          AppShimmer.box(width: 160, height: 18, borderRadius: AppRadii.sm),
          AppSpacing.md.verticalSpace,
          AppShimmer.box(
            width: double.infinity,
            height: 160,
            borderRadius: AppRadii.lg,
          ),
          AppSpacing.xl.verticalSpace,
          AppShimmer.box(width: 160, height: 18, borderRadius: AppRadii.sm),
          AppSpacing.md.verticalSpace,
          AppShimmer.box(
            width: double.infinity,
            height: 200,
            borderRadius: AppRadii.lg,
          ),
        ],
      ),
    );
  }
}
