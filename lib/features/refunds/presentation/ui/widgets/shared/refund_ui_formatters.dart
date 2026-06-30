import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/refunds/domain/entities/refund_entity.dart';

class RefundUiFormatters {
  const RefundUiFormatters._();

  static String amount(double amount, String currency) {
    final code = currency.trim().isEmpty ? AppStrings.refundsCurrencyUnknown : currency.toUpperCase();
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

  static String statusLabel(RefundEntity refund) {
    final status = refund.status.toLowerCase();
    if (status == 'requested') return AppStrings.refundsStatusRequested;
    if (status == 'pending') return AppStrings.refundsStatusPending;
    if (status == 'succeeded') return AppStrings.refundsStatusSucceeded;
    if (status == 'failed') return AppStrings.refundsStatusFailed;
    if (status == 'retrying') return AppStrings.refundsStatusRetrying;
    if (status == 'requiresadminaction') {
      return AppStrings.refundsStatusRequiresAction;
    }
    if (status == 'permanentlyfailed') {
      return AppStrings.refundsStatusPermanentlyFailed;
    }
    if (status == 'cancelled') return AppStrings.refundsStatusCancelled;
    return refund.status;
  }

  static String sourceLabel(String sourceType) {
    final source = sourceType.toLowerCase();
    if (source == 'passengercancellation') {
      return AppStrings.refundsSourcePassengerCancellation;
    }
    if (source == 'admincancellation') {
      return AppStrings.refundsSourceAdminCancellation;
    }
    if (source == 'drivercancellation') {
      return AppStrings.refundsSourceDriverCancellation;
    }
    if (source == 'airportwaitcancellation') {
      return AppStrings.refundsSourceAirportWaitCancellation;
    }
    if (source == 'compensationclaim') {
      return AppStrings.refundsSourceCompensationClaim;
    }
    if (source == 'manualincidentrefund') {
      return AppStrings.refundsSourceManualIncidentRefund;
    }
    if (source == 'adminretry') return AppStrings.refundsSourceAdminRetry;
    return sourceType;
  }
}
