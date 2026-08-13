import '../../../../core/utils/result.dart';
import '../entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<Result<void>> deleteAccount();

  Future<Result<ProfileEntity>> getAdminProfile();
  Future<Result<ProfileEntity>> updateAdminProfile({
    required String name,
    required String email,
    String? phone1,
    String? phone2,
  });

  Future<Result<ProfileEntity>> getDriverProfile();
  Future<Result<ProfileEntity>> updateDriverProfile({
    required String name,
    String? email,
  });
}
