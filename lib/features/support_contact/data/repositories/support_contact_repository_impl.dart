import 'package:injectable/injectable.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/support_contact_entity.dart';
import '../../domain/repositories/support_contact_repository.dart';
import '../datasources/support_contact_remote_datasource.dart';

@LazySingleton(as: SupportContactRepository)
class SupportContactRepositoryImpl implements SupportContactRepository {
  const SupportContactRepositoryImpl(this._remote);

  final SupportContactRemoteDataSource _remote;

  @override
  Future<Result<SupportContactEntity>> getSupportContact() {
    return runAsResult(() async {
      final model = await _remote.getSupportContact();
      return model.toEntity();
    });
  }

  @override
  Future<Result<SupportContactEntity>> updateSupportContact({
    required String whatsApp,
  }) {
    return runAsResult(() async {
      final model = await _remote.updateSupportContact(whatsApp: whatsApp);
      return model.toEntity();
    });
  }
}
