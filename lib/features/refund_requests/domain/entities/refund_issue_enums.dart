import 'package:dashboardtaxi/utils/helpers/app_strings.dart';

enum RefundIssueRequestType {
  didNotReceiveRefund('DidNotReceiveRefund'),
  receivedLessThanExpected('ReceivedLessThanExpected'),
  refundTakingTooLong('RefundTakingTooLong'),
  questionAboutRefund('QuestionAboutRefund'),
  knownFailedRefund('KnownFailedRefund'),
  other('Other'),
  unknown('');

  const RefundIssueRequestType(this.value);

  final String value;

  static RefundIssueRequestType fromJson(String? value) {
    final normalized = value?.trim().toLowerCase();
    return RefundIssueRequestType.values.firstWhere(
      (type) => type.value.toLowerCase() == normalized,
      orElse: () => RefundIssueRequestType.unknown,
    );
  }

  String toJson() => value;

  String title({String? fallback}) {
    if (fallback?.trim().isNotEmpty == true) {
      return fallback!.trim();
    }

    return switch (this) {
      RefundIssueRequestType.didNotReceiveRefund =>
        AppStrings.refundRequestsTypeDidNotReceiveRefund,
      RefundIssueRequestType.receivedLessThanExpected =>
        AppStrings.refundRequestsTypeReceivedLessThanExpected,
      RefundIssueRequestType.refundTakingTooLong =>
        AppStrings.refundRequestsTypeRefundTakingTooLong,
      RefundIssueRequestType.questionAboutRefund =>
        AppStrings.refundRequestsTypeQuestionAboutRefund,
      RefundIssueRequestType.knownFailedRefund =>
        AppStrings.refundRequestsTypeKnownFailedRefund,
      RefundIssueRequestType.other => AppStrings.refundRequestsTypeOther,
      RefundIssueRequestType.unknown => AppStrings.refundsNotAvailable,
    };
  }
}

enum RefundIssueReviewStatus {
  open('Open'),
  inReview('InReview'),
  resolved('Resolved'),
  dismissed('Dismissed'),
  unknown('');

  const RefundIssueReviewStatus(this.value);

  final String value;

  static RefundIssueReviewStatus fromJson(String? value) {
    final normalized = value?.trim().toLowerCase();
    return RefundIssueReviewStatus.values.firstWhere(
      (status) => status.value.toLowerCase() == normalized,
      orElse: () => RefundIssueReviewStatus.unknown,
    );
  }

  String toJson() => value;

  String title({String? fallback}) {
    return switch (this) {
      RefundIssueReviewStatus.open => AppStrings.refundRequestsStatusOpen,
      RefundIssueReviewStatus.inReview =>
        AppStrings.refundRequestsStatusInReview,
      RefundIssueReviewStatus.resolved =>
        AppStrings.refundRequestsStatusResolved,
      RefundIssueReviewStatus.dismissed =>
        AppStrings.refundRequestsStatusDismissed,
      RefundIssueReviewStatus.unknown =>
        fallback ?? AppStrings.refundsNotAvailable,
    };
  }

  bool get isOpen => this == RefundIssueReviewStatus.open;
  bool get isInReview => this == RefundIssueReviewStatus.inReview;
  bool get isResolved => this == RefundIssueReviewStatus.resolved;
  bool get isDismissed => this == RefundIssueReviewStatus.dismissed;
}
