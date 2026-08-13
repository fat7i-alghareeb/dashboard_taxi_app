import 'package:injectable/injectable.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_datasource.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  const ProfileRepositoryImpl(this._remote);

  final ProfileRemoteDataSource _remote;

  @override
  Future<Result<void>> deleteAccount() {
    return runAsResult(() => _remote.deleteAccount());
  }

  @override
  Future<Result<ProfileEntity>> getAdminProfile() {
    return runAsResult(() async {
      final model = await _remote.getAdminProfile();
      return model.toEntity();
    });
  }

  @override
  Future<Result<ProfileEntity>> updateAdminProfile({
    required String name,
    required String email,
    String? phone1,
    String? phone2,
  }) {
    return runAsResult(() async {
      final model = await _remote.updateAdminProfile(
        name: name,
        email: email,
        phone1: phone1,
        phone2: phone2,
      );
      return model.toEntity();
    });
  }

  @override
  Future<Result<ProfileEntity>> getDriverProfile() {
    return runAsResult(() async {
      final model = await _remote.getDriverProfile();
      return model.toEntity();
    });
  }

  @override
  Future<Result<ProfileEntity>> updateDriverProfile({
    required String name,
    String? email,
  }) {
    return runAsResult(() async {
      final model = await _remote.updateDriverProfile(name: name, email: email);
      return model.toEntity();
    });
  }
}
