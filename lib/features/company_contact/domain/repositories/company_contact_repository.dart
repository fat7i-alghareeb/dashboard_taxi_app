import '../../../../core/utils/result.dart';
import '../entities/company_contact_entity.dart';

abstract class CompanyContactRepository {
  Future<Result<CompanyContactEntity>> getCompanyContact();
  Future<Result<CompanyContactEntity>> updateCompanyContact({
    required String email,
    required String phone,
    required String website,
  });
}
