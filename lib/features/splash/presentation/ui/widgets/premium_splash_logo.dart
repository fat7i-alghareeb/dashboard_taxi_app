import 'package:dashboardtaxi/common/imports/imports.dart';

/// Clean, modern splash logo with a single restrained entrance + breath cycle.
///
/// Uses the brand surface (white) as the logo tint so the wordmark reads as a
/// solid mark on the primary background, matching the native splash.
class PremiumSplashLogo extends StatelessWidget {
  const PremiumSplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final logoSize = 180.sp;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Assets.images.oranjeLogo
            .image(
              width: logoSize,
              height: logoSize,
              fit: BoxFit.contain,
              color: context.onSurface,
            )
            .animate()
            .fadeIn(duration: 600.ms, curve: Curves.easeOutCubic)
            .scale(
              begin: const Offset(0.92, 0.92),
              end: const Offset(1, 1),
              duration: 600.ms,
              curve: Curves.easeOutCubic,
            )
            .then()
            .animate(onPlay: (c) => c.repeat(reverse: true))
            .scale(
              begin: const Offset(1, 1),
              end: const Offset(1.03, 1.03),
              duration: 1400.ms,
              curve: Curves.easeInOut,
            ),
        AppSpacing.lg.verticalSpace,
        Text(
              AppStrings.appName,
              style: AppTextStyles.s20w700.copyWith(
                color: context.onSurface,
                letterSpacing: 1.2,
              ),
            )
            .animate()
            .fadeIn(delay: 200.ms, duration: 600.ms)
            .slideY(begin: 0.2, end: 0, duration: 600.ms),
        AppSpacing.xs.verticalSpace,
        Text(
              AppStrings.appTagline.toUpperCase(),
              style: AppTextStyles.s12w500.copyWith(
                color: context.onSurface.withValues(alpha: 0.70),
                letterSpacing: 2.4,
              ),
            )
            .animate()
            .fadeIn(delay: 400.ms, duration: 600.ms),
      ],
    );
  }
}
