import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:dashboardtaxi/core/error/global_error_handler.dart';
import 'package:dashboardtaxi/core/network/api_endpoints.dart';
import 'package:dashboardtaxi/features/refund_requests/data/models/refund_issue_model.dart';
import 'package:dashboardtaxi/features/refund_requests/data/models/refund_issues_page_model.dart';
import 'package:dashboardtaxi/features/refund_requests/data/models/refund_issues_query_model.dart';
import 'package:dashboardtaxi/features/refund_requests/data/models/review_refund_issue_request_model.dart';
import 'package:dashboardtaxi/utils/helpers/colored_print.dart';

@lazySingleton
class RefundRequestsRemoteDataSource {
  const RefundRequestsRemoteDataSource(this._dio);

  final Dio _dio;

  Future<RefundIssuesPageModel> getRefundIssues(RefundIssuesQueryModel query) {
    return rethrowAsAppException(() async {
      printY('[RefundRequestsRemoteDataSource] getRefundIssues');
      final response = await _dio.get<dynamic>(
        ApiEndpoints.refundIssues,
        queryParameters: query.toQueryParameters(),
      );
      return RefundIssuesPageModel.fromJson(_readMap(response.data));
    });
  }

  Future<RefundIssueModel> reviewRefundIssue({
    required String refundIssueId,
    required ReviewRefundIssueRequestModel request,
  }) {
    return rethrowAsAppException(() async {
      printY(
        '[RefundRequestsRemoteDataSource] reviewRefundIssue issue=$refundIssueId',
      );
      final response = await _dio.post<dynamic>(
        ApiEndpoints.reviewRefundIssue(refundIssueId),
        data: request.toJson(),
      );
      return RefundIssueModel.fromJson(_readMap(response.data));
    });
  }

  Map<String, dynamic> _readMap(dynamic data) {
    if (data is Map<String, dynamic>) return data;
    return const <String, dynamic>{};
  }
}
