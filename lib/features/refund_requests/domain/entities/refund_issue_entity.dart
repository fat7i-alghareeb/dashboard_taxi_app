import 'package:dashboardtaxi/features/refund_requests/domain/entities/refund_issue_enums.dart';

class RefundIssueEntity {
  const RefundIssueEntity({
    required this.id,
    required this.tripId,
    required this.passengerId,
    required this.requestType,
    required this.customerReason,
    required this.reviewStatus,
    required this.createdAtUtc,
    this.paymentId,
    this.paymentRefundId,
    this.tripCancellationId,
    this.note,
    this.refundStatusSnapshot,
    this.refundAmountSnapshot,
    this.refundCurrencySnapshot,
    this.reviewedByAdminId,
    this.reviewedAtUtc,
    this.adminNotes,
    this.whatsAppOpened = false,
    this.passengerName,
    this.tripReferenceCode,
  });

  final String id;
  final String tripId;
  final String passengerId;
  final String? paymentId;
  final String? paymentRefundId;
  final String? tripCancellationId;
  final RefundIssueRequestType requestType;
  final String customerReason;
  final String? note;
  final String? refundStatusSnapshot;
  final double? refundAmountSnapshot;
  final String? refundCurrencySnapshot;
  final RefundIssueReviewStatus reviewStatus;
  final DateTime createdAtUtc;
  final String? reviewedByAdminId;
  final DateTime? reviewedAtUtc;
  final String? adminNotes;
  final bool whatsAppOpened;
  final String? passengerName;
  final String? tripReferenceCode;

  bool get isOpen => reviewStatus.isOpen;
  bool get isResolved => reviewStatus.isResolved;
  bool get isDismissed => reviewStatus.isDismissed;
}
