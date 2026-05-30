import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../models/trip_model.dart';

@lazySingleton
class TripRemoteDataSource {
  const TripRemoteDataSource(this._dio);

  final Dio _dio;

  Future<List<TripModel>> getAllTrips() {
    return rethrowAsAppException(() async {
      printY('[TripRemoteDataSource] getAllTrips');
      final response = await _dio.get<dynamic>(ApiEndpoints.adminTrips);
      final data = response.data;
      final dataList = data is List<dynamic>
          ? data
          : (data['data'] ?? data['items'] ?? data['Items']) as List<dynamic>;
      return dataList.map((e) => TripModel.fromJson(e)).toList();
    });
  }

  Future<TripModel> getTripById(String tripId) {
    return rethrowAsAppException(() async {
      printY('[TripRemoteDataSource] getTripById trip=$tripId');
      final response = await _dio.get<dynamic>('${ApiEndpoints.trips}/$tripId');
      return TripModel.fromJson(
        Map<String, dynamic>.from(response.data as Map),
      );
    });
  }

  Future<void> markEnRoute(String tripId) {
    return _postAction(tripId, 'en-route');
  }

  Future<void> markArrived(String tripId) {
    return _postAction(tripId, 'arrive');
  }

  Future<void> resendArrived(String tripId) {
    return rethrowAsAppException(() async {
      printY('[TripRemoteDataSource] resendArrived trip=$tripId');
      await _dio.post<dynamic>(ApiEndpoints.arriveResend(tripId));
    });
  }

  Future<void> startTrip(String tripId) {
    return _postAction(tripId, 'start');
  }

  Future<void> completeTrip(String tripId) {
    return _postAction(tripId, 'complete');
  }

  Future<void> completeStop(String tripId, int sequence) {
    return rethrowAsAppException(() async {
      printY('[TripRemoteDataSource] completeStop trip=$tripId seq=$sequence');
      await _dio.post<dynamic>(
        ApiEndpoints.completeTripStop(tripId, sequence),
      );
    });
  }

  Future<void> assignToDriver(String tripId, String driverId) {
    return rethrowAsAppException(() async {
      printY('[TripRemoteDataSource] assignToDriver trip=$tripId driver=$driverId');
      await _dio.post<dynamic>(
        ApiEndpoints.assignTrip(tripId),
        data: {'driverId': driverId},
      );
    });
  }

  Future<void> adminTakeTrip(String tripId) {
    return rethrowAsAppException(() async {
      printY('[TripRemoteDataSource] adminTakeTrip trip=$tripId');
      await _dio.post<dynamic>(ApiEndpoints.adminTakeTrip(tripId));
    });
  }

  Future<void> driverCancelTrip(
    String tripId,
    String reason,
    String? note,
  ) {
    return rethrowAsAppException(() async {
      printY('[TripRemoteDataSource] driverCancelTrip trip=$tripId reason=$reason');
      await _dio.post<dynamic>(
        ApiEndpoints.driverCancelTrip(tripId),
        data: {'reason': reason, 'note': note},
      );
    });
  }

  Future<void> adminCancelTrip(String tripId, {String? note}) {
    return rethrowAsAppException(() async {
      printY('[TripRemoteDataSource] adminCancelTrip trip=$tripId');
      await _dio.post<dynamic>(
        ApiEndpoints.cancelTrip(tripId),
        data: {'note': note},
      );
    });
  }

  Future<void> _postAction(String tripId, String action) {
    return rethrowAsAppException(() async {
      printY('[TripRemoteDataSource] action=$action trip=$tripId');
      await _dio.post<dynamic>('${ApiEndpoints.trips}/$tripId/$action');
    });
  }
}
