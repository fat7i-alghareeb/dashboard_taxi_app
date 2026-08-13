import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/core/constants/app_urls.dart';
import 'package:dashboardtaxi/features/root/presentation/ui/screens/policy_web_view_screen.dart';

/// The terms of service, loaded from the public website.
class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  static const String pagePath = '/terms-and-conditions';
  static const String pageName = 'TermsAndConditionsScreen';

  @override
  Widget build(BuildContext context) {
    return PolicyWebViewScreen(
      title: AppStrings.termsTitle,
      url: AppUrls.termsAndConditions,
    );
  }
}
