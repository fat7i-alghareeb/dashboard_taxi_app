class KycDocumentModel {
  const KycDocumentModel({
    required this.id,
    required this.type,
    required this.fileUrl,
    required this.status,
    this.reviewNotes,
  });

  final String id;
  final String type; // DriversLicense, NationalId, VehicleRegistration, Insurance
  final String fileUrl;
  final String status; // Pending, Approved, Rejected
  final String? reviewNotes;

  factory KycDocumentModel.fromJson(Map<String, dynamic> json) {
    return KycDocumentModel(
      id: json['id'] as String? ?? json['Id'] as String? ?? '',
      type: json['type'] as String? ?? json['Type'] as String? ?? '',
      fileUrl: json['fileUrl'] as String? ?? json['FileUrl'] as String? ?? '',
      status: json['status'] as String? ?? json['Status'] as String? ?? '',
      reviewNotes: json['reviewNotes'] as String? ?? json['ReviewNotes'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'fileUrl': fileUrl,
        'status': status,
        'reviewNotes': reviewNotes,
      };
}
