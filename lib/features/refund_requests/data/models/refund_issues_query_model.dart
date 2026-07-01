class RefundIssuesQueryModel {
  const RefundIssuesQueryModel({
    this.page = 1,
    this.pageSize = 20,
    this.reviewStatus,
    this.requestType,
  });

  final int page;
  final int pageSize;
  final String? reviewStatus;
  final String? requestType;

  Map<String, dynamic> toQueryParameters() {
    return {
      'page': page,
      'pageSize': pageSize,
      if (reviewStatus?.isNotEmpty == true) 'reviewStatus': reviewStatus,
      if (requestType?.isNotEmpty == true) 'requestType': requestType,
    };
  }
}
