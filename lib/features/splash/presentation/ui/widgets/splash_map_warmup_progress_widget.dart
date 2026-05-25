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
              left: AppSpacing.lg,
              right: AppSpacing.lg,
              bottom: AppSpacing.lg,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadii.sm.r),
              child: LinearProgressIndicator(
                minHeight: 4.h,
                value: warmupCoordinator.progress,
                backgroundColor: context.surface.withValues(alpha: 0.28),
                valueColor: AlwaysStoppedAnimation<Color>(context.surface),
              ),
            ),
          ),
        ).animate().fadeIn(duration: AppDurations.normal);
      },
    );
  }
}
