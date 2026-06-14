import 'package:injectable/injectable.dart';

import '../../../../core/utils/result.dart';
import '../entities/company_contact_entity.dart';
import '../repositories/company_contact_repository.dart';

@lazySingleton
class CompanyContactFacade {
  const CompanyContactFacade(this._repository);

  final CompanyContactRepository _repository;

  Future<Result<CompanyContactEntity>> getCompanyContact() =>
      _repository.getCompanyContact();

  Future<Result<CompanyContactEntity>> updateCompanyContact({
    required String email,
    required String phone,
    required String website,
  }) =>
      _repository.updateCompanyContact(
        email: email,
        phone: phone,
        website: website,
      );
}
