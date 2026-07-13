import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/common/widgets/show_overlay.dart';

import '../../../../domain/entities/compensation_claim_entity.dart';
import '../../../states/compensation_cubit.dart';
import 'compensation_claims_list_section.dart';
import 'compensation_filter_bar.dart';
import 'compensation_shimmer_widget.dart';

class CompensationBody extends StatefulWidget {
  const CompensationBody({super.key});

  @override
  State<CompensationBody> createState() => _CompensationBodyState();
}

class _CompensationBodyState extends State<CompensationBody> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompensationCubit, CompensationState>(
      listenWhen: (prev, curr) => prev.reviewState != curr.reviewState,
      listener: (context, state) {
        state.reviewState.maybeWhen(
          orElse: () {},
          loading: () => showLoadingOverlay(context, AppStrings.uploading),
          success: (_) {
            clearAllOverlays();
            showSuccessOverlay(context, AppStrings.done);
          },
          failure: (msg) {
            clearAllOverlays();
            showErrorOverlay(context, msg);
          },
        );
      },
      builder: (context, state) {
        final cubit = context.read<CompensationCubit>();
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
              child: CompensationFilterBar(
                searchController: _searchController,
                statusFilter: state.statusFilter,
                onSearchChanged: cubit.setSearch,
                onStatusChanged: cubit.setStatusFilter,
              ),
            ),
            Expanded(
              child: StatusBuilder<List<CompensationClaimEntity>>(
                state: state.claimsState,
                loading: () => SingleChildScrollView(
                  padding: REdgeInsets.all(AppSpacing.lg),
                  child: const CompensationShimmerWidget(),
                ),
                isEmpty: (_) => state.filteredClaims.isEmpty,
                empty: () => EmptyStateWidget(
                  text: AppStrings.dashboardNoPendingClaims,
                  onRefresh: cubit.loadClaims,
                ),
                onError: cubit.loadClaims,
                onRefresh: cubit.loadClaims,
                success: (_) => SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: REdgeInsets.all(AppSpacing.lg),
                  child: CompensationClaimsListSection(
                    claims: state.filteredClaims,
                    isReviewing: state.reviewState.isLoading,
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
