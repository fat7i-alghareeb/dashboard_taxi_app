import 'package:dashboardtaxi/common/imports/imports.dart';

/// A premium, multi-phase animated logo for the unified splash screen.
///
/// Enhanced with blur clearing, shadow pulsing, and cinematic expansion.
class PremiumSplashLogo extends StatelessWidget {
  const PremiumSplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    // Increased size for more visual impact as requested.
    final logoSize = 300.sp;

    return Stack(
      alignment: Alignment.center,
      children: [
        // Layer 1: Shadow Pulse (Heartbeat background)
        Assets.images.oranjeLogo
            .image(
              width: logoSize * 1.1,
              height: logoSize * 1.1,
              fit: BoxFit.contain,
              color: context.primary.withValues(alpha: 0.2),
            )
            .animate(onPlay: (controller) => controller.repeat())
            .scale(
              begin: const Offset(1, 1),
              end: const Offset(1.2, 1.2),
              duration: 2000.ms,
              curve: Curves.easeInOut,
            )
            .fadeOut(begin: 0.2, duration: 2000.ms)
            .blur(begin: const Offset(10, 10), end: const Offset(20, 20)),

        // Layer 2: Main Logo with Multi-Phase Animation
        Assets.images.oranjeLogo
            .image(width: logoSize, height: logoSize, fit: BoxFit.contain)
            .animate()
            // Phase 1: Blur Reveal (Entrance)
            .blur(
              begin: const Offset(15, 15),
              end: const Offset(0, 0),
              duration: 800.ms,
              curve: Curves.easeOutCubic,
            )
            .fadeIn(duration: 600.ms)
            // Phase 2: Engagement (Heartbeat & Light Sweep)
            .animate(onPlay: (controller) => controller.repeat(reverse: true))
            .shimmer(
              delay: 800.ms,
              duration: 1500.ms,
              color: context.primary.withValues(alpha: 0.3),
            )
            .scale(
              begin: const Offset(1, 1),
              end: const Offset(1.04, 1.04),
              duration: 1000.ms,
              curve: Curves.easeInOut,
            )
            // Phase 3: Expansion Reveal (Transition)
            // This animation starts when the global splash delay hits its end.
            .animate()
            .scale(
              delay: 2600.ms,
              begin: const Offset(1, 1),
              end: const Offset(20, 20),
              duration: 400.ms,
              curve: Curves.easeInExpo,
            )
            .fadeOut(delay: 2600.ms, duration: 300.ms, curve: Curves.easeOut),
      ],
    );
  }
}
