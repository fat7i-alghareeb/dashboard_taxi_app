import 'package:dashboardtaxi/features/refund_requests/data/models/refund_issue_model.dart';
import 'package:dashboardtaxi/features/refund_requests/domain/entities/refund_issue_entity.dart';
import 'package:dashboardtaxi/features/refund_requests/domain/entities/refund_issue_enums.dart';

extension RefundIssueModelMapper on RefundIssueModel {
  RefundIssueEntity get toEntity => RefundIssueEntity(
    id: id,
    tripId: tripId,
    passengerId: passengerId,
    paymentId: paymentId,
    paymentRefundId: paymentRefundId,
    tripCancellationId: tripCancellationId,
    requestType: RefundIssueRequestType.fromJson(requestType),
    customerReason: customerReason,
    note: note,
    refundStatusSnapshot: refundStatusSnapshot,
    refundAmountSnapshot: refundAmountSnapshot,
    refundCurrencySnapshot: refundCurrencySnapshot,
    reviewStatus: RefundIssueReviewStatus.fromJson(reviewStatus),
    createdAtUtc: createdAtUtc,
    reviewedByAdminId: reviewedByAdminId,
    reviewedAtUtc: reviewedAtUtc,
    adminNotes: adminNotes,
    whatsAppOpened: whatsAppOpened,
    passengerName: passengerName,
    tripReferenceCode: tripReferenceCode,
  );
}
