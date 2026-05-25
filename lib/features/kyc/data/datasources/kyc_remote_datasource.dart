import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/global_error_handler.dart';
import '../models/kyc_document_model.dart';

@lazySingleton
class KycRemoteDataSource {
  const KycRemoteDataSource(this._dio);

  final Dio _dio;

  Future<List<KycDocumentModel>> getDriverDocuments(String driverId) =>
      rethrowAsAppException(() async {
        final res = await _dio.get('/api/v1/drivers/$driverId/documents');
        final list = res.data as List<dynamic>;
        return list.map((e) => KycDocumentModel.fromJson(e as Map<String, dynamic>)).toList();
      });

  Future<String> uploadDocument({
    required String driverId,
    required String type,
    required String filePath,
  }) =>
      rethrowAsAppException(() async {
        final file = await MultipartFile.fromFile(filePath);
        final formData = FormData.fromMap({
          'type': type,
          'file': file,
        });
        final res = await _dio.post(
          '/api/v1/drivers/$driverId/documents',
          data: formData,
        );
        return (res.data as Map<String, dynamic>)['fileUrl'] as String;
      });
}
