import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/refunds/domain/entities/refund_entity.dart';
import 'package:dashboardtaxi/features/refunds/domain/entities/refund_enums.dart';

class RefundUiFormatters {
  const RefundUiFormatters._();

  static String amount(double amount, String currency) {
    final code = currency.trim().isEmpty
        ? AppStrings.refundsCurrencyUnknown
        : currency.toUpperCase();
    return '$code ${amount.toStringAsFixed(2)}';
  }

  static String optionalAmount(double? amount, String currency) {
    if (amount == null) return AppStrings.refundsNotAvailable;
    return RefundUiFormatters.amount(amount, currency);
  }

  static String date(DateTime? value) {
    if (value == null) return AppStrings.refundsNotAvailable;
    return value.toSmartDateTime();
  }

  static String statusLabel(RefundEntity refund) => refund.status.title();

  static String sourceLabel(RefundSourceType sourceType) => sourceType.title();

  static String failureLabel(RefundFailureCode code, {String? fallback}) {
    if (code == RefundFailureCode.unknown && fallback == null) {
      return AppStrings.refundsNotAvailable;
    }
    return code.title(fallback: fallback);
  }
}
