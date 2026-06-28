import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/customers/domain/entities/customer_filter_args.dart';
import 'package:dashboardtaxi/features/customers/presentation/ui/widgets/customer_picker_sheet.dart';

import '../../../domain/entities/customer_incident_entity.dart';
import '../../../domain/entities/incident_type.dart';
import '../../states/customer_incidents_cubit.dart';
import 'incident_detail_screen.dart';
import 'incident_ui.dart';

class CustomerIncidentsScreen extends StatelessWidget {
  const CustomerIncidentsScreen({super.key, this.customerFilter});

  /// Optional customer to pre-filter the incidents by (passed via route `extra`).
  final CustomerFilterArgs? customerFilter;

  static const String pagePath = '/customer_incidents';
  static const String pageName = 'CustomerIncidentsScreen';

  @override
  Widget build(BuildContext context) {
    final filter = customerFilter;
    return AppScaffold.body(
      child: BlocProvider(
        create: (_) {
          final cubit = getIt<CustomerIncidentsCubit>();
          if (filter != null) {
            cubit.setCustomer(filter.passengerId, filter.name);
          } else {
            cubit.load();
          }
          return cubit;
        },
        child: const _IncidentsBody(),
      ),
    );
  }
}

class _IncidentsBody extends StatelessWidget {
  const _IncidentsBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerIncidentsCubit, CustomerIncidentsState>(
      builder: (context, state) {
        final cubit = context.read<CustomerIncidentsCubit>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Header(onBack: () => Navigator.maybePop(context), onRefresh: cubit.load),
            _Filters(state: state, cubit: cubit),
            Expanded(
              child: StatusBuilder<List<CustomerIncidentEntity>>(
                state: state.listState,
                loading: () => const Center(child: CircularProgressIndicator()),
                success: (items) {
                  if (items.isEmpty) {
                    return Center(
                      child: EmptyStateWidget(text: AppStrings.incidentsNone),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: cubit.load,
                    child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: REdgeInsets.all(AppSpacing.lg),
                      itemCount: items.length,
                      separatorBuilder: (_, _) => AppSpacing.md.verticalSpace,
                      itemBuilder: (context, index) => _IncidentCard(
                        incident: items[index],
                        onTap: () => context.pushNamed(
                          IncidentDetailScreen.pageName,
                          extra: items[index].id,
                        ),
                        onCustomerTap: () => cubit.setCustomer(
                          items[index].passengerId,
                          items[index].passengerName,
                        ),
                      ),
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
            icon: FaIcon(context.chevronStart, size: 18.r, color: context.onSurface),
          ),
          Expanded(
            child: Text(
              AppStrings.customerIncidents,
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

class _Filters extends StatelessWidget {
  const _Filters({required this.state, required this.cubit});

  final CustomerIncidentsState state;
  final CustomerIncidentsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 40.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: REdgeInsets.symmetric(horizontal: AppSpacing.lg),
            children: [
              for (final option in <IncidentType?>[null, ...IncidentType.values])
                Padding(
                  padding: REdgeInsets.only(right: AppSpacing.sm),
                  child: ChoiceChip(
                    label: Text(option?.label ?? AppStrings.incidentFilterAll),
                    selected: state.selectedType == option,
                    onSelected: (_) => cubit.setType(option),
                  ),
                ),
            ],
          ),
        ),
        Padding(
          padding: REdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.sm,
            AppSpacing.lg,
            0,
          ),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: state.hasCustomerFilter
                ? InputChip(
                    avatar: const FaIcon(FontAwesomeIcons.user, size: 12),
                    label: Text(
                      '${AppStrings.incidentCustomer}: ${state.customerName ?? state.customerId}',
                    ),
                    onDeleted: cubit.clearCustomer,
                  )
                : OutlinedButton.icon(
                    onPressed: () async {
                      final customer = await CustomerPickerSheet.show(context);
                      if (customer == null) return;
                      cubit.setCustomer(customer.id, customer.name);
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.magnifyingGlass,
                      size: 14,
                    ),
                    label: Text(AppStrings.customerFilterByCustomer),
                  ),
          ),
        ),
      ],
    );
  }
}

class _IncidentCard extends StatelessWidget {
  const _IncidentCard({
    required this.incident,
    required this.onTap,
    required this.onCustomerTap,
  });

  final CustomerIncidentEntity incident;
  final VoidCallback onTap;
  final VoidCallback onCustomerTap;

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  width: 10.r,
                  height: 10.r,
                  decoration: BoxDecoration(
                    color: IncidentUi.severityColor(incident.severity),
                    shape: BoxShape.circle,
                  ),
                ),
                AppSpacing.sm.horizontalSpace,
                Expanded(
                  child: Text(
                    IncidentUi.typeLabel(incident.type),
                    style: AppTextStyles.s12w500.copyWith(
                      color: context.onSurface.withValues(alpha: 0.60),
                    ),
                  ),
                ),
                _StatusChip(status: incident.status),
              ],
            ),
            AppSpacing.sm.verticalSpace,
            Text(
              incident.title,
              style: AppTextStyles.s16w600.copyWith(color: context.onSurface),
            ),
            if (incident.reason != null && incident.reason!.isNotEmpty) ...[
              AppSpacing.xs.verticalSpace,
              Text(
                incident.reason!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.s14w400.copyWith(
                  color: context.onSurface.withValues(alpha: 0.75),
                ),
              ),
            ],
            if (incident.amountLabel != null) ...[
              AppSpacing.xs.verticalSpace,
              Text(
                incident.amountLabel!,
                style: AppTextStyles.s14w600.copyWith(color: AppColors.success),
              ),
            ],
            AppSpacing.md.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: onCustomerTap,
                    child: Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.user,
                          size: 11.r,
                          color: context.primary,
                        ),
                        AppSpacing.xs.horizontalSpace,
                        Flexible(
                          child: Text(
                            incident.passengerName ?? incident.passengerId,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.s12w500.copyWith(
                              color: context.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (incident.tripReferenceCode != null) ...[
                  AppSpacing.sm.horizontalSpace,
                  Text(
                    '#${incident.tripReferenceCode}',
                    style: AppTextStyles.s12w500.copyWith(
                      color: context.onSurface.withValues(alpha: 0.50),
                    ),
                  ),
                ],
                AppSpacing.sm.horizontalSpace,
                Text(
                  IncidentUi.formatDate(incident.createdAt),
                  style: AppTextStyles.s11w500.copyWith(
                    color: context.onSurface.withValues(alpha: 0.45),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final color = IncidentUi.statusColor(status);
    return Container(
      padding: REdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadii.sm.r),
      ),
      child: Text(
        IncidentUi.statusLabel(status),
        style: AppTextStyles.s11w500.copyWith(color: color),
      ),
    );
  }
}
