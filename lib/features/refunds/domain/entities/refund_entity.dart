import 'package:dashboardtaxi/features/refunds/domain/entities/refund_enums.dart';

class RefundEntity {
  const RefundEntity({
    required this.status,
    required this.sourceType,
    required this.amount,
    required this.currency,
    required this.isFullRefund,
    required this.requiresAdminAction,
    required this.canRetry,
    required this.attemptCount,
    this.paymentId,
    this.refundId,
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
    this.failureCode = RefundFailureCode.unknown,
    this.failureReason,
    this.retryBlockedReason = RefundFailureCode.unknown,
    this.tripCancellationId,
    this.customerIncidentId,
    this.tripCompensationClaimId,
    this.requestedByAdminId,
    this.adminNote,
    this.isManualObligation = false,
    this.cancellationReason,
  });

  final String? refundId;
  final String? paymentId;
  final String? tripId;
  final String? passengerId;
  final RefundStatus status;
  final RefundSourceType sourceType;
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
  final RefundFailureCode failureCode;
  final String? failureReason;
  final int attemptCount;
  final bool canRetry;
  final RefundFailureCode retryBlockedReason;
  final bool requiresAdminAction;
  final String? tripCancellationId;
  final String? customerIncidentId;
  final String? tripCompensationClaimId;
  final String? requestedByAdminId;
  final String? adminNote;
  final bool isManualObligation;
  final String? cancellationReason;

  String get stableReferenceId =>
      refundId ?? tripCancellationId ?? paymentId ?? tripId ?? '';

  bool get hasDetailReference =>
      (refundId?.isNotEmpty ?? false) ||
      (tripCancellationId?.isNotEmpty ?? false);

  bool get canRetrySafely =>
      !isManualObligation && (refundId?.isNotEmpty ?? false) && canRetry;

  bool get isFailedLike => status.isFailedLike;

  bool get isPendingLike => status.isPendingLike;

  bool get isSucceeded => status.isSucceeded;

  bool get isRequiresAction =>
      requiresAdminAction || status == RefundStatus.requiresAdminAction;
}
