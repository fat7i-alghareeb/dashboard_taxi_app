import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../models/customer_incident_model.dart';

@lazySingleton
class CustomerIncidentsRemoteDataSource {
  const CustomerIncidentsRemoteDataSource(this._dio);

  final Dio _dio;

  Future<List<CustomerIncidentModel>> getIncidents({
    String? type,
    String? passengerId,
    String? status,
    String? severity,
  }) {
    return rethrowAsAppException(() async {
      printY(
        '[CustomerIncidentsRemoteDataSource] getIncidents type=$type passenger=$passengerId status=$status severity=$severity',
      );
      final res = await _dio.get<dynamic>(
        ApiEndpoints.customerIncidents,
        queryParameters: {
          if (type != null && type.isNotEmpty) 'type': type,
          if (passengerId != null && passengerId.isNotEmpty)
            'passengerId': passengerId,
          if (status != null && status.isNotEmpty) 'status': status,
          if (severity != null && severity.isNotEmpty) 'severity': severity,
        },
      );
      final data = res.data;
      final raw = data is List<dynamic> ? data : const <dynamic>[];
      return raw
          .whereType<Map<String, dynamic>>()
          .map(CustomerIncidentModel.fromJson)
          .toList();
    });
  }

  Future<CustomerIncidentDetailModel> getDetail(String incidentId) {
    return rethrowAsAppException(() async {
      printY('[CustomerIncidentsRemoteDataSource] getDetail id=$incidentId');
      final res = await _dio.get<dynamic>(
        ApiEndpoints.customerIncidentDetail(incidentId),
      );
      final data = (res.data as Map?)?.cast<String, dynamic>() ??
          const <String, dynamic>{};
      return CustomerIncidentDetailModel.fromJson(data);
    });
  }

  Future<CustomerIncidentModel> changeStatus({
    required String incidentId,
    required String status,
    String? note,
  }) {
    return rethrowAsAppException(() async {
      printY(
        '[CustomerIncidentsRemoteDataSource] changeStatus id=$incidentId status=$status',
      );
      final res = await _dio.post<dynamic>(
        ApiEndpoints.changeIncidentStatus(incidentId),
        data: {'status': status, 'note': note},
      );
      final data = (res.data as Map?)?.cast<String, dynamic>() ??
          const <String, dynamic>{};
      return CustomerIncidentModel.fromJson(data);
    });
  }

  Future<void> contactPassenger({
    required String incidentId,
    required String title,
    required String body,
  }) {
    return rethrowAsAppException(() async {
      printY(
        '[CustomerIncidentsRemoteDataSource] contactPassenger id=$incidentId',
      );
      await _dio.post<dynamic>(
        ApiEndpoints.contactIncidentPassenger(incidentId),
        data: {'title': title, 'body': body},
      );
    });
  }

  Future<CustomerIncidentModel> refund({
    required String incidentId,
    double? amount,
  }) {
    return rethrowAsAppException(() async {
      printY(
        '[CustomerIncidentsRemoteDataSource] refund id=$incidentId amount=$amount',
      );
      final res = await _dio.post<dynamic>(
        ApiEndpoints.refundIncident(incidentId),
        data: {'amount': amount},
      );
      final data = (res.data as Map?)?.cast<String, dynamic>() ??
          const <String, dynamic>{};
      return CustomerIncidentModel.fromJson(data);
    });
  }

  Future<void> suspendPassenger({
    required String userId,
    String? reason,
  }) {
    return rethrowAsAppException(() async {
      printY('[CustomerIncidentsRemoteDataSource] suspend user=$userId');
      await _dio.post<dynamic>(
        ApiEndpoints.suspendUser(userId),
        data: {'reason': reason},
      );
    });
  }

  Future<void> reactivatePassenger({required String userId}) {
    return rethrowAsAppException(() async {
      printY('[CustomerIncidentsRemoteDataSource] reactivate user=$userId');
      await _dio.delete<dynamic>(ApiEndpoints.suspendUser(userId));
    });
  }
}
