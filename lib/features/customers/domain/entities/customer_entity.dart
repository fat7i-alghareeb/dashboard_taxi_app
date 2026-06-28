/// Admin-facing app customer (a registered passenger).
class CustomerEntity {
  const CustomerEntity({
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

  bool get hasEmail => email != null && email!.trim().isNotEmpty;

  bool get hasHomeAddress =>
      homeAddressLabel != null && homeAddressLabel!.trim().isNotEmpty;

  bool get hasPhoto =>
      profilePhotoUrl != null && profilePhotoUrl!.trim().isNotEmpty;
}
