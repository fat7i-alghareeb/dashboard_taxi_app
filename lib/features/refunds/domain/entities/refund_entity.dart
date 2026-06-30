class RefundEntity {
  const RefundEntity({
    required this.refundId,
    required this.status,
    required this.sourceType,
    required this.amount,
    required this.currency,
    required this.isFullRefund,
    required this.requiresAdminAction,
    required this.canRetry,
    required this.attemptCount,
    this.paymentId,
    this.tripId,
    this.passengerId,
    this.refundPercent,
    this.originalPaymentAmount,
    this.refundedTotal,
    this.remainingRefundableBalance,
    this.paymentMethod,
    this.requestedAtUtc,
    this.lastAttemptAtUtc,
    this.completedAtUtc,
    this.failedAtUtc,
    this.stripeRefundId,
    this.stripePaymentIntentId,
    this.stripeChargeId,
    this.failureCode,
    this.failureReason,
    this.retryBlockedReason,
    this.tripCancellationId,
    this.customerIncidentId,
    this.tripCompensationClaimId,
    this.requestedByAdminId,
    this.adminNote,
  });

  final String refundId;
  final String? paymentId;
  final String? tripId;
  final String? passengerId;
  final String status;
  final String sourceType;
  final double amount;
  final String currency;
  final double? refundPercent;
  final bool isFullRefund;
  final double? originalPaymentAmount;
  final double? refundedTotal;
  final double? remainingRefundableBalance;
  final String? paymentMethod;
  final DateTime? requestedAtUtc;
  final DateTime? lastAttemptAtUtc;
  final DateTime? completedAtUtc;
  final DateTime? failedAtUtc;
  final String? stripeRefundId;
  final String? stripePaymentIntentId;
  final String? stripeChargeId;
  final String? failureCode;
  final String? failureReason;
  final int attemptCount;
  final bool canRetry;
  final String? retryBlockedReason;
  final bool requiresAdminAction;
  final String? tripCancellationId;
  final String? customerIncidentId;
  final String? tripCompensationClaimId;
  final String? requestedByAdminId;
  final String? adminNote;

  bool get isFailedLike {
    final normalized = status.toLowerCase();
    return normalized.contains('failed') ||
        normalized == 'requiresadminaction';
  }

  bool get isPendingLike {
    final normalized = status.toLowerCase();
    return normalized == 'requested' ||
        normalized == 'pending' ||
        normalized == 'retrying';
  }

  bool get isSucceeded => status.toLowerCase() == 'succeeded';

  bool get isRequiresAction =>
      requiresAdminAction || status.toLowerCase() == 'requiresadminaction';
}
