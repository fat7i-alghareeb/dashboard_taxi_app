import 'package:dashboardtaxi/common/imports/imports.dart';

class TripLoadingShimmerWidget extends StatelessWidget {
  const TripLoadingShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadii.lg.r),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.surface.withValues(alpha: 0.86),
          borderRadius: BorderRadius.circular(AppRadii.lg.r),
        ),
        child: Padding(
          padding: REdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppShimmer.box(width: 140, height: 20),
              AppSpacing.md.verticalSpace,
              AppShimmer.box(width: double.infinity, height: 88),
              AppSpacing.md.verticalSpace,
              AppShimmer.box(width: double.infinity, height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
