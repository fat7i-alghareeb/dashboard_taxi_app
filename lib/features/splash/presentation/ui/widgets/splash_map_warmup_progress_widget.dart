import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/core/services/location/startup_map_warmup_coordinator.dart';

class SplashMapWarmupProgressWidget extends StatelessWidget {
  const SplashMapWarmupProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final warmupCoordinator = getIt<StartupMapWarmupCoordinator>();

    return AnimatedBuilder(
      animation: warmupCoordinator,
      builder: (context, child) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: REdgeInsets.only(
              left: AppSpacing.xxl,
              right: AppSpacing.xxl,
              bottom: AppSpacing.xxl,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadii.xs.r),
                  child: LinearProgressIndicator(
                    minHeight: 2.h,
                    value: warmupCoordinator.progress,
                    backgroundColor: context.onPrimary.withValues(alpha: 0.18),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      context.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ).animate().fadeIn(duration: 400.ms, delay: 600.ms);
      },
    );
  }
}
