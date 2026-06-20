/// Wire model for an in-trip chat message. Parsed manually (the driver app does
/// not use json_serializable) and tolerant of camelCase or PascalCase keys.
class ChatMessageModel {
  const ChatMessageModel({
    required this.id,
    required this.tripId,
    required this.senderId,
    required this.senderRole,
    required this.sentAtUtc,
    this.content,
    this.photoUrl,
  });

  final String id;
  final String tripId;
  final String senderId;
  final String senderRole;
  final String? content;
  final String? photoUrl;
  final DateTime sentAtUtc;

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    final sentRaw = json['sentAtUtc'] ?? json['SentAtUtc'];
    return ChatMessageModel(
      id: _string(json, 'id'),
      tripId: _string(json, 'tripId'),
      senderId: _string(json, 'senderId'),
      senderRole: _string(json, 'senderRole'),
      content: _nullableString(json, 'content'),
      photoUrl: _nullableString(json, 'photoUrl'),
      sentAtUtc:
          DateTime.tryParse(sentRaw?.toString() ?? '')?.toUtc() ??
          DateTime.now().toUtc(),
    );
  }

  static String _string(Map<String, dynamic> json, String key) {
    final value = json[key] ?? json[_pascal(key)];
    return value?.toString() ?? '';
  }

  static String? _nullableString(Map<String, dynamic> json, String key) {
    final value = json[key] ?? json[_pascal(key)];
    final text = value?.toString();
    return (text == null || text.isEmpty) ? null : text;
  }

  static String _pascal(String key) =>
      key.isEmpty ? key : '${key[0].toUpperCase()}${key.substring(1)}';
}
