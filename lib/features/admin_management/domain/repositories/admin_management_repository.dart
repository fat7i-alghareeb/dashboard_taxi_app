import '../../../../core/utils/result.dart';
import '../../data/params/register_admin_params.dart';

abstract class AdminManagementRepository {
  /// Creates a new administrative account. Only existing admins are authorized
  /// by the backend. Returns the new admin profile id on success.
  Future<Result<String>> registerAdmin(RegisterAdminParams params);
}
