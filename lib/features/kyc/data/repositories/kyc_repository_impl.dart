import 'package:injectable/injectable.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/kyc_document_entity.dart';
import '../../domain/repositories/kyc_repository.dart';
import '../datasources/kyc_remote_datasource.dart';
import '../mappers/kyc_mapper.dart';

@LazySingleton(as: KycRepository)
class KycRepositoryImpl implements KycRepository {
  const KycRepositoryImpl(this._remote);

  final KycRemoteDataSource _remote;

  @override
  Future<Result<List<KycDocumentEntity>>> getDriverDocuments(String driverId) {
    return runAsResult(() async {
      final models = await _remote.getDriverDocuments(driverId);
      return models.map((e) => e.toEntity(driverId)).toList();
    });
  }

  @override
  Future<Result<String>> uploadDocument({
    required String driverId,
    required String type,
    required String filePath,
  }) {
    return runAsResult(() => _remote.uploadDocument(
          driverId: driverId,
          type: type,
          filePath: filePath,
        ));
  }
}
