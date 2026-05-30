import '../../domain/entities/compensation_claim_entity.dart';

class CompensationClaimModel {
  const CompensationClaimModel({
    required this.id,
    required this.tripId,
    required this.note,
    required this.evidenceUrls,
    required this.requestedAmount,
    required this.currencyCode,
    required this.status,
    required this.reviewNotes,
    required this.createdAt,
    required this.reviewedAt,
  });

  final String id;
  final String tripId;
  final String note;
  final List<String> evidenceUrls;
  final double requestedAmount;
  final String currencyCode;
  final String status;
  final String? reviewNotes;
  final DateTime? createdAt;
  final DateTime? reviewedAt;

  factory CompensationClaimModel.fromJson(Map<String, dynamic> json) {
    return CompensationClaimModel(
      id: json['id']?.toString() ?? '',
      tripId: json['tripId']?.toString() ?? '',
      note: json['note']?.toString() ?? '',
      evidenceUrls:
          (json['evidenceUrls'] as List<dynamic>?)?.whereType<String>().toList() ??
          const <String>[],
      requestedAmount: (json['requestedAmount'] as num?)?.toDouble() ?? 0,
      currencyCode: json['currencyCode']?.toString() ?? 'EUR',
      status: json['status']?.toString() ?? 'Pending',
      reviewNotes: json['reviewNotes']?.toString(),
      createdAt: DateTime.tryParse(json['createdAtUtc']?.toString() ?? ''),
      reviewedAt: DateTime.tryParse(json['reviewedAtUtc']?.toString() ?? ''),
    );
  }

  CompensationClaimEntity get toEntity => CompensationClaimEntity(
    id: id,
    tripId: tripId,
    note: note,
    evidenceUrls: evidenceUrls,
    requestedAmount: requestedAmount,
    currencyCode: currencyCode,
    status: status,
    reviewNotes: reviewNotes,
    createdAt: createdAt,
    reviewedAt: reviewedAt,
  );
}
