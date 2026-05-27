import 'package:injectable/injectable.dart';

import '../../../../core/utils/result.dart';
import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

@lazySingleton
class ProfileFacade {
  const ProfileFacade(this._repository);

  final ProfileRepository _repository;

  Future<Result<ProfileEntity>> getAdminProfile() =>
      _repository.getAdminProfile();

  Future<Result<ProfileEntity>> updateAdminProfile({
    required String name,
    required String email,
    String? phone1,
    String? phone2,
  }) =>
      _repository.updateAdminProfile(
        name: name,
        email: email,
        phone1: phone1,
        phone2: phone2,
      );

  Future<Result<ProfileEntity>> getDriverProfile() =>
      _repository.getDriverProfile();

  Future<Result<ProfileEntity>> updateDriverProfile({
    required String name,
    String? email,
  }) =>
      _repository.updateDriverProfile(name: name, email: email);
}
