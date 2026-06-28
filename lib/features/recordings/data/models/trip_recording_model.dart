import '../../domain/entities/trip_recording_entity.dart';

class TripRecordingModel {
  const TripRecordingModel({
    required this.id,
    required this.tripId,
    required this.fileUrl,
    required this.type,
    required this.durationSeconds,
    required this.recordedAt,
    this.tripReferenceCode,
    this.passengerId,
    this.passengerName,
  });

  final String id;
  final String tripId;
  final String fileUrl;
  final String type;
  final int? durationSeconds;
  final DateTime? recordedAt;
  final String? tripReferenceCode;
  final String? passengerId;
  final String? passengerName;

  factory TripRecordingModel.fromJson(Map<String, dynamic> json) {
    return TripRecordingModel(
      id: json['id']?.toString() ?? '',
      tripId: json['tripId']?.toString() ?? '',
      fileUrl: json['fileUrl']?.toString() ?? '',
      type: json['type']?.toString() ?? 'Audio',
      durationSeconds: (json['durationSeconds'] as num?)?.toInt(),
      recordedAt: DateTime.tryParse(json['recordedAtUtc']?.toString() ?? ''),
      tripReferenceCode: json['tripReferenceCode']?.toString(),
      passengerId: json['passengerId']?.toString(),
      passengerName: json['passengerName']?.toString(),
    );
  }

  TripRecordingEntity get toEntity => TripRecordingEntity(
    id: id,
    tripId: tripId,
    fileUrl: fileUrl,
    type: type,
    durationSeconds: durationSeconds,
    recordedAt: recordedAt,
    tripReferenceCode: tripReferenceCode,
    passengerId: passengerId,
    passengerName: passengerName,
  );
}
