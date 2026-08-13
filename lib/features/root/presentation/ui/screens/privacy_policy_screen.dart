import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/core/constants/app_urls.dart';
import 'package:dashboardtaxi/features/root/presentation/ui/screens/policy_web_view_screen.dart';

/// The privacy policy, loaded from the public website.
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  static const String pagePath = '/privacy-policy';
  static const String pageName = 'PrivacyPolicyScreen';

  @override
  Widget build(BuildContext context) {
    return PolicyWebViewScreen(
      title: AppStrings.privacyPolicyTitle,
      url: AppUrls.privacyPolicy,
    );
  }
}
