import 'package:dashboardtaxi/features/refunds/data/models/refund_model.dart';
import 'package:dashboardtaxi/features/refunds/domain/entities/refund_entity.dart';
import 'package:dashboardtaxi/features/refunds/domain/entities/refund_enums.dart';

extension RefundModelMapper on RefundModel {
  RefundEntity get toEntity => RefundEntity(
    refundId: refundId,
    paymentId: paymentId,
    tripId: tripId,
    passengerId: passengerId,
    status: RefundStatus.fromJson(status),
    sourceType: RefundSourceType.fromJson(sourceType),
    amount: amount,
    currency: currency,
    refundPercent: refundPercent,
    isFullRefund: isFullRefund,
    originalPaymentAmount: originalPaymentAmount,
    refundedTotal: refundedTotal,
    remainingRefundableBalance: remainingRefundableBalance,
    paymentMethod: paymentMethod,
    requestedAtUtc: requestedAtUtc,
    lastAttemptAtUtc: lastAttemptAtUtc,
    completedAtUtc: completedAtUtc,
    failedAtUtc: failedAtUtc,
    stripeRefundId: stripeRefundId,
    stripePaymentIntentId: stripePaymentIntentId,
    stripeChargeId: stripeChargeId,
    failureCode: RefundFailureCode.fromJson(failureCode),
    failureReason: failureReason,
    attemptCount: attemptCount,
    canRetry: canRetry,
    retryBlockedReason: RefundFailureCode.fromJson(retryBlockedReason),
    requiresAdminAction: requiresAdminAction,
    tripCancellationId: tripCancellationId,
    customerIncidentId: customerIncidentId,
    tripCompensationClaimId: tripCompensationClaimId,
    requestedByAdminId: requestedByAdminId,
    adminNote: adminNote,
    isManualObligation: isManualObligation,
    cancellationReason: cancellationReason,
  );
}
