import 'package:dashboardtaxi/common/imports/imports.dart';

import '../widgets/premium_splash_logo.dart';
import '../widgets/splash_map_warmup_progress_widget.dart';
import '../widgets/splash_map_warmup_widget.dart';

/// Unified cinematic splash screen.
///
/// Designed to provide a seamless transition from the native splash screen
/// by matching its background color and logo positioning, then performing
/// a premium expansion animation as the app bootstraps.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const String pagePath = '/splash_screen';
  static const String pageName = 'SplashScreen';

  @override
  Widget build(BuildContext context) {
    return AppScaffold.body(
      scaffoldConfig: AppScaffoldConfig(
        backgroundColor: context.primary,
        safeArea: [],
      ),
      child: const Stack(
        fit: StackFit.expand,
        children: [
          SplashMapWarmupWidget(),
          Center(child: PremiumSplashLogo()),
          SplashMapWarmupProgressWidget(),
        ],
      ),
    );
  }
}
