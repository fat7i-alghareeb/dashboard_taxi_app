import 'package:dashboardtaxi/utils/helpers/app_strings.dart';

enum RefundStatus {
  requested('Requested'),
  pending('Pending'),
  succeeded('Succeeded'),
  failed('Failed'),
  retrying('Retrying'),
  requiresAdminAction('RequiresAdminAction'),
  permanentlyFailed('PermanentlyFailed'),
  cancelled('Cancelled'),
  unknown('');

  const RefundStatus(this.value);

  final String value;

  static RefundStatus fromJson(String? value) {
    final normalized = value?.trim().toLowerCase();
    return RefundStatus.values.firstWhere(
      (status) => status.value.toLowerCase() == normalized,
      orElse: () => RefundStatus.unknown,
    );
  }

  String toJson() => value;

  String title({String? fallback}) {
    return switch (this) {
      RefundStatus.requested => AppStrings.refundsStatusRequested,
      RefundStatus.pending => AppStrings.refundsStatusPending,
      RefundStatus.succeeded => AppStrings.refundsStatusSucceeded,
      RefundStatus.failed => AppStrings.refundsStatusFailed,
      RefundStatus.retrying => AppStrings.refundsStatusRetrying,
      RefundStatus.requiresAdminAction =>
        AppStrings.refundsStatusRequiresAction,
      RefundStatus.permanentlyFailed =>
        AppStrings.refundsStatusPermanentlyFailed,
      RefundStatus.cancelled => AppStrings.refundsStatusCancelled,
      RefundStatus.unknown => fallback ?? AppStrings.refundsNotAvailable,
    };
  }

  bool get isFailedLike =>
      this == RefundStatus.failed ||
      this == RefundStatus.requiresAdminAction ||
      this == RefundStatus.permanentlyFailed;

  bool get isPendingLike =>
      this == RefundStatus.requested ||
      this == RefundStatus.pending ||
      this == RefundStatus.retrying;

  bool get isSucceeded => this == RefundStatus.succeeded;
}

enum RefundSourceType {
  passengerCancellation('PassengerCancellation'),
  adminCancellation('AdminCancellation'),
  driverCancellation('DriverCancellation'),
  airportWaitCancellation('AirportWaitCancellation'),
  compensationClaim('CompensationClaim'),
  manualIncidentRefund('ManualIncidentRefund'),
  adminRetry('AdminRetry'),
  unknown('');

  const RefundSourceType(this.value);

  final String value;

  static RefundSourceType fromJson(String? value) {
    final normalized = value?.trim().toLowerCase();
    return RefundSourceType.values.firstWhere(
      (source) => source.value.toLowerCase() == normalized,
      orElse: () => RefundSourceType.unknown,
    );
  }

  String toJson() => value;

  String title({String? fallback}) {
    return switch (this) {
      RefundSourceType.passengerCancellation =>
        AppStrings.refundsSourcePassengerCancellation,
      RefundSourceType.adminCancellation =>
        AppStrings.refundsSourceAdminCancellation,
      RefundSourceType.driverCancellation =>
        AppStrings.refundsSourceDriverCancellation,
      RefundSourceType.airportWaitCancellation =>
        AppStrings.refundsSourceAirportWaitCancellation,
      RefundSourceType.compensationClaim =>
        AppStrings.refundsSourceCompensationClaim,
      RefundSourceType.manualIncidentRefund =>
        AppStrings.refundsSourceManualIncidentRefund,
      RefundSourceType.adminRetry => AppStrings.refundsSourceAdminRetry,
      RefundSourceType.unknown => fallback ?? AppStrings.refundsNotAvailable,
    };
  }

  bool get isCancellation =>
      this == RefundSourceType.passengerCancellation ||
      this == RefundSourceType.adminCancellation ||
      this == RefundSourceType.driverCancellation ||
      this == RefundSourceType.airportWaitCancellation;
}

enum RefundFailureCode {
  stripeDisabled('Payment.Refund.StripeDisabled'),
  unavailable('Payment.Refund.Unavailable'),
  retryBlocked('Payment.Refund.RetryBlocked'),
  unknown('');

  const RefundFailureCode(this.value);

  final String value;

  static RefundFailureCode fromJson(String? value) {
    final normalized = value?.trim().toLowerCase();
    return RefundFailureCode.values.firstWhere(
      (code) => code.value.toLowerCase() == normalized,
      orElse: () => RefundFailureCode.unknown,
    );
  }

  String toJson() => value;

  String title({String? fallback}) {
    return switch (this) {
      RefundFailureCode.stripeDisabled =>
        AppStrings.refundsFailureStripeDisabled,
      RefundFailureCode.unavailable =>
        AppStrings.refundsFailureRefundUnavailable,
      RefundFailureCode.retryBlocked => AppStrings.refundsFailureRetryBlocked,
      RefundFailureCode.unknown => fallback ?? AppStrings.refundsNotAvailable,
    };
  }
}
