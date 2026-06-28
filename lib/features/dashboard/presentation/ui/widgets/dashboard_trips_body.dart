import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/customers/domain/entities/customer_filter_args.dart';
import 'package:dashboardtaxi/features/customers/presentation/ui/widgets/customer_picker_sheet.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/states/dashboard_bloc.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_trip_filter.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_trip_filter_pills_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_trips_header_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_trips_list_section.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_trips_shimmer_widget.dart';

class DashboardTripsBody extends StatefulWidget {
  final bool showBackButton;
  final CustomerFilterArgs? customerFilter;

  const DashboardTripsBody({
    super.key,
    this.showBackButton = true,
    this.customerFilter,
  });

  @override
  State<DashboardTripsBody> createState() => _DashboardTripsBodyState();
}

class _DashboardTripsBodyState extends State<DashboardTripsBody> {
  DashboardTripFilter _filter = DashboardTripFilter.all;
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  DashboardBloc? _bloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final bloc = _bloc;
    if (bloc == null || !_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 300) {
      final state = bloc.state;
      if (state.adminTripsHasMore && !state.adminTripsLoadingMore) {
        bloc.add(const DashboardEvent.adminTripsNextPageRequested());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final filter = widget.customerFilter;
        final bloc = getIt<DashboardBloc>();
        if (filter != null) {
          bloc.add(
            DashboardEvent.adminTripsCustomerChanged(
              passengerId: filter.passengerId,
              name: filter.name,
            ),
          );
        } else {
          bloc.add(const DashboardEvent.adminTripsRequested());
        }
        _bloc = bloc;
        return bloc;
      },
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<DashboardBloc>().add(
                const DashboardEvent.adminTripsRequested(),
              );
            },
            child: ListView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: REdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.lg,
              ),
              children: [
                DashboardTripsHeaderWidget(
                  showBackButton: widget.showBackButton,
                ),
                AppSpacing.lg.verticalSpace,
                TextField(
                  controller: _searchController,
                  textInputAction: TextInputAction.search,
                  onChanged: (value) => context.read<DashboardBloc>().add(
                    DashboardEvent.adminTripsSearchChanged(value),
                  ),
                  decoration: InputDecoration(
                    hintText: AppStrings.dashboardTripSearchHint,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isEmpty
                        ? null
                        : IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              context.read<DashboardBloc>().add(
                                const DashboardEvent.adminTripsSearchChanged(''),
                              );
                              setState(() {});
                            },
                          ),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadii.lg.r),
                    ),
                  ),
                ),
                AppSpacing.md.verticalSpace,
                _CustomerFilterRow(state: state),
                AppSpacing.lg.verticalSpace,
                DashboardTripFilterPillsWidget(
                  selected: _filter,
                  onChanged: (f) => setState(() => _filter = f),
                ),
                AppSpacing.xl.verticalSpace,
                StatusBuilder<List<DashboardTripEntity>>(
                  state: state.adminTripsState,
                  loading: () => const DashboardTripsShimmerWidget(),
                  success: (trips) {
                    final filtered = trips
                        .where((t) => _filter.matches(t))
                        .toList();
                    return DashboardTripsListSection(
                      trips: filtered,
                      selectedTripId: state.selectedTripId,
                      hasActiveFilter: _filter != DashboardTripFilter.all,
                    );
                  },
                ),
                if (state.adminTripsLoadingMore) ...[
                  AppSpacing.lg.verticalSpace,
                  const Center(child: CircularProgressIndicator()),
                ],
                AppSpacing.xxl.verticalSpace,
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Customer (passenger) filter affordance for the records list: opens the
/// shared [CustomerPickerSheet] and shows the active customer as a clearable
/// chip.
class _CustomerFilterRow extends StatelessWidget {
  const _CustomerFilterRow({required this.state});

  final DashboardState state;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DashboardBloc>();
    final hasFilter = state.adminTripsPassengerId.isNotEmpty;

    if (hasFilter) {
      final name = state.adminTripsPassengerName.isNotEmpty
          ? state.adminTripsPassengerName
          : state.adminTripsPassengerId;
      return Align(
        alignment: AlignmentDirectional.centerStart,
        child: InputChip(
          avatar: const FaIcon(FontAwesomeIcons.user, size: 12),
          label: Text('${AppStrings.customerFilterLabel}: $name'),
          onDeleted: () => bloc.add(
            const DashboardEvent.adminTripsCustomerChanged(),
          ),
        ),
      );
    }

    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: OutlinedButton.icon(
        onPressed: () async {
          final customer = await CustomerPickerSheet.show(context);
          if (customer == null) return;
          bloc.add(
            DashboardEvent.adminTripsCustomerChanged(
              passengerId: customer.id,
              name: customer.name,
            ),
          );
        },
        icon: const FaIcon(FontAwesomeIcons.magnifyingGlass, size: 14),
        label: Text(AppStrings.customerFilterByCustomer),
      ),
    );
  }
}
