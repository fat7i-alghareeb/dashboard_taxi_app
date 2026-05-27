import '../user_entity.dart';

/// Backend role identifiers as emitted by the ASP.NET Core auth layer.
class UserRoles {
  UserRoles._();
  static const String admin = 'Admin';
  static const String driver = 'Driver';
  static const String passenger = 'Passenger';
}

/// Role-aware helpers on [UserEntity]. Matching is case-insensitive and looks
/// at both [UserEntity.role] (single primary role) and [UserEntity.roles]
/// (multi-role bearer tokens).
extension UserRoleX on UserEntity {
  bool hasRole(String role) {
    final target = role.toLowerCase();
    if (this.role?.toLowerCase() == target) return true;
    final list = roles;
    if (list == null) return false;
    return list.any((r) => r.toLowerCase() == target);
  }

  bool get isAdmin => hasRole(UserRoles.admin);
  bool get isDriver => hasRole(UserRoles.driver);
}

extension NullableUserRoleX on UserEntity? {
  bool get isAdmin => this?.isAdmin ?? false;
  bool get isDriver => this?.isDriver ?? false;
}
