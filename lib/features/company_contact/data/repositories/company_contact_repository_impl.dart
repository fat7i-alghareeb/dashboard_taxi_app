import 'package:injectable/injectable.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/company_contact_entity.dart';
import '../../domain/repositories/company_contact_repository.dart';
import '../datasources/company_contact_remote_datasource.dart';

@LazySingleton(as: CompanyContactRepository)
class CompanyContactRepositoryImpl implements CompanyContactRepository {
  const CompanyContactRepositoryImpl(this._remote);

  final CompanyContactRemoteDataSource _remote;

  @override
  Future<Result<CompanyContactEntity>> getCompanyContact() {
    return runAsResult(() async {
      final model = await _remote.getCompanyContact();
      return model.toEntity();
    });
  }

  @override
  Future<Result<CompanyContactEntity>> updateCompanyContact({
    required String email,
    required String phone,
    required String website,
  }) {
    return runAsResult(() async {
      final model = await _remote.updateCompanyContact(
        email: email,
        phone: phone,
        website: website,
      );
      return model.toEntity();
    });
  }
}
