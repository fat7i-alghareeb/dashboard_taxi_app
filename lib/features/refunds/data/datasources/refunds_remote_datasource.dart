import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:dashboardtaxi/core/error/global_error_handler.dart';
import 'package:dashboardtaxi/core/network/api_endpoints.dart';
import 'package:dashboardtaxi/features/refunds/data/models/refund_model.dart';
import 'package:dashboardtaxi/features/refunds/data/models/refunds_page_model.dart';
import 'package:dashboardtaxi/features/refunds/data/models/refunds_query_model.dart';
import 'package:dashboardtaxi/utils/helpers/colored_print.dart';

@lazySingleton
class RefundsRemoteDataSource {
  const RefundsRemoteDataSource(this._dio);

  final Dio _dio;

  Future<RefundsPageModel> getRefunds(RefundsQueryModel query) {
    return rethrowAsAppException(() async {
      printY('[RefundsRemoteDataSource] getRefunds');
      final response = await _dio.get<dynamic>(
        ApiEndpoints.refunds,
        queryParameters: query.toQueryParameters(),
      );
      return RefundsPageModel.fromJson(_readMap(response.data));
    });
  }

  Future<RefundModel> getRefundDetail(String refundId) {
    return rethrowAsAppException(() async {
      printY('[RefundsRemoteDataSource] getRefundDetail refund=$refundId');
      final response = await _dio.get<dynamic>(
        ApiEndpoints.refundDetail(refundId),
      );
      return RefundModel.fromJson(_readMap(response.data));
    });
  }

  Future<RefundModel> getCancellationRefundDetail(String tripCancellationId) {
    return rethrowAsAppException(() async {
      printY(
        '[RefundsRemoteDataSource] getCancellationRefundDetail cancellation=$tripCancellationId',
      );
      final response = await _dio.get<dynamic>(
        ApiEndpoints.refundCancellationDetail(tripCancellationId),
      );
      return RefundModel.fromJson(_readMap(response.data));
    });
  }

  Future<RefundModel> retryRefund({required String refundId, String? note}) {
    return rethrowAsAppException(() async {
      printY('[RefundsRemoteDataSource] retryRefund refund=$refundId');
      final response = await _dio.post<dynamic>(
        ApiEndpoints.retryRefund(refundId),
        data: {'note': note},
      );
      return RefundModel.fromJson(_readMap(response.data));
    });
  }

  Map<String, dynamic> _readMap(dynamic data) {
    if (data is Map<String, dynamic>) return data;
    return const <String, dynamic>{};
  }
}
