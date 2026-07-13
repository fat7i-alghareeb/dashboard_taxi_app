import 'package:dashboardtaxi/common/imports/imports.dart';

import '../../../states/compensation_cubit.dart';

class CompensationFilterBar extends StatelessWidget {
  const CompensationFilterBar({
    super.key,
    required this.searchController,
    required this.statusFilter,
    required this.onSearchChanged,
    required this.onStatusChanged,
  });

  final TextEditingController searchController;
  final CompensationStatusFilter statusFilter;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<CompensationStatusFilter> onStatusChanged;

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
            hintText: AppStrings.compensationSearchHint,
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
          children: CompensationStatusFilter.values
              .map(
                (filter) => AppFilterChipItem(
                  label: _label(filter),
                  selected: filter == statusFilter,
                  onSelected: () => onStatusChanged(filter),
                ),
              )
              .toList(),
        ),
      ],
    ).animate().fadeIn(duration: 240.ms).slideY(begin: 0.04, end: 0);
  }

  String _label(CompensationStatusFilter filter) {
    return switch (filter) {
      CompensationStatusFilter.all => AppStrings.compensationFilterAll,
      CompensationStatusFilter.pending => AppStrings.compensationFilterPending,
      CompensationStatusFilter.approved =>
        AppStrings.compensationFilterApproved,
      CompensationStatusFilter.rejected =>
        AppStrings.compensationFilterRejected,
    };
  }
}
