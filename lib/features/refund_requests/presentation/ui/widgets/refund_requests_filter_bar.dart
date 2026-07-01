import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/refund_requests/presentation/states/refund_requests_cubit.dart';
import 'package:dashboardtaxi/features/refunds/presentation/ui/widgets/list/refund_filter_chip_item.dart';
import 'package:dashboardtaxi/features/refunds/presentation/ui/widgets/list/refund_filter_chip_wrap.dart';

class RefundRequestsFilterBar extends StatelessWidget {
  const RefundRequestsFilterBar({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final RefundRequestStatusFilter selected;
  final ValueChanged<RefundRequestStatusFilter> onChanged;

  @override
  Widget build(BuildContext context) {
    return RefundFilterChipWrap(
      children: RefundRequestStatusFilter.values
          .map(
            (filter) => RefundFilterChipItem(
              label: _label(filter),
              selected: selected == filter,
              onSelected: () => onChanged(filter),
            ),
          )
          .toList(),
    ).animate().fadeIn(duration: 240.ms).slideY(begin: 0.04, end: 0);
  }

  String _label(RefundRequestStatusFilter filter) {
    return switch (filter) {
      RefundRequestStatusFilter.all => AppStrings.refundsFilterAll,
      RefundRequestStatusFilter.open => AppStrings.refundRequestsStatusOpen,
      RefundRequestStatusFilter.inReview =>
        AppStrings.refundRequestsStatusInReview,
      RefundRequestStatusFilter.resolved =>
        AppStrings.refundRequestsStatusResolved,
      RefundRequestStatusFilter.dismissed =>
        AppStrings.refundRequestsStatusDismissed,
    };
  }
}
