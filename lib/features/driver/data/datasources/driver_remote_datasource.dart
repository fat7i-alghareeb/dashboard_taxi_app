import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../models/driver_model.dart';

@lazySingleton
class DriverRemoteDataSource {
  const DriverRemoteDataSource(this._dio);

  final Dio _dio;

  Future<List<DriverModel>> getAllDrivers() {
    return rethrowAsAppException(() async {
      printY('[DriverRemoteDataSource] getAllDrivers');
      final response = await _dio.get<dynamic>('/driver');
      final data = response.data;
      final dataList = data['data'] as List<dynamic>;
      return dataList.map((e) => DriverModel.fromJson(e)).toList();
    });
  }

  Future<void> updateStatus(int status) {
    return rethrowAsAppException(() async {
      printY('[DriverRemoteDataSource] updateStatus status=$status');
      await _dio.post<dynamic>('/api/v1/drivers/me/status', data: status);
    });
  }

  /// TRACKING DISABLED: the server endpoint is commented out too, so calling this
  /// would only produce 404s. Kept as a no-op for the (also disabled) REST fallback
  /// in DriverLocationStreamer.
  Future<void> updateLocation(double lat, double lng) {
    return rethrowAsAppException(() async {
      printY('[DriverRemoteDataSource] tracking disabled — skipping $lat,$lng');

      /*
      await _dio.post<dynamic>(
        '/api/v1/drivers/me/location',
        data: {'latitude': lat, 'longitude': lng},
      );
      */
    });
  }

  Future<DriverEarningsModel> getEarnings() {
    return rethrowAsAppException(() async {
      printY('[DriverRemoteDataSource] getEarnings');
      final response = await _dio.get<dynamic>('/api/v1/drivers/me/earnings');
      final data = response.data;
      if (data is Map<String, dynamic>) {
        return DriverEarningsModel.fromJson(data);
      }
      return const DriverEarningsModel(
        totalTrips: 0,
        totalEarnings: 0,
        currencyCode: 'EUR',
        trips: [],
      );
    });
  }
}
