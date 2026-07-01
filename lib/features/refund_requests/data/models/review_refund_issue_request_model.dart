class ReviewRefundIssueRequestModel {
  const ReviewRefundIssueRequestModel({
    required this.reviewStatus,
    this.adminNotes,
  });

  final String reviewStatus;
  final String? adminNotes;

  Map<String, dynamic> toJson() {
    return {
      'reviewStatus': reviewStatus,
      if (adminNotes?.trim().isNotEmpty == true) 'adminNotes': adminNotes,
    };
  }
}
