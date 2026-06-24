import '../../domain/entities/support_contact_entity.dart';

class SupportContactModel {
  const SupportContactModel({required this.whatsApp});

  final String whatsApp;

  /// Backend `SupportContactDto` shape.
  factory SupportContactModel.fromJson(Map<String, dynamic> json) {
    return SupportContactModel(whatsApp: _str(json, 'whatsApp'));
  }

  SupportContactEntity toEntity() => SupportContactEntity(whatsApp: whatsApp);
}

String _str(Map<String, dynamic> json, String key) {
  final value = json[key] ?? json['${key[0].toUpperCase()}${key.substring(1)}'];
  return value?.toString() ?? '';
}
