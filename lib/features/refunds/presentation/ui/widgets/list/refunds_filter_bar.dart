import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/refunds/presentation/states/refunds_cubit.dart';

class RefundsFilterBar extends StatelessWidget {
  const RefundsFilterBar({
    super.key,
    required this.searchController,
    required this.state,
    required this.onSearchChanged,
    required this.onStatusChanged,
    required this.onSourceChanged,
  });

  final TextEditingController searchController;
  final RefundsState state;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<RefundStatusFilter> onStatusChanged;
  final ValueChanged<RefundSourceFilter> onSourceChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: searchController,
          textInputAction: TextInputAction.search,
          onChanged: onSearchChanged,
          decoration: InputDecoration(
            hintText: AppStrings.refundsSearchHint,
            prefixIcon: Padding(
              padding: REdgeInsets.all(AppSpacing.md),
              child: FaIcon(
                FontAwesomeIcons.magnifyingGlass,
                size: 15.r,
                color: context.onSurface.withValues(alpha: 0.54),
              ),
            ),
            isDense: true,
            filled: true,
            fillColor: context.surfaceContainer,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadii.lg.r),
            ),
          ),
        ),
        AppSpacing.md.verticalSpace,
        AppFilterChipWrap(
          children: RefundStatusFilter.values
              .map(
                (filter) => AppFilterChipItem(
                  label: _statusLabel(filter),
                  selected: filter == state.statusFilter,
                  onSelected: () => onStatusChanged(filter),
                ),
              )
              .toList(),
        ),
        AppSpacing.sm.verticalSpace,
        AppFilterChipWrap(
          children: RefundSourceFilter.values
              .map(
                (filter) => AppFilterChipItem(
                  label: _sourceLabel(filter),
                  selected: filter == state.sourceFilter,
                  onSelected: () => onSourceChanged(filter),
                ),
              )
              .toList(),
        ),
      ],
    ).animate().fadeIn(duration: 240.ms).slideY(begin: 0.04, end: 0);
  }

  String _statusLabel(RefundStatusFilter filter) {
    return switch (filter) {
      RefundStatusFilter.all => AppStrings.refundsFilterAll,
      RefundStatusFilter.failed => AppStrings.refundsFilterFailed,
      RefundStatusFilter.pending => AppStrings.refundsFilterPending,
      RefundStatusFilter.succeeded => AppStrings.refundsFilterSucceeded,
      RefundStatusFilter.requiresAction =>
        AppStrings.refundsFilterRequiresAction,
    };
  }

  String _sourceLabel(RefundSourceFilter filter) {
    return switch (filter) {
      RefundSourceFilter.all => AppStrings.refundsFilterAllSources,
      RefundSourceFilter.cancellation => AppStrings.refundsFilterCancellation,
      RefundSourceFilter.manualIncident =>
        AppStrings.refundsFilterManualIncident,
      RefundSourceFilter.compensation => AppStrings.refundsFilterCompensation,
    };
  }
}
