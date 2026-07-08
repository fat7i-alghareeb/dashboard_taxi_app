import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/states/dashboard_bloc.dart';

/// Read-only per-trip money breakdown (fare + waiting fee, wallet vs card,
/// unpaid remainder, and refunds). Sourced from the admin financials endpoint
/// via [DashboardBloc.tripFinancialsState]. No write/adjust actions exposed.
class DashboardTripFinancialsSectionWidget extends StatelessWidget {
  const DashboardTripFinancialsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      buildWhen: (a, b) => a.tripFinancialsState != b.tripFinancialsState,
      builder: (context, state) {
        return StatusBuilder<DashboardTripFinancialsEntity>(
          state: state.tripFinancialsState,
          loading: () => AppShimmer.box(
            width: double.infinity,
            height: 140,
          ),
          success: (financials) => _FinancialsCard(financials: financials),
        );
      },
    );
  }
}

class _FinancialsCard extends StatelessWidget {
  const _FinancialsCard({required this.financials});

  final DashboardTripFinancialsEntity financials;

  @override
  Widget build(BuildContext context) {
    final currency = financials.currencyCode;
    final rows = <Widget>[
      _AmountRow(
        label: AppStrings.receiptTripFare,
        amount: financials.fareAmount,
        currencyCode: currency,
      ),
      if (financials.waitingFeeAmount > 0)
        _AmountRow(
          label: AppStrings.receiptWaitingFee,
          amount: financials.waitingFeeAmount,
          currencyCode: currency,
        ),
      _AmountRow(
        label: AppStrings.dashboardTotalCharged,
        amount: financials.totalCharged,
        currencyCode: currency,
        emphasize: true,
      ),
      if (financials.walletPaidAmount > 0)
        _AmountRow(
          label: AppStrings.receiptWalletPaid,
          amount: financials.walletPaidAmount,
          currencyCode: currency,
        ),
      if (financials.cardPaidAmount > 0)
        _AmountRow(
          label: AppStrings.receiptCardPaid,
          amount: financials.cardPaidAmount,
          currencyCode: currency,
        ),
      if (financials.hasUnpaid)
        _AmountRow(
          label: AppStrings.receiptUnpaid,
          amount: financials.unpaidAmount,
          currencyCode: currency,
          color: context.error,
        ),
      if (financials.hasRefund)
        _AmountRow(
          label: AppStrings.receiptRefunded,
          amount: financials.refundedAmount,
          currencyCode: currency,
          color: context.primary,
          sign: '-',
        ),
    ];

    return Container(
      width: double.infinity,
      padding: REdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: context.onSurface.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(AppRadii.md.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < rows.length; i++) ...[
            if (i > 0) AppSpacing.sm.verticalSpace,
            rows[i],
          ],
        ],
      ),
    );
  }
}

class _AmountRow extends StatelessWidget {
  const _AmountRow({
    required this.label,
    required this.amount,
    required this.currencyCode,
    this.color,
    this.emphasize = false,
    this.sign = '',
  });

  final String label;
  final double amount;
  final String currencyCode;
  final Color? color;
  final bool emphasize;
  final String sign;

  @override
  Widget build(BuildContext context) {
    final labelStyle = emphasize
        ? AppTextStyles.s16w600.copyWith(color: context.onSurface)
        : AppTextStyles.s14w500.copyWith(
            color: context.onSurface.withValues(alpha: 0.7),
          );
    final valueStyle = AppTextStyles.s14w600.copyWith(
      color: color ?? context.onSurface,
    );
    return Row(
      children: [
        Expanded(child: Text(label, style: labelStyle)),
        Text(
          '$sign${amount.toStringAsFixed(2)} $currencyCode',
          style: valueStyle,
        ),
      ],
    );
  }
}
