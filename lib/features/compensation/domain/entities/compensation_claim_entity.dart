class CompensationClaimEntity {
  const CompensationClaimEntity({
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

  bool get isPending => status.toLowerCase() == 'pending';

  String get amountLabel => '${requestedAmount.toStringAsFixed(2)} $currencyCode';
}
