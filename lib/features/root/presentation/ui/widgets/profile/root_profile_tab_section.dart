import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/core/domain/extensions/user_role_extensions.dart';
import 'package:dashboardtaxi/core/services/session/auth_manager.dart';
import 'package:dashboardtaxi/features/profile/presentation/ui/screens/profile_screen.dart';

class RootProfileTabSection extends StatelessWidget {
  const RootProfileTabSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isAdmin = getIt<AuthManager>().currentUser.isAdmin;
    return SafeArea(
      bottom: false,
      child: ProfileScreen(isAdmin: isAdmin),
    );
  }
}
