import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/refund_requests/presentation/ui/screens/refund_requests_screen.dart';
import 'package:dashboardtaxi/features/refunds/domain/entities/refund_entity.dart';
import 'package:dashboardtaxi/features/refunds/presentation/states/refunds_cubit.dart';
import 'package:dashboardtaxi/features/refunds/presentation/ui/widgets/list/refunds_filter_bar.dart';
import 'package:dashboardtaxi/features/refunds/presentation/ui/widgets/list/refunds_list_section.dart';

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
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: REdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.lg,
                0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppButton.grey(
                    onTap: () =>
                        context.pushNamed(RefundRequestsScreen.pageName),
                    child: AppButtonChild.labelIcon(
                      label: AppStrings.refundRequestsButton,
                      icon: IconSource.builder(
                        (_) => FaIcon(FontAwesomeIcons.inbox, size: 15.r),
                      ),
                    ),
                  ),
                  AppSpacing.lg.verticalSpace,
                  RefundsFilterBar(
                    searchController: _searchController,
                    state: state,
                    onSearchChanged: cubit.setSearch,
                    onStatusChanged: cubit.setStatusFilter,
                    onSourceChanged: cubit.setSourceFilter,
                  ),
                ],
              ),
            ),
            Expanded(
              child: StatusBuilder<List<RefundEntity>>(
                state: state.listState,
                loading: () => SingleChildScrollView(
                  padding: REdgeInsets.all(AppSpacing.lg),
                  child: const AppListShimmer(),
                ),
                isEmpty: (_) => state.filteredRefunds.isEmpty,
                empty: () => EmptyStateWidget(
                  text: AppStrings.refundsEmpty,
                  onRefresh: cubit.loadRefunds,
                ),
                onError: cubit.loadRefunds,
                onRefresh: cubit.loadRefunds,
                success: (_) => SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: REdgeInsets.all(AppSpacing.lg),
                  child: RefundsListSection(
                    refunds: state.filteredRefunds,
                    hasMore: state.hasMore,
                    isLoadingMore: state.isLoadingMore,
                    onLoadMore: cubit.loadMoreRefunds,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
