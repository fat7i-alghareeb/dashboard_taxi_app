import '../../../../core/utils/result.dart';
import '../entities/support_contact_entity.dart';

abstract class SupportContactRepository {
  Future<Result<SupportContactEntity>> getSupportContact();
  Future<Result<SupportContactEntity>> updateSupportContact({
    required String whatsApp,
  });
}
