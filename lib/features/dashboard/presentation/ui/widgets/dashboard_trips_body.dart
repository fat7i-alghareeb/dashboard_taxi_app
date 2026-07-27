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
  late final DashboardBloc _bloc;

  @override
  void initState() {
    super.initState();
    // Owned here rather than created inside build()'s BlocProvider so the
    // initial fetch is a mount-time side effect, and so `_bloc` is non-null by
    // construction for the scroll listener.
    _bloc = getIt<DashboardBloc>();
    final filter = widget.customerFilter;
    if (filter != null) {
      _bloc.add(
        DashboardEvent.adminTripsCustomerChanged(
          passengerId: filter.passengerId,
          name: filter.name,
        ),
      );
    } else {
      _bloc.add(const DashboardEvent.adminTripsRequested());
    }
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _searchController.dispose();
    _bloc.close();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 300) {
      final state = _bloc.state;
      if (state.adminTripsHasMore && !state.adminTripsLoadingMore) {
        _bloc.add(const DashboardEvent.adminTripsNextPageRequested());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardBloc>.value(
      value: _bloc,
      child: RefreshIndicator(
        onRefresh: () async {
          _bloc.add(const DashboardEvent.adminTripsRequested());
        },
        // CustomScrollView + slivers so only the visible trip cards are built.
        child: CustomScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: REdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.lg,
              ),
              sliver: SliverMainAxisGroup(
                slivers: [
                  SliverToBoxAdapter(
                    child: _Header(
                      showBackButton: widget.showBackButton,
                      searchController: _searchController,
                      filter: _filter,
                      onFilterChanged: (f) => setState(() => _filter = f),
                    ),
                  ),
                  _TripsSliver(filter: _filter),
                  const SliverToBoxAdapter(child: _LoadMoreFooter()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Static chrome above the list. Deliberately *not* rebuilt by list-state
/// changes — a keystroke or a realtime status patch must not relayout it.
class _Header extends StatelessWidget {
  const _Header({
    required this.showBackButton,
    required this.searchController,
    required this.filter,
    required this.onFilterChanged,
  });

  final bool showBackButton;
  final TextEditingController searchController;
  final DashboardTripFilter filter;
  final ValueChanged<DashboardTripFilter> onFilterChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DashboardTripsHeaderWidget(showBackButton: showBackButton),
        AppSpacing.lg.verticalSpace,
        _SearchField(controller: searchController),
        AppSpacing.md.verticalSpace,
        const _CustomerFilterRow(),
        AppSpacing.lg.verticalSpace,
        DashboardTripFilterPillsWidget(
          selected: filter,
          onChanged: onFilterChanged,
        ),
        AppSpacing.xl.verticalSpace,
      ],
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textInputAction: TextInputAction.search,
      onChanged: (value) => context.read<DashboardBloc>().add(
        DashboardEvent.adminTripsSearchChanged(value),
      ),
      decoration: InputDecoration(
        hintText: AppStrings.dashboardTripSearchHint,
        prefixIcon: const Icon(Icons.search),
        // Listens to the controller so the clear button appears as soon as
        // there is text, instead of waiting for an unrelated rebuild.
        suffixIcon: ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller,
          builder: (context, value, _) {
            if (value.text.isEmpty) return const SizedBox.shrink();
            return IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                controller.clear();
                context.read<DashboardBloc>().add(
                  const DashboardEvent.adminTripsSearchChanged(''),
                );
              },
            );
          },
        ),
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.lg.r),
        ),
      ),
    );
  }
}

class _TripsSliver extends StatelessWidget {
  const _TripsSliver({required this.filter});

  final DashboardTripFilter filter;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      DashboardBloc,
      DashboardState,
      BlocStatus<List<DashboardTripEntity>>
    >(
      selector: (s) => s.adminTripsState,
      builder: (context, status) {
        return status.when(
          initial: () =>
              const SliverToBoxAdapter(child: DashboardTripsShimmerWidget()),
          loading: () =>
              const SliverToBoxAdapter(child: DashboardTripsShimmerWidget()),
          success: (trips) {
            final filtered = trips.where(filter.matches).toList();
            return DashboardTripsListSection(
              trips: filtered,
              hasActiveFilter: filter != DashboardTripFilter.all,
            );
          },
          failure: (message) => SliverToBoxAdapter(
            child: FailedStateWidget(
              message: message,
              onRetrying: () => context.read<DashboardBloc>().add(
                const DashboardEvent.adminTripsRequested(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LoadMoreFooter extends StatelessWidget {
  const _LoadMoreFooter();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<DashboardBloc, DashboardState, bool>(
      selector: (s) => s.adminTripsLoadingMore,
      builder: (context, loadingMore) {
        return Column(
          children: [
            if (loadingMore) ...[
              AppSpacing.lg.verticalSpace,
              const Center(child: CircularProgressIndicator()),
            ],
            AppSpacing.xxl.verticalSpace,
          ],
        );
      },
    );
  }
}

/// Customer (passenger) filter affordance for the records list: opens the
/// shared [CustomerPickerSheet] and shows the active customer as a clearable
/// chip.
class _CustomerFilterRow extends StatelessWidget {
  const _CustomerFilterRow();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<DashboardBloc, DashboardState, (String, String)>(
      selector: (s) => (s.adminTripsPassengerId, s.adminTripsPassengerName),
      builder: (context, filter) {
        final bloc = context.read<DashboardBloc>();
        final (passengerId, passengerName) = filter;

        if (passengerId.isNotEmpty) {
          final name = passengerName.isNotEmpty ? passengerName : passengerId;
          return Align(
            alignment: AlignmentDirectional.centerStart,
            child: InputChip(
              avatar: const FaIcon(FontAwesomeIcons.user, size: 12),
              label: Text('${AppStrings.customerFilterLabel}: $name'),
              onDeleted: () =>
                  bloc.add(const DashboardEvent.adminTripsCustomerChanged()),
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
      },
    );
  }
}
