import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/common/widgets/show_overlay.dart';
import 'package:dashboardtaxi/features/admin_settings/presentation/ui/widgets/vehicle_type_form_sheet.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/states/dashboard_bloc.dart';

/// System Settings screen — pricing config + vehicle types CRUD.
///
/// Replaces the previous bare-bones admin_settings UI with a focused, fully
/// editable surface. Drivers/users/audit live on the separate
/// DashboardAdminOperationsScreen.
class AdminSettingsScreen extends StatelessWidget {
  const AdminSettingsScreen({super.key});

  static const String pagePath = '/admin_settings';
  static const String pageName = 'AdminSettingsScreen';

  @override
  Widget build(BuildContext context) {
    return AppScaffold.appBar(
      appBarConfig: AppScaffoldAppBarConfig(
        title: AppStrings.drawerAdminSystemSettings,
      ),
      child: BlocProvider(
        create: (_) => getIt<DashboardBloc>()
          ..add(const DashboardEvent.adminOperationsRequested()),
        child: const _AdminSettingsBody(),
      ),
    );
  }
}

class _AdminSettingsBody extends StatelessWidget {
  const _AdminSettingsBody();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardState>(
      listenWhen: (a, b) => a.adminActionState != b.adminActionState,
      listener: (context, state) {
        state.adminActionState.maybeWhen(
          success: (_) {
            showSuccessOverlay(context, AppStrings.done);
            // Refresh the list so created/updated/removed items appear.
            context
                .read<DashboardBloc>()
                .add(const DashboardEvent.adminOperationsRequested());
          },
          failure: (message) => showErrorOverlay(context, message),
          orElse: () {},
        );
      },
      builder: (context, state) {
        return state.adminOperationsState.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const Center(child: MainLoadingProgress()),
          failure: (message) => Center(
            child: FailedStateWidget(
              message: message,
              onRefresh: () async {
                context
                    .read<DashboardBloc>()
                    .add(const DashboardEvent.adminOperationsRequested());
              },
            ),
          ),
          success: (data) => _SettingsContent(
            config: data.config,
            vehicleTypes: data.vehicleTypes,
            isSaving: state.adminActionState.isLoading,
          ),
        );
      },
    );
  }
}

class _SettingsContent extends StatelessWidget {
  const _SettingsContent({
    required this.config,
    required this.vehicleTypes,
    required this.isSaving,
  });

  final DashboardSystemConfigEntity config;
  final List<DashboardVehicleTypeEntity> vehicleTypes;
  final bool isSaving;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context
            .read<DashboardBloc>()
            .add(const DashboardEvent.adminOperationsRequested());
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: REdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _SectionHeader(title: AppStrings.settingsSectionPricing),
            AppSpacing.md.verticalSpace,
            _PricingCard(config: config, isSaving: isSaving),
            AppSpacing.xl.verticalSpace,
            _SectionHeader(
              title: AppStrings.settingsSectionVehicleTypes,
              actionLabel: AppStrings.settingsVehicleTypeAdd,
              onAction: () => VehicleTypeFormSheet.show(context),
            ),
            AppSpacing.md.verticalSpace,
            if (vehicleTypes.isEmpty)
              _EmptyState()
            else
              ...vehicleTypes.map(
                (v) => Padding(
                  padding: REdgeInsets.only(bottom: AppSpacing.sm),
                  child: _VehicleTypeRow(vehicleType: v),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title.toUpperCase(),
            style: AppTextStyles.s11w500.copyWith(
              color: context.onSurface.withValues(alpha: 0.55),
              letterSpacing: 1.2,
            ),
          ),
        ),
        if (actionLabel != null && onAction != null)
          InkWell(
            onTap: onAction,
            borderRadius: BorderRadius.circular(AppRadii.sm.r),
            child: Container(
              padding: REdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: context.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppRadii.sm.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FaIcon(
                    FontAwesomeIcons.plus,
                    size: 11.r,
                    color: context.primary,
                  ),
                  AppSpacing.xs.horizontalSpace,
                  Text(
                    actionLabel!,
                    style: AppTextStyles.s12w500.copyWith(
                      color: context.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _PricingCard extends StatefulWidget {
  const _PricingCard({required this.config, required this.isSaving});
  final DashboardSystemConfigEntity config;
  final bool isSaving;

  @override
  State<_PricingCard> createState() => _PricingCardState();
}

class _PricingCardState extends State<_PricingCard> {
  late final TextEditingController _discount;
  late final TextEditingController _currency;

  @override
  void initState() {
    super.initState();
    _discount = TextEditingController(
      text: widget.config.tripDiscountPercent.toString(),
    );
    _currency = TextEditingController(text: widget.config.currencyCode);
  }

  @override
  void didUpdateWidget(_PricingCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.config.tripDiscountPercent !=
        widget.config.tripDiscountPercent) {
      _discount.text = widget.config.tripDiscountPercent.toString();
    }
    if (oldWidget.config.currencyCode != widget.config.currencyCode) {
      _currency.text = widget.config.currencyCode;
    }
  }

  @override
  void dispose() {
    _discount.dispose();
    _currency.dispose();
    super.dispose();
  }

  void _saveDiscount() {
    final parsed = num.tryParse(_discount.text.trim());
    if (parsed == null) {
      showErrorOverlay(context, AppStrings.invalidNumber);
      return;
    }
    context
        .read<DashboardBloc>()
        .add(DashboardEvent.tripDiscountUpdateRequested(parsed));
  }

  void _saveCurrency() {
    final raw = _currency.text.trim().toUpperCase();
    if (raw.length != 3) {
      showErrorOverlay(context, AppStrings.invalidCurrencyCode);
      return;
    }
    context
        .read<DashboardBloc>()
        .add(DashboardEvent.currencyUpdateRequested(raw));
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(color: context.onSurface.withValues(alpha: 0.08)),
      ),
      child: Padding(
        padding: REdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _InlineField(
              label: AppStrings.settingsDiscountLabel,
              controller: _discount,
              suffix: '%',
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              isSaving: widget.isSaving,
              onSave: _saveDiscount,
            ),
            AppSpacing.md.verticalSpace,
            Container(
              height: 1,
              color: context.onSurface.withValues(alpha: 0.06),
            ),
            AppSpacing.md.verticalSpace,
            _InlineField(
              label: AppStrings.settingsCurrencyLabel,
              controller: _currency,
              keyboardType: TextInputType.text,
              isSaving: widget.isSaving,
              onSave: _saveCurrency,
            ),
          ],
        ),
      ),
    );
  }
}

class _InlineField extends StatelessWidget {
  const _InlineField({
    required this.label,
    required this.controller,
    required this.keyboardType,
    required this.isSaving,
    required this.onSave,
    this.suffix,
  });

  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isSaving;
  final VoidCallback onSave;
  final String? suffix;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.s12w500.copyWith(
                  color: context.onSurface.withValues(alpha: 0.7),
                ),
              ),
              4.verticalSpace,
              TextField(
                controller: controller,
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadii.md.r),
                  ),
                  suffixText: suffix,
                ),
              ),
            ],
          ),
        ),
        AppSpacing.sm.horizontalSpace,
        SizedBox(
          width: 96.w,
          child: AppButton.primary(
            isLoading: isSaving,
            layout: const AppButtonLayout(height: 44),
            onTap: onSave,
            child: AppButtonChild.label(
              AppStrings.settingsSaveLabel,
              textStyle: AppTextStyles.s12w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _VehicleTypeRow extends StatelessWidget {
  const _VehicleTypeRow({required this.vehicleType});
  final DashboardVehicleTypeEntity vehicleType;

  void _confirmDelete(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        content: Text(AppStrings.settingsVehicleTypeDeleteConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(),
            child: Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogCtx).pop();
              context
                  .read<DashboardBloc>()
                  .add(DashboardEvent.vehicleTypeRemovalRequested(
                    vehicleType.id,
                  ));
            },
            child: Text(
              AppStrings.settingsVehicleTypeDelete,
              style: TextStyle(color: context.error),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          VehicleTypeFormSheet.show(context, initial: vehicleType),
      borderRadius: BorderRadius.circular(AppRadii.lg.r),
      child: Container(
        padding: REdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: context.surface,
          borderRadius: BorderRadius.circular(AppRadii.lg.r),
          border: Border.all(color: context.onSurface.withValues(alpha: 0.08)),
        ),
        child: Row(
          children: [
            Container(
              width: 40.r,
              height: 40.r,
              decoration: BoxDecoration(
                color: vehicleType.isActive
                    ? AppColors.success.withValues(alpha: 0.12)
                    : context.onSurface.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: FaIcon(
                  FontAwesomeIcons.car,
                  size: 14.r,
                  color: vehicleType.isActive
                      ? AppColors.success
                      : context.onSurface.withValues(alpha: 0.4),
                ),
              ),
            ),
            AppSpacing.md.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    vehicleType.name,
                    style: AppTextStyles.s14w600.copyWith(
                      color: context.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  2.verticalSpace,
                  Text(
                    '${vehicleType.code} · ${vehicleType.capacity} pax',
                    style: AppTextStyles.s12w400.copyWith(
                      color: context.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: vehicleType.isActive,
              onChanged: (_) {
                context
                    .read<DashboardBloc>()
                    .add(DashboardEvent.vehicleTypeStatusToggleRequested(
                      vehicleType,
                    ));
              },
            ),
            IconButton(
              onPressed: () => _confirmDelete(context),
              icon: FaIcon(
                FontAwesomeIcons.trash,
                size: 14.r,
                color: context.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(color: context.onSurface.withValues(alpha: 0.08)),
      ),
      child: Column(
        children: [
          FaIcon(
            FontAwesomeIcons.car,
            size: 28.r,
            color: context.onSurface.withValues(alpha: 0.3),
          ),
          AppSpacing.md.verticalSpace,
          Text(
            AppStrings.settingsEmptyVehicleTypes,
            style: AppTextStyles.s14w400.copyWith(
              color: context.onSurface.withValues(alpha: 0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
