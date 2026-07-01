class RefundIssueModel {
  const RefundIssueModel({
    required this.id,
    required this.tripId,
    required this.passengerId,
    required this.requestType,
    required this.customerReason,
    required this.reviewStatus,
    required this.createdAtUtc,
    this.paymentId,
    this.paymentRefundId,
    this.tripCancellationId,
    this.note,
    this.refundStatusSnapshot,
    this.refundAmountSnapshot,
    this.refundCurrencySnapshot,
    this.reviewedByAdminId,
    this.reviewedAtUtc,
    this.adminNotes,
    this.whatsAppOpened = false,
    this.passengerName,
    this.tripReferenceCode,
  });

  final String id;
  final String tripId;
  final String passengerId;
  final String? paymentId;
  final String? paymentRefundId;
  final String? tripCancellationId;
  final String requestType;
  final String customerReason;
  final String? note;
  final String? refundStatusSnapshot;
  final double? refundAmountSnapshot;
  final String? refundCurrencySnapshot;
  final String reviewStatus;
  final DateTime createdAtUtc;
  final String? reviewedByAdminId;
  final DateTime? reviewedAtUtc;
  final String? adminNotes;
  final bool whatsAppOpened;
  final String? passengerName;
  final String? tripReferenceCode;

  factory RefundIssueModel.fromJson(Map<String, dynamic> json) {
    return RefundIssueModel(
      id: _readString(json, 'id') ?? '',
      tripId: _readString(json, 'tripId') ?? '',
      passengerId: _readString(json, 'passengerId') ?? '',
      paymentId: _readString(json, 'paymentId'),
      paymentRefundId: _readString(json, 'paymentRefundId'),
      tripCancellationId: _readString(json, 'tripCancellationId'),
      requestType: _readString(json, 'requestType') ?? '',
      customerReason: _readString(json, 'customerReason') ?? '',
      note: _readString(json, 'note'),
      refundStatusSnapshot: _readString(json, 'refundStatusSnapshot'),
      refundAmountSnapshot: _readDouble(json, 'refundAmountSnapshot'),
      refundCurrencySnapshot: _readString(json, 'refundCurrencySnapshot'),
      reviewStatus: _readString(json, 'reviewStatus') ?? '',
      createdAtUtc: _readDate(json, 'createdAtUtc') ?? DateTime.now(),
      reviewedByAdminId: _readString(json, 'reviewedByAdminId'),
      reviewedAtUtc: _readDate(json, 'reviewedAtUtc'),
      adminNotes: _readString(json, 'adminNotes'),
      whatsAppOpened: _readBool(json, 'whatsAppOpened'),
      passengerName: _readString(json, 'passengerName'),
      tripReferenceCode: _readString(json, 'tripReferenceCode'),
    );
  }

  static String? _readString(Map<String, dynamic> json, String key) {
    final value = json[key];
    final text = value?.toString().trim();
    return text == null || text.isEmpty ? null : text;
  }

  static double? _readDouble(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  static bool _readBool(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is bool) return value;
    if (value is String) return value.toLowerCase() == 'true';
    return false;
  }

  static DateTime? _readDate(Map<String, dynamic> json, String key) {
    final value = json[key]?.toString();
    if (value == null || value.isEmpty) return null;
    return DateTime.tryParse(value)?.toLocal();
  }
}
