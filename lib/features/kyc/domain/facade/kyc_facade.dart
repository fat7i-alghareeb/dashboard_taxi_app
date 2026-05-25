import 'package:injectable/injectable.dart';

import '../../../../core/utils/result.dart';
import '../entities/kyc_document_entity.dart';
import '../repositories/kyc_repository.dart';

@lazySingleton
class KycFacade {
  const KycFacade(this._repository);

  final KycRepository _repository;

  Future<Result<List<KycDocumentEntity>>> getDriverDocuments(String driverId) {
    return _repository.getDriverDocuments(driverId);
  }

  Future<Result<String>> uploadDocument({
    required String driverId,
    required String type,
    required String filePath,
  }) {
    return _repository.uploadDocument(
      driverId: driverId,
      type: type,
      filePath: filePath,
    );
  }
}
