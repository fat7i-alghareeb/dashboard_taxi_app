import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/refund_requests/domain/entities/refund_issue_entity.dart';
import 'package:dashboardtaxi/features/refund_requests/presentation/states/refund_requests_cubit.dart';
import 'package:dashboardtaxi/features/refund_requests/presentation/ui/widgets/refund_requests_filter_bar.dart';
import 'package:dashboardtaxi/features/refund_requests/presentation/ui/widgets/refund_requests_list_section.dart';
import 'package:dashboardtaxi/features/refund_requests/presentation/ui/widgets/refund_requests_shimmer_widget.dart';

class RefundRequestsBody extends StatefulWidget {
  const RefundRequestsBody({super.key});

  @override
  State<RefundRequestsBody> createState() => _RefundRequestsBodyState();
}

class _RefundRequestsBodyState extends State<RefundRequestsBody> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RefundRequestsCubit, RefundRequestsState>(
      listenWhen: (previous, current) =>
          previous.reviewState != current.reviewState,
      listener: (context, state) {
        state.reviewState.whenOrNull(
          success: (_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(AppStrings.refundRequestsReviewSaved)),
            );
            context.read<RefundRequestsCubit>().clearReviewState();
          },
          failure: (message) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(message)));
            context.read<RefundRequestsCubit>().clearReviewState();
          },
        );
      },
      builder: (context, state) {
        final cubit = context.read<RefundRequestsCubit>();
        return RefreshIndicator(
          onRefresh: cubit.loadRequests,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: REdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.lg,
            ),
            children: [
              AppScreenHeader(
                title: AppStrings.refundRequestsTitle,
                subtitle: AppStrings.refundRequestsSubtitle,
                onRefresh: cubit.loadRequests,
              ),
              AppSpacing.lg.verticalSpace,
              RefundRequestsFilterBar(
                searchController: _searchController,
                selected: state.statusFilter,
                onSearchChanged: cubit.setSearch,
                onChanged: cubit.setStatusFilter,
              ),
              AppSpacing.lg.verticalSpace,
              StatusBuilder<List<RefundIssueEntity>>(
                state: state.listState,
                loading: () => const RefundRequestsShimmerWidget(),
                isEmpty: (_) => state.filteredItems.isEmpty,
                empty: () =>
                    EmptyStateWidget(text: AppStrings.refundRequestsEmpty),
                onError: cubit.loadRequests,
                success: (_) => RefundRequestsListSection(
                  requests: state.filteredItems,
                  hasMore: state.hasMore,
                  isLoadingMore: state.isLoadingMore,
                  isReviewing: state.reviewState.isLoading,
                  onLoadMore: cubit.loadMoreRequests,
                  onReview: (issue, status) =>
                      cubit.reviewRequest(issue: issue, reviewStatus: status),
                ),
              ),
              AppSpacing.xxl.verticalSpace,
            ],
          ),
        );
      },
    );
  }
}
