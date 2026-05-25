import 'package:dashboardtaxi/common/imports/imports.dart';

class DashboardLiveMapLoadingWidget extends StatelessWidget {
  const DashboardLiveMapLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ColoredBox(
            color: context.surface,
            child: const AppShimmer(child: SizedBox.expand()),
          ),
        ),
        Positioned(
          top: AppSpacing.xxl.h,
          left: AppSpacing.xl.w,
          right: AppSpacing.xl.w,
          child: AppShimmer.box(width: double.infinity, height: 96),
        ),
        Positioned(
          bottom: AppSpacing.xxl.h,
          left: AppSpacing.xl.w,
          right: AppSpacing.xl.w,
          child: AppShimmer.box(width: double.infinity, height: 132),
        ),
      ],
    );
  }
}
