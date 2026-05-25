import 'package:dashboardtaxi/common/imports/imports.dart';
import '../widgets/root_body.dart';
import '../widgets/root_drawer_content.dart';

/// Root screen that hosts the main app screen body.
class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  static const String pagePath = '/root_screen';
  static const String pageName = 'RootScreen';

  @override
  Widget build(BuildContext context) {
    return AppScaffold.appBar(
      appBarConfig: const AppScaffoldAppBarConfig(
        title: 'Dashboard',
        enableDrawer: true,
        showLeading: false, // Don't show leading back button on root screen
      ),
      endDrawer: const RootDrawerContent(),
      child: const RootBody(),
    );
  }
}
