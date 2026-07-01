import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/refund_requests/domain/entities/refund_issue_entity.dart';
import 'package:dashboardtaxi/features/refund_requests/domain/entities/refund_issue_enums.dart';
import 'package:dashboardtaxi/features/refund_requests/presentation/ui/widgets/refund_request_card_widget.dart';

class RefundRequestsListSection extends StatelessWidget {
  const RefundRequestsListSection({
    super.key,
    required this.requests,
    required this.hasMore,
    required this.isLoadingMore,
    required this.isReviewing,
    required this.onLoadMore,
    required this.onReview,
  });

  final List<RefundIssueEntity> requests;
  final bool hasMore;
  final bool isLoadingMore;
  final bool isReviewing;
  final VoidCallback onLoadMore;
  final void Function(
    RefundIssueEntity issue,
    RefundIssueReviewStatus reviewStatus,
  )
  onReview;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final entry in requests.asMap().entries)
          Padding(
            padding: REdgeInsets.only(bottom: AppSpacing.md),
            child:
                RefundRequestCardWidget(
                      issue: entry.value,
                      isReviewing: isReviewing,
                      onReview: (status) => onReview(entry.value, status),
                    )
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
