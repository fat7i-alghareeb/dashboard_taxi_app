import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../models/support_contact_model.dart';

@lazySingleton
class SupportContactRemoteDataSource {
  const SupportContactRemoteDataSource(this._dio);

  final Dio _dio;

  Future<SupportContactModel> getSupportContact() {
    return rethrowAsAppException(() async {
      printY('[SupportContactRemoteDataSource] GET support contact');
      final response = await _dio.get<dynamic>(ApiEndpoints.supportContact);
      return SupportContactModel.fromJson(
        Map<String, dynamic>.from(response.data as Map),
      );
    });
  }

  Future<SupportContactModel> updateSupportContact({
    required String whatsApp,
  }) {
    return rethrowAsAppException(() async {
      printY('[SupportContactRemoteDataSource] PUT support contact');
      final response = await _dio.put<dynamic>(
        ApiEndpoints.supportContact,
        data: {'whatsApp': whatsApp},
      );
      return SupportContactModel.fromJson(
        Map<String, dynamic>.from(response.data as Map),
      );
    });
  }
}
