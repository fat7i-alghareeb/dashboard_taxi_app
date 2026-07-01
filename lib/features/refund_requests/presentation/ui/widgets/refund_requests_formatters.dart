import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/refund_requests/domain/entities/refund_issue_enums.dart';

class RefundRequestsFormatters {
  const RefundRequestsFormatters._();

  static String statusLabel(RefundIssueReviewStatus status) => status.title();

  static String amount(double? amount, String? currency) {
    if (amount == null) return AppStrings.refundsNotAvailable;
    final code = currency?.trim().isEmpty ?? true
        ? AppStrings.refundsCurrencyUnknown
        : currency!.toUpperCase();
    return '$code ${amount.toStringAsFixed(2)}';
  }

  static String date(DateTime value) => value.toSmartDateTime();
}
