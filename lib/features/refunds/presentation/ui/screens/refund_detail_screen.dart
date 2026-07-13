import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/refunds/presentation/states/refunds_cubit.dart';
import 'package:dashboardtaxi/features/refunds/presentation/ui/widgets/detail/refund_detail_body.dart';

class RefundDetailScreenArgs {
  const RefundDetailScreenArgs({this.refundId, this.tripCancellationId});

  final String? refundId;
  final String? tripCancellationId;
}

class RefundDetailScreen extends StatelessWidget {
  const RefundDetailScreen({super.key, required this.args});

  final RefundDetailScreenArgs args;

  static const String pagePath = '/refund_detail';
  static const String pageName = 'RefundDetailScreen';

  @override
  Widget build(BuildContext context) {
    return AppScaffold.appBar(
      appBarConfig: AppScaffoldAppBarConfig(
        title: AppStrings.refundsDetailTitle,
        titleAlignment: AppScaffoldTitleAlignment.start,
      ),
      child: BlocProvider(
        create: (_) => getIt<RefundsCubit>()
          ..loadRefundDetail(
            refundId: args.refundId,
            tripCancellationId: args.tripCancellationId,
          ),
        child: RefundDetailBody(args: args),
      ),
    );
  }
}
