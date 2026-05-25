import '../../../../core/utils/result.dart';
import '../entities/kyc_document_entity.dart';

abstract class KycRepository {
  Future<Result<List<KycDocumentEntity>>> getDriverDocuments(String driverId);
  Future<Result<String>> uploadDocument({
    required String driverId,
    required String type,
    required String filePath,
  });
}
