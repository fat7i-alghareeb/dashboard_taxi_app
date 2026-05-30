import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/common/widgets/show_overlay.dart';
import 'package:dashboardtaxi/features/control_center/presentation/ui/widgets/control_center_inline_field.dart';
import 'package:dashboardtaxi/features/control_center/presentation/ui/widgets/control_center_section_error.dart';
import 'package:dashboardtaxi/features/control_center/presentation/ui/widgets/control_center_section_shell.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/states/dashboard_bloc.dart';

class ControlCenterPricingSection extends StatelessWidget {
  const ControlCenterPricingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      buildWhen: (prev, curr) =>
          prev.adminConfigState != curr.adminConfigState ||
          prev.configActionState != curr.configActionState,
      builder: (context, state) {
        return ControlCenterSectionShell(
          title: AppStrings.controlCenterPricingTitle,
          subtitle: AppStrings.controlCenterPricingSubtitle,
          icon: FontAwesomeIcons.creditCard,
          isBusy: state.configActionState.isLoading,
          child: state.adminConfigState.when(
            initial: () => const _PricingShimmer(),
            loading: () => const _PricingShimmer(),
            success: (config) => _PricingForm(
              config: config,
              isSaving: state.configActionState.isLoading,
            ),
            failure: (message) => ControlCenterSectionError(
              message: message,
              onRetry: () => context.read<DashboardBloc>().add(
                const DashboardEvent.adminConfigRequested(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PricingForm extends StatefulWidget {
  const _PricingForm({required this.config, required this.isSaving});

  final DashboardSystemConfigEntity config;
  final bool isSaving;

  @override
  State<_PricingForm> createState() => _PricingFormState();
}

class _PricingFormState extends State<_PricingForm> {
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
  void didUpdateWidget(_PricingForm oldWidget) {
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
    final parsed = double.tryParse(_discount.text.trim());
    if (parsed == null || parsed < 0 || parsed > 100) {
      showErrorOverlay(context, AppStrings.invalidDiscountPercent);
      return;
    }
    context.read<DashboardBloc>().add(
      DashboardEvent.tripDiscountUpdateRequested(parsed),
    );
  }

  void _saveCurrency() {
    final raw = _currency.text.trim().toUpperCase();
    if (raw.length != 3) {
      showErrorOverlay(context, AppStrings.invalidCurrencyCode);
      return;
    }
    context.read<DashboardBloc>().add(
      DashboardEvent.currencyUpdateRequested(raw),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ControlCenterInlineField(
          label: AppStrings.settingsDiscountLabel,
          icon: FontAwesomeIcons.tag,
          controller: _discount,
          suffix: '%',
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          isSaving: widget.isSaving,
          onSave: _saveDiscount,
        ),
        _divider(context),
        ControlCenterInlineField(
          label: AppStrings.settingsCurrencyLabel,
          icon: FontAwesomeIcons.coins,
          controller: _currency,
          keyboardType: TextInputType.text,
          isSaving: widget.isSaving,
          onSave: _saveCurrency,
        ),
        _divider(context),
        _CardPaymentsRow(config: widget.config),
      ],
    );
  }

  Widget _divider(BuildContext context) => Padding(
    padding: REdgeInsets.symmetric(vertical: AppSpacing.md),
    child: Container(
      height: 1.h,
      color: context.onSurface.withValues(alpha: 0.06),
    ),
  );
}

class _CardPaymentsRow extends StatelessWidget {
  const _CardPaymentsRow({required this.config});

  final DashboardSystemConfigEntity config;

  @override
  Widget build(BuildContext context) {
    final enabled = config.stripeEnabled;
    final tone = enabled ? AppColors.success : context.onSurface;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            FaIcon(
              FontAwesomeIcons.solidCreditCard,
              size: 16.r,
              color: context.onSurface.withValues(alpha: 0.7),
            ),
            AppSpacing.md.horizontalSpace,
            Expanded(
              child: Text(
                AppStrings.controlCenterCardPayments,
                style: AppTextStyles.s14w500.copyWith(color: context.onSurface),
              ),
            ),
            Container(
              padding: REdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: tone.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppRadii.xs.r),
              ),
              child: Text(
                enabled
                    ? AppStrings.dashboardEnabled
                    : AppStrings.dashboardDisabled,
                style: AppTextStyles.s11w500.copyWith(color: tone),
              ),
            ),
          ],
        ),
        if (config.stripePublishableKey.isNotEmpty) ...[
          AppSpacing.sm.verticalSpace,
          Text(
            '${AppStrings.controlCenterPublishableKey}: ${config.stripePublishableKey}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.s12w400.copyWith(
              color: context.onSurface.withValues(alpha: 0.5),
            ),
          ),
        ],
      ],
    );
  }
}

class _PricingShimmer extends StatelessWidget {
  const _PricingShimmer();

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: Column(
        children: [
          _bar(context),
          AppSpacing.md.verticalSpace,
          _bar(context),
          AppSpacing.md.verticalSpace,
          _bar(context, width: 0.6),
        ],
      ),
    );
  }

  Widget _bar(BuildContext context, {double width = 1}) {
    return FractionallySizedBox(
      alignment: AlignmentDirectional.centerStart,
      widthFactor: width,
      child: Container(
        height: 44.h,
        decoration: BoxDecoration(
          color: context.onSurface.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(AppRadii.md.r),
        ),
      ),
    );
  }
}
