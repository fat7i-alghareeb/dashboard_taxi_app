import 'package:dashboardtaxi/features/refund_requests/data/models/refund_issue_model.dart';

class RefundIssuesPageModel {
  const RefundIssuesPageModel({
    required this.items,
    required this.totalCount,
    required this.page,
    required this.pageSize,
  });

  final List<RefundIssueModel> items;
  final int totalCount;
  final int page;
  final int pageSize;

  factory RefundIssuesPageModel.fromJson(Map<String, dynamic> json) {
    final rawItems = json['items'] ?? json['data'];
    final items = rawItems is List<dynamic>
        ? rawItems
              .whereType<Map<String, dynamic>>()
              .map(RefundIssueModel.fromJson)
              .toList()
        : const <RefundIssueModel>[];
    return RefundIssuesPageModel(
      items: items,
      totalCount: _readInt(json, 'totalCount') ?? items.length,
      page: _readInt(json, 'page') ?? 1,
      pageSize: _readInt(json, 'pageSize') ?? items.length,
    );
  }

  static int? _readInt(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }
}
