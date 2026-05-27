/// Unified profile shape covering both admin and driver users.
/// Fields that don't apply to a given role are left null.
class ProfileEntity {
  const ProfileEntity({
    required this.id,
    required this.name,
    required this.role,
    this.email,
    this.phone,
    this.phone2,
    this.profilePhotoUrl,
    this.driverId,
    this.licenseNumber,
    this.approvalStatus,
    this.vehicleTypeId,
    this.vehicleTypeName,
    this.isActive,
  });

  final String id;
  final String name;
  final String role;
  final String? email;
  final String? phone;
  final String? phone2;
  final String? profilePhotoUrl;
  final String? driverId;
  final String? licenseNumber;
  final String? approvalStatus;
  final String? vehicleTypeId;
  final String? vehicleTypeName;
  final bool? isActive;

  bool get isAdmin => role.toLowerCase() == 'admin';
  bool get isDriver => role.toLowerCase() == 'driver';
}
