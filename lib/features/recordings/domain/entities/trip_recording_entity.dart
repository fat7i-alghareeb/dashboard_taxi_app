/// An in-trip safety audio recording captured by a passenger during a trip.
class TripRecordingEntity {
  const TripRecordingEntity({
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

  /// Only present in the global (cross-trip) listing.
  final String? tripReferenceCode;
  final String? passengerId;
  final String? passengerName;
}
