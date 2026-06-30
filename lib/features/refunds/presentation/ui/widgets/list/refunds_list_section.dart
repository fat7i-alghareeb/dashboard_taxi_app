import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/refunds/domain/entities/refund_entity.dart';
import 'package:dashboardtaxi/features/refunds/presentation/ui/widgets/list/refund_card_widget.dart';

class RefundsListSection extends StatelessWidget {
  const RefundsListSection({super.key, required this.refunds});

  final List<RefundEntity> refunds;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: refunds
          .asMap()
          .entries
          .map(
            (entry) => Padding(
              padding: REdgeInsets.only(bottom: AppSpacing.md),
              child: RefundCardWidget(refund: entry.value)
                  .animate(delay: (entry.key * 35).ms)
                  .fadeIn(duration: 220.ms)
                  .slideY(begin: 0.04, end: 0),
            ),
          )
          .toList(),
    );
  }
}
