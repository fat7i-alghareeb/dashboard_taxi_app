import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/auth/presentation/states/auth_bloc.dart';
import 'package:dashboardtaxi/features/auth/presentation/ui/widgets/force_password_reset/force_password_reset_body.dart';

class ForcePasswordResetScreen extends StatelessWidget {
  const ForcePasswordResetScreen({super.key});

  static const String pagePath = '/force_password_reset';
  static const String pageName = 'ForcePasswordResetScreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: const ForcePasswordResetBody(),
    );
  }
}
