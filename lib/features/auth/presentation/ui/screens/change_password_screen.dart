import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/auth/domain/facade/auth_facade.dart';
import 'package:dashboardtaxi/features/auth/presentation/states/admin_auth_bloc.dart';
import '../widgets/change_password/change_password_body.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  static const String pagePath = '/change_password';
  static const String pageName = 'ChangePasswordScreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AdminAuthBloc(getIt<AuthFacade>()),
      child: const ChangePasswordBody(),
    );
  }
}
