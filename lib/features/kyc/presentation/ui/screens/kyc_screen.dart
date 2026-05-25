import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/core/services/session/auth_manager.dart';
import 'package:dashboardtaxi/features/kyc/presentation/states/kyc_bloc.dart';
import '../widgets/kyc_body.dart';

class KycScreen extends StatelessWidget {
  const KycScreen({super.key});

  static const String pagePath = '/kyc_screen';
  static const String pageName = 'KycScreen';

  @override
  Widget build(BuildContext context) {
    final driverId = getIt<AuthManager>().currentUser?.driverId ?? '';

    return BlocProvider(
      create: (_) => getIt<KycBloc>()..add(KycEvent.started(driverId)),
      child: AppScaffold.body(
        child: const KycBody(),
      ),
    );
  }
}
