import 'package:dashboardtaxi/common/imports/imports.dart';

class DashboardLiveMapLoadingWidget extends StatelessWidget {
  const DashboardLiveMapLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ColoredBox(
            color: context.onSurface.withValues(alpha: 0.04),
            child: const AppShimmer(child: SizedBox.expand()),
          ),
        ),
        Positioned(
          top: AppSpacing.xxl.h,
          left: AppSpacing.xl.w,
          right: AppSpacing.xl.w,
          child: AppShimmer.box(
            width: double.infinity,
            height: 64,
            borderRadius: AppRadii.lg,
          ),
        ),
        Positioned(
          bottom: AppSpacing.xxl.h,
          left: AppSpacing.xl.w,
          right: AppSpacing.xl.w,
          child: AppShimmer.box(
            width: double.infinity,
            height: 120,
            borderRadius: AppRadii.lg,
          ),
        ),
      ],
    );
  }
}
