import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../models/trip_recording_model.dart';

@lazySingleton
class RecordingsRemoteDataSource {
  const RecordingsRemoteDataSource(this._dio);

  final Dio _dio;

  /// Cross-trip recordings feed, newest first, optionally filtered by customer
  /// or trip reference search.
  Future<List<TripRecordingModel>> getAllRecordings({
    int page = 1,
    int pageSize = 20,
    String? passengerId,
    String? search,
  }) {
    return rethrowAsAppException(() async {
      printY(
        '[RecordingsRemoteDataSource] getAllRecordings page=$page passenger=$passengerId search=$search',
      );
      final res = await _dio.get<dynamic>(
        ApiEndpoints.adminRecordings,
        queryParameters: {
          'page': page,
          'pageSize': pageSize,
          if (passengerId != null && passengerId.isNotEmpty)
            'passengerId': passengerId,
          if (search != null && search.isNotEmpty) 'search': search,
        },
      );
      return _parse(res.data);
    });
  }

  /// The recordings captured during a single trip.
  Future<List<TripRecordingModel>> getTripRecordings(String tripId) {
    return rethrowAsAppException(() async {
      printY('[RecordingsRemoteDataSource] getTripRecordings trip=$tripId');
      final res = await _dio.get<dynamic>(ApiEndpoints.tripRecordings(tripId));
      return _parse(res.data);
    });
  }

  List<TripRecordingModel> _parse(dynamic data) {
    final raw = data is List<dynamic> ? data : const <dynamic>[];
    return raw
        .whereType<Map<String, dynamic>>()
        .map(TripRecordingModel.fromJson)
        .toList();
  }
}
