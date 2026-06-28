import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../models/customer_model.dart';

@lazySingleton
class CustomersRemoteDataSource {
  const CustomersRemoteDataSource(this._dio);

  final Dio _dio;

  /// Fetches a page of registered customers (passengers only), optionally
  /// filtered by a free-text [search] over name / phone / email.
  Future<List<CustomerModel>> getCustomers({
    int page = 1,
    int pageSize = 20,
    String? search,
  }) {
    return rethrowAsAppException(() async {
      printY(
        '[CustomersRemoteDataSource] getCustomers page=$page pageSize=$pageSize search=$search',
      );
      final res = await _dio.get<dynamic>(
        ApiEndpoints.users,
        queryParameters: {
          'page': page,
          'pageSize': pageSize,
          'role': 'Passenger',
          if (search != null && search.isNotEmpty) 'search': search,
        },
      );
      final data = res.data;
      final raw = data is List<dynamic> ? data : const <dynamic>[];
      return raw
          .whereType<Map<String, dynamic>>()
          .map(CustomerModel.fromJson)
          .toList();
    });
  }

  Future<void> suspendCustomer({
    required String userId,
    String? reason,
  }) {
    return rethrowAsAppException(() async {
      printY('[CustomersRemoteDataSource] suspend user=$userId');
      await _dio.post<dynamic>(
        ApiEndpoints.suspendUser(userId),
        data: {'reason': reason},
      );
    });
  }

  Future<void> reactivateCustomer({required String userId}) {
    return rethrowAsAppException(() async {
      printY('[CustomersRemoteDataSource] reactivate user=$userId');
      await _dio.delete<dynamic>(ApiEndpoints.suspendUser(userId));
    });
  }
}
