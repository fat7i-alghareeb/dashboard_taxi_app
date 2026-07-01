import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/refund_requests/presentation/ui/screens/refund_requests_screen.dart';
import 'package:dashboardtaxi/features/refunds/domain/entities/refund_entity.dart';
import 'package:dashboardtaxi/features/refunds/presentation/states/refunds_cubit.dart';
import 'package:dashboardtaxi/features/refunds/presentation/ui/widgets/list/refunds_filter_bar.dart';
import 'package:dashboardtaxi/features/refunds/presentation/ui/widgets/list/refunds_header_section.dart';
import 'package:dashboardtaxi/features/refunds/presentation/ui/widgets/list/refunds_list_section.dart';
import 'package:dashboardtaxi/features/refunds/presentation/ui/widgets/list/refunds_shimmer_widget.dart';

class RefundsBody extends StatefulWidget {
  const RefundsBody({super.key});

  @override
  State<RefundsBody> createState() => _RefundsBodyState();
}

class _RefundsBodyState extends State<RefundsBody> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RefundsCubit, RefundsState>(
      builder: (context, state) {
        final cubit = context.read<RefundsCubit>();
        return RefreshIndicator(
          onRefresh: cubit.loadRefunds,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: REdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.lg,
            ),
            children: [
              RefundsHeaderSection(
                onRefresh: cubit.loadRefunds,
                onOpenCustomerRequests: () =>
                    context.pushNamed(RefundRequestsScreen.pageName),
              ),
              AppSpacing.lg.verticalSpace,
              RefundsFilterBar(
                searchController: _searchController,
                state: state,
                onSearchChanged: cubit.setSearch,
                onStatusChanged: cubit.setStatusFilter,
                onSourceChanged: cubit.setSourceFilter,
              ),
              AppSpacing.lg.verticalSpace,
              StatusBuilder<List<RefundEntity>>(
                state: state.listState,
                loading: () => const RefundsShimmerWidget(),
                isEmpty: (_) => state.filteredRefunds.isEmpty,
                empty: () => EmptyStateWidget(text: AppStrings.refundsEmpty),
                onError: cubit.loadRefunds,
                success: (_) => RefundsListSection(
                  refunds: state.filteredRefunds,
                  hasMore: state.hasMore,
                  isLoadingMore: state.isLoadingMore,
                  onLoadMore: cubit.loadMoreRefunds,
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
