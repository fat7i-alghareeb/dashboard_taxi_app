import '../../domain/entities/customer_entity.dart';

class CustomerModel {
  const CustomerModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.role,
    required this.isActive,
    required this.createdAt,
    required this.profilePhotoUrl,
    required this.homeAddressLabel,
    required this.homeAddressLatitude,
    required this.homeAddressLongitude,
  });

  final String id;
  final String name;
  final String phone;
  final String? email;
  final String role;
  final bool isActive;
  final DateTime? createdAt;
  final String? profilePhotoUrl;
  final String? homeAddressLabel;
  final double? homeAddressLatitude;
  final double? homeAddressLongitude;

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      email: json['email']?.toString(),
      role: json['role']?.toString() ?? 'Passenger',
      isActive: json['isActive'] as bool? ?? true,
      createdAt: DateTime.tryParse(json['createdAtUtc']?.toString() ?? ''),
      profilePhotoUrl: json['profilePhotoUrl']?.toString(),
      homeAddressLabel: json['homeAddressLabel']?.toString(),
      homeAddressLatitude: (json['homeAddressLatitude'] as num?)?.toDouble(),
      homeAddressLongitude: (json['homeAddressLongitude'] as num?)?.toDouble(),
    );
  }

  CustomerEntity get toEntity => CustomerEntity(
    id: id,
    name: name,
    phone: phone,
    email: email,
    role: role,
    isActive: isActive,
    createdAt: createdAt,
    profilePhotoUrl: profilePhotoUrl,
    homeAddressLabel: homeAddressLabel,
    homeAddressLatitude: homeAddressLatitude,
    homeAddressLongitude: homeAddressLongitude,
  );
}
