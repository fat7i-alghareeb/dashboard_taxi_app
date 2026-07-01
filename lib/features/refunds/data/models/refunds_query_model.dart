class RefundsQueryModel {
  const RefundsQueryModel({
    this.page = 1,
    this.pageSize = 20,
    this.status,
    this.sourceType,
  });

  final int page;
  final int pageSize;
  final String? status;
  final String? sourceType;

  Map<String, dynamic> toQueryParameters() {
    return {
      'page': page,
      'pageSize': pageSize,
      if (status?.isNotEmpty == true) 'status': status,
      if (sourceType?.isNotEmpty == true) 'sourceType': sourceType,
    };
  }
}
