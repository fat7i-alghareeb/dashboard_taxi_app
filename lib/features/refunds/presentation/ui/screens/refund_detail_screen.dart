import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/refunds/presentation/states/refunds_cubit.dart';
import 'package:dashboardtaxi/features/refunds/presentation/ui/widgets/detail/refund_detail_body.dart';

class RefundDetailScreenArgs {
  const RefundDetailScreenArgs({required this.refundId});

  final String refundId;
}

class RefundDetailScreen extends StatelessWidget {
  const RefundDetailScreen({super.key, required this.args});

  final RefundDetailScreenArgs args;

  static const String pagePath = '/refund_detail';
  static const String pageName = 'RefundDetailScreen';

  @override
  Widget build(BuildContext context) {
    return AppScaffold.body(
      child: BlocProvider(
        create: (_) => getIt<RefundsCubit>()..loadRefundDetail(args.refundId),
        child: RefundDetailBody(refundId: args.refundId),
      ),
    );
  }
}
