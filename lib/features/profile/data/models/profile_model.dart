import '../../domain/entities/profile_entity.dart';

class ProfileModel {
  const ProfileModel({
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

  /// Backend `AdminProfileDto` shape.
  factory ProfileModel.fromAdminJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: _str(json, 'id'),
      name: _str(json, 'name'),
      role: 'Admin',
      email: _nullableStr(json, 'email'),
      phone: _nullableStr(json, 'phone1'),
      phone2: _nullableStr(json, 'phone2'),
      isActive: json['isActive'] is bool ? json['isActive'] as bool : null,
    );
  }

  /// Backend `DriverCurrentProfileDto` shape.
  factory ProfileModel.fromDriverJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: _str(json, 'userId'),
      name: _str(json, 'name'),
      role: 'Driver',
      email: _nullableStr(json, 'email'),
      phone: _nullableStr(json, 'phone'),
      profilePhotoUrl: _nullableStr(json, 'profilePhotoUrl'),
      driverId: _nullableStr(json, 'driverId'),
      licenseNumber: _nullableStr(json, 'licenseNumber'),
      approvalStatus: _nullableStr(json, 'approvalStatus'),
      vehicleTypeId: _nullableStr(json, 'vehicleTypeId'),
      vehicleTypeName: _nullableStr(json, 'vehicleTypeName'),
    );
  }

  ProfileEntity toEntity() => ProfileEntity(
        id: id,
        name: name,
        role: role,
        email: email,
        phone: phone,
        phone2: phone2,
        profilePhotoUrl: profilePhotoUrl,
        driverId: driverId,
        licenseNumber: licenseNumber,
        approvalStatus: approvalStatus,
        vehicleTypeId: vehicleTypeId,
        vehicleTypeName: vehicleTypeName,
        isActive: isActive,
      );
}

String _str(Map<String, dynamic> json, String key, {String fallback = ''}) {
  final value = json[key] ?? json[_pascal(key)];
  return value?.toString() ?? fallback;
}

String? _nullableStr(Map<String, dynamic> json, String key) {
  final value = json[key] ?? json[_pascal(key)];
  final text = value?.toString();
  if (text == null || text.trim().isEmpty) return null;
  return text;
}

String _pascal(String key) {
  if (key.isEmpty) return key;
  return '${key[0].toUpperCase()}${key.substring(1)}';
}
