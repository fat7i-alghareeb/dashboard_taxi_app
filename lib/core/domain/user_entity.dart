/// Representation of a User with support for Admin, Driver, and Passenger roles.
///
/// All fields are nullable so the model can represent guest or
/// unauthenticated states while remaining easy to extend with new fields.
class UserEntity {
  const UserEntity({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.profilePhotoUrl,
    this.role,
    this.roles,
    this.requiresPasswordReset,
    this.preferredLanguage,
    this.driverId,
    this.approvalStatus,
    this.vehicleTypeId,
  });

  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? profilePhotoUrl;
  final String? role;
  final List<String>? roles;
  final bool? requiresPasswordReset;
  final String? preferredLanguage;
  final String? driverId;
  final String? approvalStatus;
  final String? vehicleTypeId;

  UserEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? profilePhotoUrl,
    String? role,
    List<String>? roles,
    bool? requiresPasswordReset,
    String? preferredLanguage,
    String? driverId,
    String? approvalStatus,
    String? vehicleTypeId,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      role: role ?? this.role,
      roles: roles ?? this.roles,
      requiresPasswordReset:
          requiresPasswordReset ?? this.requiresPasswordReset,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      driverId: driverId ?? this.driverId,
      approvalStatus: approvalStatus ?? this.approvalStatus,
      vehicleTypeId: vehicleTypeId ?? this.vehicleTypeId,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'name': name,
    'email': email,
    'phone': phone,
    'profilePhotoUrl': profilePhotoUrl,
    'role': role,
    'roles': roles,
    'requiresPasswordReset': requiresPasswordReset,
    'preferredLanguage': preferredLanguage,
    'driverId': driverId,
    'approvalStatus': approvalStatus,
    'vehicleTypeId': vehicleTypeId,
  };

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
    id: json['id'] as String?,
    name: json['name'] as String?,
    email: json['email'] as String?,
    phone: json['phone'] as String?,
    profilePhotoUrl: json['profilePhotoUrl'] as String?,
    role: json['role'] as String?,
    roles: (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
    requiresPasswordReset:
        json['requiresPasswordReset'] as bool? ??
        json['RequiresPasswordReset'] as bool? ??
        json['requires_password_reset'] as bool?,
    preferredLanguage: json['preferredLanguage'] as String?,
    driverId: json['driverId'] as String?,
    approvalStatus: json['approvalStatus'] as String?,
    vehicleTypeId: json['vehicleTypeId'] as String?,
  );
}
