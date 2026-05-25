import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../models/dashboard_model.dart';

@lazySingleton
class DashboardRemoteDataSource {
  const DashboardRemoteDataSource(this._dio);

  final Dio _dio;

  Future<DashboardModel> getOverview() {
    return rethrowAsAppException(() async {
      printY('[DashboardRemoteDataSource] getOverview');
      final responses = await Future.wait([
        _dio.get<dynamic>(ApiEndpoints.drivers),
        _dio.get<dynamic>(
          ApiEndpoints.adminTrips,
          queryParameters: {'page': 1, 'pageSize': 50},
        ),
        _dio.get<dynamic>(
          ApiEndpoints.auditLogs,
          queryParameters: {'page': 1, 'pageSize': 6},
        ),
        _dio.get<dynamic>(ApiEndpoints.vehicleTypes),
      ]);

      printG('[DashboardRemoteDataSource] getOverview success');
      return DashboardModel(
        drivers: _asList(
          responses[0].data,
        ).map((e) => DashboardDriverModel.fromJson(e)).toList(),
        trips: _asList(
          responses[1].data,
        ).map((e) => DashboardTripModel.fromJson(e)).toList(),
        auditLogs: _asList(
          responses[2].data,
        ).map((e) => DashboardAuditLogModel.fromJson(e)).toList(),
        vehicleTypes: _asList(
          responses[3].data,
        ).map((e) => DashboardVehicleTypeModel.fromJson(e)).toList(),
      );
    });
  }

  Future<List<DashboardDriverDocumentModel>> getDriverDocuments(
    String driverId,
  ) {
    return rethrowAsAppException(() async {
      printY('[DashboardRemoteDataSource] getDriverDocuments driver=$driverId');
      final response = await _dio.get<dynamic>(
        ApiEndpoints.driverDocuments(driverId),
      );

      return _asList(
        response.data,
      ).map((e) => DashboardDriverDocumentModel.fromJson(e)).toList();
    });
  }

  Future<List<DashboardDriverLocationModel>> getDriverLocations() {
    return rethrowAsAppException(() async {
      printY('[DashboardRemoteDataSource] getDriverLocations');
      final response = await _dio.get<dynamic>(ApiEndpoints.driversStatus);

      return _asList(
        response.data,
      ).map((e) => DashboardDriverLocationModel.fromJson(e)).toList();
    });
  }

  Future<List<DashboardTripModel>> getAdminTrips({
    int page = 1,
    int pageSize = 100,
    String? status,
  }) {
    return rethrowAsAppException(() async {
      printY(
        '[DashboardRemoteDataSource] getAdminTrips page=$page pageSize=$pageSize status=$status',
      );
      final response = await _dio.get<dynamic>(
        ApiEndpoints.adminTrips,
        queryParameters: {
          'page': page,
          'pageSize': pageSize,
          if (status != null && status.isNotEmpty) 'status': status,
        },
      );

      return _asList(
        response.data,
      ).map((e) => DashboardTripModel.fromJson(e)).toList();
    });
  }

  Future<DashboardAdminOperationsModel> getAdminOperations() {
    return rethrowAsAppException(() async {
      printY('[DashboardRemoteDataSource] getAdminOperations');
      final responses = await Future.wait([
        _dio.get<dynamic>(ApiEndpoints.drivers),
        _dio.get<dynamic>(ApiEndpoints.vehicleTypes),
        _dio.get<dynamic>(
          ApiEndpoints.users,
          queryParameters: {'page': 1, 'pageSize': 50},
        ),
        _dio.get<dynamic>(
          ApiEndpoints.auditLogs,
          queryParameters: {'page': 1, 'pageSize': 50},
        ),
        _dio.get<dynamic>(ApiEndpoints.tripDiscount),
        _dio.get<dynamic>(ApiEndpoints.currency),
        _dio.get<dynamic>(ApiEndpoints.clientConfig),
      ]);

      return DashboardAdminOperationsModel(
        drivers: _asList(
          responses[0].data,
        ).map((e) => DashboardDriverModel.fromJson(e)).toList(),
        vehicleTypes: _asList(
          responses[1].data,
        ).map((e) => DashboardVehicleTypeModel.fromJson(e)).toList(),
        users: _asList(
          responses[2].data,
        ).map((e) => DashboardUserModel.fromJson(e)).toList(),
        auditLogs: _asList(
          responses[3].data,
        ).map((e) => DashboardAuditLogModel.fromJson(e)).toList(),
        config: DashboardSystemConfigModel.fromPayloads(
          discount: _asMap(responses[4].data),
          currency: _asMap(responses[5].data),
          client: _asMap(responses[6].data),
        ),
      );
    });
  }

  Future<void> suspendDriver(String driverId) {
    return rethrowAsAppException(() async {
      printY('[DashboardRemoteDataSource] suspendDriver driver=$driverId');
      await _dio.post<dynamic>(ApiEndpoints.suspendDriver(driverId));
    });
  }

  Future<void> assignDriverVehicleType({
    required String driverId,
    required String vehicleTypeId,
  }) {
    return rethrowAsAppException(() async {
      printY(
        '[DashboardRemoteDataSource] assignDriverVehicleType driver=$driverId vehicleType=$vehicleTypeId',
      );
      await _dio.post<dynamic>(
        ApiEndpoints.assignDriverVehicleType(driverId),
        data: vehicleTypeId,
      );
    });
  }

  Future<void> updateVehicleType(DashboardVehicleTypeModel vehicleType) {
    return rethrowAsAppException(() async {
      printY(
        '[DashboardRemoteDataSource] updateVehicleType id=${vehicleType.id} active=${vehicleType.isActive}',
      );
      await _dio.put<dynamic>(
        ApiEndpoints.vehicleType(vehicleType.id),
        data: {
          'ratePerKm': vehicleType.ratePerKm,
          'ratePerMin': vehicleType.ratePerMin,
          'minFare': vehicleType.minFare,
          'isActive': vehicleType.isActive,
          'sortOrder': vehicleType.sortOrder,
        },
      );
    });
  }

  Future<void> removeVehicleType(String vehicleTypeId) {
    return rethrowAsAppException(() async {
      printY(
        '[DashboardRemoteDataSource] removeVehicleType vehicleType=$vehicleTypeId',
      );
      await _dio.delete<dynamic>(ApiEndpoints.vehicleType(vehicleTypeId));
    });
  }

  Future<void> updateTripDiscount(num discountPercent) {
    return rethrowAsAppException(() async {
      printY(
        '[DashboardRemoteDataSource] updateTripDiscount discount=$discountPercent',
      );
      await _dio.put<dynamic>(
        ApiEndpoints.tripDiscount,
        data: {'discountPercent': discountPercent},
      );
    });
  }

  Future<void> updateCurrency(String currencyCode) {
    return rethrowAsAppException(() async {
      printY(
        '[DashboardRemoteDataSource] updateCurrency currency=$currencyCode',
      );
      await _dio.put<dynamic>(
        ApiEndpoints.currency,
        data: {'currencyCode': currencyCode},
      );
    });
  }

  Future<DashboardTripDetailsModel> getTripDetails(String tripId) {
    return rethrowAsAppException(() async {
      printY('[DashboardRemoteDataSource] getTripDetails trip=$tripId');
      final response = await _dio.get<dynamic>(
        ApiEndpoints.adminTripDetails(tripId),
      );
      final data = response.data;
      if (data is Map<String, dynamic>) {
        return DashboardTripDetailsModel.fromJson(data);
      }
      return const DashboardTripDetailsModel(
        id: '',
        referenceCode: '',
        passengerName: '',
        passengerPhone: '',
        driverName: null,
        driverPhone: null,
        vehicleTypeName: '',
        status: '',
        fare: 0,
        currencyCode: 'EUR',
        createdAt: null,
        scheduledAt: null,
        assignedAt: null,
        arrivedAt: null,
        startedAt: null,
        completedAt: null,
        stops: [],
      );
    });
  }

  Future<void> reviewDriverDocument({
    required String driverId,
    required String documentId,
    required bool approved,
    String? notes,
  }) {
    return rethrowAsAppException(() async {
      printY(
        '[DashboardRemoteDataSource] reviewDriverDocument driver=$driverId document=$documentId approved=$approved',
      );
      await _dio.put<dynamic>(
        ApiEndpoints.reviewDriverDocument(driverId, documentId),
        data: {'approved': approved, 'notes': notes},
      );
    });
  }

  Future<void> approveDriver(String driverId) {
    return rethrowAsAppException(() async {
      printY('[DashboardRemoteDataSource] approveDriver driver=$driverId');
      await _dio.post<dynamic>(ApiEndpoints.approveDriver(driverId));
    });
  }

  Future<void> assignDriverToTrip({
    required String tripId,
    required String driverId,
  }) {
    return rethrowAsAppException(() async {
      printY(
        '[DashboardRemoteDataSource] assignDriverToTrip trip=$tripId driver=$driverId',
      );
      await _dio.post<dynamic>(ApiEndpoints.assignTrip(tripId), data: driverId);
    });
  }

  List<Map<String, dynamic>> _asList(dynamic payload) {
    final List<dynamic> rawList = switch (payload) {
      final List<dynamic> list => list,
      {'data': final List<dynamic> data} => data,
      {'items': final List<dynamic> items} => items,
      _ => const <dynamic>[],
    };

    return rawList.whereType<Map<String, dynamic>>().toList();
  }

  Map<String, dynamic> _asMap(dynamic payload) {
    if (payload is Map<String, dynamic>) return payload;
    return const <String, dynamic>{};
  }
}
