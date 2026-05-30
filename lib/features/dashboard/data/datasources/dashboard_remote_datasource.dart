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
        auditLogs: const [],
        vehicleTypes: _asList(
          responses[2].data,
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

  Future<DashboardAdminProfileModel?> getAdminProfile() {
    return rethrowAsAppException(() async {
      printY('[DashboardRemoteDataSource] getAdminProfile');
      final response = await _dio.get<dynamic>(
        ApiEndpoints.currentAdminProfile,
      );
      final payload = _asNullableMap(response.data);
      printC(
        '[DashboardRemoteDataSource] admin profile loaded='
        '${payload != null}',
      );
      return payload == null
          ? null
          : DashboardAdminProfileModel.fromJson(payload);
    });
  }

  Future<DashboardSystemConfigModel> getAdminConfig() {
    return rethrowAsAppException(() async {
      printY('[DashboardRemoteDataSource] getAdminConfig');
      final responses = await Future.wait([
        _dio.get<dynamic>(ApiEndpoints.tripDiscount),
        _dio.get<dynamic>(ApiEndpoints.currency),
        _dio.get<dynamic>(ApiEndpoints.clientConfig),
      ]);
      printG('[DashboardRemoteDataSource] getAdminConfig success');
      return DashboardSystemConfigModel.fromPayloads(
        discount: _asMap(responses[0].data),
        currency: _asMap(responses[1].data),
        client: _asMap(responses[2].data),
      );
    });
  }

  Future<List<DashboardDriverModel>> getAdminDrivers() {
    return rethrowAsAppException(() async {
      printY('[DashboardRemoteDataSource] getAdminDrivers');
      final response = await _dio.get<dynamic>(ApiEndpoints.drivers);
      final drivers = _asList(response.data)
          .map((e) => DashboardDriverModel.fromJson(e))
          .toList();
      printG(
        '[DashboardRemoteDataSource] getAdminDrivers success '
        'count=${drivers.length}',
      );
      return drivers;
    });
  }

  Future<List<DashboardVehicleTypeModel>> getAdminVehicleTypes() {
    return rethrowAsAppException(() async {
      printY('[DashboardRemoteDataSource] getAdminVehicleTypes');
      final response = await _dio.get<dynamic>(ApiEndpoints.adminVehicleTypes);
      final types = _asList(response.data)
          .map((e) => DashboardVehicleTypeModel.fromJson(e))
          .toList();
      printG(
        '[DashboardRemoteDataSource] getAdminVehicleTypes success '
        'count=${types.length}',
      );
      return types;
    });
  }

  Future<List<DashboardUserModel>> getAdminUsers() {
    return rethrowAsAppException(() async {
      printY('[DashboardRemoteDataSource] getAdminUsers');
      final response = await _dio.get<dynamic>(
        ApiEndpoints.users,
        queryParameters: {'page': 1, 'pageSize': 50},
      );
      final users = _asList(response.data)
          .map((e) => DashboardUserModel.fromJson(e))
          .toList();
      printG(
        '[DashboardRemoteDataSource] getAdminUsers success '
        'count=${users.length}',
      );
      return users;
    });
  }

  Future<List<DashboardAuditLogModel>> getAdminAuditLogs() {
    return rethrowAsAppException(() async {
      printY('[DashboardRemoteDataSource] getAdminAuditLogs');
      final response = await _dio.get<dynamic>(
        ApiEndpoints.auditLogs,
        queryParameters: {'page': 1, 'pageSize': 50},
      );
      final logs = _asList(response.data)
          .map((e) => DashboardAuditLogModel.fromJson(e))
          .toList();
      printG(
        '[DashboardRemoteDataSource] getAdminAuditLogs success '
        'count=${logs.length}',
      );
      return logs;
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

  Future<void> createVehicleType({
    required String code,
    required String name,
    required int capacity,
    required num ratePerKm,
    required num ratePerMin,
    required num minFare,
    required int sortOrder,
  }) {
    return rethrowAsAppException(() async {
      printY(
        '[DashboardRemoteDataSource] createVehicleType code=$code name=$name',
      );
      // Backend requires names in every supported locale — repeat `name`
      // across all of them so the form can stay single-field on the UI.
      await _dio.post<dynamic>(
        ApiEndpoints.vehicleTypes,
        data: {
          'code': code,
          'nameEn': name,
          'nameAr': name,
          'nameNl': name,
          'nameDe': name,
          'namePl': name,
          'nameUk': name,
          'nameFr': name,
          'nameEs': name,
          'nameRo': name,
          'capacity': capacity,
          'ratePerKm': ratePerKm,
          'ratePerMin': ratePerMin,
          'minFare': minFare,
          'sortOrder': sortOrder,
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

  Map<String, dynamic>? _asNullableMap(dynamic payload) {
    if (payload is Map<String, dynamic>) return payload;
    return null;
  }
}
