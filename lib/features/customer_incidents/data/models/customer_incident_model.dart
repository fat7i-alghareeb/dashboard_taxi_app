import '../../domain/entities/customer_incident_entity.dart';

class CustomerIncidentModel {
  const CustomerIncidentModel({
    required this.id,
    required this.passengerId,
    required this.passengerName,
    required this.tripId,
    required this.tripReferenceCode,
    required this.type,
    required this.severity,
    required this.status,
    required this.title,
    required this.reason,
    required this.amount,
    required this.currencyCode,
    required this.createdAt,
    required this.notes,
    required this.resolvedAt,
  });

  final String id;
  final String passengerId;
  final String? passengerName;
  final String? tripId;
  final String? tripReferenceCode;
  final String type;
  final String severity;
  final String status;
  final String title;
  final String? reason;
  final double? amount;
  final String? currencyCode;
  final DateTime? createdAt;
  final String? notes;
  final DateTime? resolvedAt;

  factory CustomerIncidentModel.fromJson(Map<String, dynamic> json) {
    return CustomerIncidentModel(
      id: json['id']?.toString() ?? '',
      passengerId: json['passengerId']?.toString() ?? '',
      passengerName: json['passengerName']?.toString(),
      tripId: json['tripId']?.toString(),
      tripReferenceCode: json['tripReferenceCode']?.toString(),
      type: json['type']?.toString() ?? '',
      severity: json['severity']?.toString() ?? 'Info',
      status: json['status']?.toString() ?? 'Open',
      title: json['title']?.toString() ?? '',
      reason: json['reason']?.toString(),
      amount: (json['amount'] as num?)?.toDouble(),
      currencyCode: json['currencyCode']?.toString(),
      createdAt: DateTime.tryParse(json['createdAtUtc']?.toString() ?? ''),
      notes: json['notes']?.toString(),
      resolvedAt: DateTime.tryParse(json['resolvedAtUtc']?.toString() ?? ''),
    );
  }

  CustomerIncidentEntity get toEntity => CustomerIncidentEntity(
    id: id,
    passengerId: passengerId,
    passengerName: passengerName,
    tripId: tripId,
    tripReferenceCode: tripReferenceCode,
    type: type,
    severity: severity,
    status: status,
    title: title,
    reason: reason,
    amount: amount,
    currencyCode: currencyCode,
    createdAt: createdAt,
    notes: notes,
    resolvedAt: resolvedAt,
  );
}

class CustomerIncidentDetailModel {
  const CustomerIncidentDetailModel({
    required this.incident,
    required this.passengerPhone,
    required this.tripStatus,
    required this.recordings,
    required this.chatMessages,
    required this.locations,
  });

  final CustomerIncidentModel incident;
  final String? passengerPhone;
  final String? tripStatus;
  final List<IncidentRecordingEntity> recordings;
  final List<IncidentChatMessageEntity> chatMessages;
  final List<IncidentLocationEntity> locations;

  factory CustomerIncidentDetailModel.fromJson(Map<String, dynamic> json) {
    final incidentJson =
        (json['incident'] as Map?)?.cast<String, dynamic>() ??
        const <String, dynamic>{};

    List<T> mapList<T>(
      String key,
      T Function(Map<String, dynamic>) map,
    ) =>
        (json[key] as List<dynamic>?)
            ?.whereType<Map>()
            .map((e) => map(e.cast<String, dynamic>()))
            .toList() ??
        <T>[];

    return CustomerIncidentDetailModel(
      incident: CustomerIncidentModel.fromJson(incidentJson),
      passengerPhone: json['passengerPhone']?.toString(),
      tripStatus: json['tripStatus']?.toString(),
      recordings: mapList(
        'recordings',
        (m) => IncidentRecordingEntity(
          id: m['id']?.toString() ?? '',
          fileUrl: m['fileUrl']?.toString() ?? '',
          type: m['type']?.toString() ?? 'Audio',
          durationSeconds: (m['durationSeconds'] as num?)?.toInt(),
          recordedAt: DateTime.tryParse(m['recordedAtUtc']?.toString() ?? ''),
        ),
      ),
      chatMessages: mapList(
        'chatMessages',
        (m) => IncidentChatMessageEntity(
          senderRole: m['senderRole']?.toString() ?? '',
          content: m['content']?.toString(),
          photoUrl: m['photoUrl']?.toString(),
          sentAt: DateTime.tryParse(m['sentAtUtc']?.toString() ?? ''),
        ),
      ),
      locations: mapList(
        'locations',
        (m) => IncidentLocationEntity(
          latitude: (m['latitude'] as num?)?.toDouble() ?? 0,
          longitude: (m['longitude'] as num?)?.toDouble() ?? 0,
          addressLabel: m['addressLabel']?.toString(),
          sequence: (m['sequence'] as num?)?.toInt() ?? 0,
        ),
      ),
    );
  }

  CustomerIncidentDetailEntity get toEntity => CustomerIncidentDetailEntity(
    incident: incident.toEntity,
    passengerPhone: passengerPhone,
    tripStatus: tripStatus,
    recordings: recordings,
    chatMessages: chatMessages,
    locations: locations,
  );
}
