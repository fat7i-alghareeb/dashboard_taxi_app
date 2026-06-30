import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/refunds/presentation/states/refunds_cubit.dart';
import 'package:dashboardtaxi/features/refunds/presentation/ui/widgets/list/refunds_body.dart';

class RefundsScreen extends StatelessWidget {
  const RefundsScreen({super.key});

  static const String pagePath = '/refunds';
  static const String pageName = 'RefundsScreen';

  @override
  Widget build(BuildContext context) {
    return AppScaffold.body(
      child: BlocProvider(
        create: (_) => getIt<RefundsCubit>()..loadRefunds(),
        child: const RefundsBody(),
      ),
    );
  }
}
