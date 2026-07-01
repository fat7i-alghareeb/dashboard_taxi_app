import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/refund_requests/presentation/states/refund_requests_cubit.dart';
import 'package:dashboardtaxi/features/refund_requests/presentation/ui/widgets/refund_requests_body.dart';

class RefundRequestsScreen extends StatelessWidget {
  const RefundRequestsScreen({super.key});

  static const String pagePath = '/refund_requests';
  static const String pageName = 'RefundRequestsScreen';

  @override
  Widget build(BuildContext context) {
    return AppScaffold.body(
      child: BlocProvider(
        create: (_) => getIt<RefundRequestsCubit>()..loadRequests(),
        child: const RefundRequestsBody(),
      ),
    );
  }
}
