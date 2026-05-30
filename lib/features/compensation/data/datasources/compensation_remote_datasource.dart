import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../models/compensation_claim_model.dart';

@lazySingleton
class CompensationRemoteDataSource {
  const CompensationRemoteDataSource(this._dio);

  final Dio _dio;

  Future<List<CompensationClaimModel>> getClaims({String? status}) {
    return rethrowAsAppException(() async {
      printY('[CompensationRemoteDataSource] getClaims status=$status');
      final res = await _dio.get<dynamic>(
        ApiEndpoints.compensationClaims,
        queryParameters: {
          if (status != null && status.isNotEmpty) 'status': status,
        },
      );
      final data = res.data;
      final raw = data is List<dynamic> ? data : const <dynamic>[];
      return raw
          .whereType<Map<String, dynamic>>()
          .map(CompensationClaimModel.fromJson)
          .toList();
    });
  }

  Future<void> reviewClaim({
    required String claimId,
    required bool approved,
    String? notes,
  }) {
    return rethrowAsAppException(() async {
      printY(
        '[CompensationRemoteDataSource] reviewClaim claim=$claimId approved=$approved',
      );
      await _dio.post<dynamic>(
        ApiEndpoints.reviewCompensationClaim(claimId),
        data: {'approved': approved, 'notes': notes},
      );
    });
  }
}
