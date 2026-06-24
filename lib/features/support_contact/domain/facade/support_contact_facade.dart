import 'package:injectable/injectable.dart';

import '../../../../core/utils/result.dart';
import '../entities/support_contact_entity.dart';
import '../repositories/support_contact_repository.dart';

@lazySingleton
class SupportContactFacade {
  const SupportContactFacade(this._repository);

  final SupportContactRepository _repository;

  Future<Result<SupportContactEntity>> getSupportContact() =>
      _repository.getSupportContact();

  Future<Result<SupportContactEntity>> updateSupportContact({
    required String whatsApp,
  }) => _repository.updateSupportContact(whatsApp: whatsApp);
}
