import '../../domain/entities/company_contact_entity.dart';

class CompanyContactModel {
  const CompanyContactModel({
    required this.email,
    required this.phone,
    required this.website,
  });

  final String email;
  final String phone;
  final String website;

  /// Backend `CompanyContactDto` shape.
  factory CompanyContactModel.fromJson(Map<String, dynamic> json) {
    return CompanyContactModel(
      email: _str(json, 'email'),
      phone: _str(json, 'phone'),
      website: _str(json, 'website'),
    );
  }

  CompanyContactEntity toEntity() => CompanyContactEntity(
        email: email,
        phone: phone,
        website: website,
      );
}

String _str(Map<String, dynamic> json, String key) {
  final value = json[key] ?? json['${key[0].toUpperCase()}${key.substring(1)}'];
  return value?.toString() ?? '';
}
