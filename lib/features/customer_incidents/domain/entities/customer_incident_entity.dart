/// Admin-facing customer incident (a problem or notable customer action).
class CustomerIncidentEntity {
  const CustomerIncidentEntity({
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

  bool get isClosed {
    final s = status.toLowerCase();
    return s == 'resolved' || s == 'dismissed';
  }

  bool get isCritical => severity.toLowerCase() == 'critical';

  String? get amountLabel =>
      amount == null ? null : '${amount!.toStringAsFixed(2)} ${currencyCode ?? ''}'.trim();
}

/// Full incident view including the sensitive material an admin may inspect.
class CustomerIncidentDetailEntity {
  const CustomerIncidentDetailEntity({
    required this.incident,
    required this.passengerPhone,
    required this.tripStatus,
    required this.recordings,
    required this.chatMessages,
    required this.locations,
  });

  final CustomerIncidentEntity incident;
  final String? passengerPhone;
  final String? tripStatus;
  final List<IncidentRecordingEntity> recordings;
  final List<IncidentChatMessageEntity> chatMessages;
  final List<IncidentLocationEntity> locations;
}

class IncidentRecordingEntity {
  const IncidentRecordingEntity({
    required this.id,
    required this.fileUrl,
    required this.type,
    required this.durationSeconds,
    required this.recordedAt,
  });

  final String id;
  final String fileUrl;
  final String type;
  final int? durationSeconds;
  final DateTime? recordedAt;
}

class IncidentChatMessageEntity {
  const IncidentChatMessageEntity({
    required this.senderRole,
    required this.content,
    required this.photoUrl,
    required this.sentAt,
  });

  final String senderRole;
  final String? content;
  final String? photoUrl;
  final DateTime? sentAt;
}

class IncidentLocationEntity {
  const IncidentLocationEntity({
    required this.latitude,
    required this.longitude,
    required this.addressLabel,
    required this.sequence,
  });

  final double latitude;
  final double longitude;
  final String? addressLabel;
  final int sequence;
}
