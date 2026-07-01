import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/refunds/domain/entities/refund_entity.dart';
import 'package:dashboardtaxi/features/refunds/presentation/ui/widgets/list/refund_card_widget.dart';

class RefundsListSection extends StatelessWidget {
  const RefundsListSection({
    super.key,
    required this.refunds,
    required this.hasMore,
    required this.isLoadingMore,
    required this.onLoadMore,
  });

  final List<RefundEntity> refunds;
  final bool hasMore;
  final bool isLoadingMore;
  final VoidCallback onLoadMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final entry in refunds.asMap().entries)
          Padding(
            padding: REdgeInsets.only(bottom: AppSpacing.md),
            child: RefundCardWidget(refund: entry.value)
                .animate(delay: (entry.key * 35).ms)
                .fadeIn(duration: 220.ms)
                .slideY(begin: 0.04, end: 0),
          ),
        if (hasMore)
          Padding(
            padding: REdgeInsets.only(top: AppSpacing.sm),
            child: AppButton.primaryGradient(
              onTap: onLoadMore,
              isLoading: isLoadingMore,
              child: AppButtonChild.labelIcon(
                label: AppStrings.refundsLoadMore,
                icon: IconSource.builder(
                  (_) => FaIcon(FontAwesomeIcons.chevronDown, size: 14.r),
                ),
              ),
            ),
          ).animate().fadeIn(duration: 220.ms).slideY(begin: 0.04, end: 0),
      ],
    );
  }
}
