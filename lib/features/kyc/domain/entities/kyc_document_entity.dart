class KycDocumentEntity {
  const KycDocumentEntity({
    required this.id,
    required this.driverId,
    required this.type,
    required this.fileUrl,
    required this.status,
    this.reviewNotes,
  });

  final String id;
  final String driverId;
  final String type; // DriversLicense, NationalId, VehicleRegistration, Insurance
  final String fileUrl;
  final String status; // Pending, Approved, Rejected
  final String? reviewNotes;
}
