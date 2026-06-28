import 'package:dashboardtaxi/common/imports/imports.dart';

import '../../../domain/entities/customer_entity.dart';
import '../../states/customers_cubit.dart';
import 'customer_detail_screen.dart';
import '../widgets/customer_avatar.dart';

class CustomersListScreen extends StatelessWidget {
  const CustomersListScreen({super.key});

  static const String pagePath = '/customers';
  static const String pageName = 'CustomersListScreen';

  @override
  Widget build(BuildContext context) {
    return AppScaffold.body(
      child: BlocProvider(
        create: (_) => getIt<CustomersCubit>()..load(),
        child: const _CustomersBody(),
      ),
    );
  }
}

class _CustomersBody extends StatefulWidget {
  const _CustomersBody();

  @override
  State<_CustomersBody> createState() => _CustomersBodyState();
}

class _CustomersBodyState extends State<_CustomersBody> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

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
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 300) {
      context.read<CustomersCubit>().nextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomersCubit, CustomersState>(
      builder: (context, state) {
        final cubit = context.read<CustomersCubit>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Header(
              onBack: () => Navigator.maybePop(context),
              onRefresh: cubit.load,
            ),
            Padding(
              padding: REdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.sm,
                AppSpacing.lg,
                AppSpacing.sm,
              ),
              child: TextField(
                controller: _searchController,
                textInputAction: TextInputAction.search,
                onChanged: cubit.setSearch,
                decoration: InputDecoration(
                  hintText: AppStrings.customerSearchHint,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isEmpty
                      ? null
                      : IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            cubit.setSearch('');
                            setState(() {});
                          },
                        ),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadii.lg.r),
                  ),
                ),
              ),
            ),
            Expanded(
              child: StatusBuilder<List<CustomerEntity>>(
                state: state.listState,
                loading: () => const Center(child: CircularProgressIndicator()),
                success: (items) {
                  if (items.isEmpty) {
                    return Center(
                      child: EmptyStateWidget(
                        text: AppStrings.customersNone,
                        onRefresh: cubit.load,
                      ),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: cubit.load,
                    child: ListView.separated(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: REdgeInsets.all(AppSpacing.lg),
                      itemCount: items.length + (state.loadingMore ? 1 : 0),
                      separatorBuilder: (_, _) => AppSpacing.md.verticalSpace,
                      itemBuilder: (context, index) {
                        if (index >= items.length) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        final customer = items[index];
                        return _CustomerCard(
                          customer: customer,
                          onTap: () => context.pushNamed(
                            CustomerDetailScreen.pageName,
                            extra: customer,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.onBack, required this.onRefresh});

  final VoidCallback onBack;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.sm,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: FaIcon(
              context.chevronStart,
              size: 18.r,
              color: context.onSurface,
            ),
          ),
          Expanded(
            child: Text(
              AppStrings.customersTitle,
              style: AppTextStyles.s18w600.copyWith(color: context.onSurface),
            ),
          ),
          IconButton(
            onPressed: onRefresh,
            icon: FaIcon(
              FontAwesomeIcons.arrowsRotate,
              size: 18.r,
              color: context.onSurface.withValues(alpha: 0.70),
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomerCard extends StatelessWidget {
  const _CustomerCard({required this.customer, required this.onTap});

  final CustomerEntity customer;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadii.lg.r),
      child: Container(
        padding: REdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: context.surface,
          borderRadius: BorderRadius.circular(AppRadii.lg.r),
          border: Border.all(color: context.onSurface.withValues(alpha: 0.08)),
        ),
        child: Row(
          children: [
            CustomerAvatar(customer: customer, size: 48),
            AppSpacing.md.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          customer.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.s16w600.copyWith(
                            color: context.onSurface,
                          ),
                        ),
                      ),
                      if (!customer.isActive) _SuspendedChip(),
                    ],
                  ),
                  AppSpacing.xs.verticalSpace,
                  Text(
                    customer.hasEmail ? customer.email! : customer.phone,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.s14w400.copyWith(
                      color: context.onSurface.withValues(alpha: 0.70),
                    ),
                  ),
                  if (customer.hasHomeAddress) ...[
                    AppSpacing.xs.verticalSpace,
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.locationDot,
                          size: 11.r,
                          color: context.onSurface.withValues(alpha: 0.45),
                        ),
                        AppSpacing.xs.horizontalSpace,
                        Flexible(
                          child: Text(
                            customer.homeAddressLabel!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.s12w500.copyWith(
                              color: context.onSurface.withValues(alpha: 0.55),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            FaIcon(
              context.chevronEnd,
              size: 14.r,
              color: context.onSurface.withValues(alpha: 0.35),
            ),
          ],
        ),
      ),
    );
  }
}

class _SuspendedChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadii.sm.r),
      ),
      child: Text(
        AppStrings.customerSuspended,
        style: AppTextStyles.s11w500.copyWith(color: AppColors.error),
      ),
    );
  }
}
