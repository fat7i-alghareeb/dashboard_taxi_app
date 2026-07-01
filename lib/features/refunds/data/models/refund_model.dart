class RefundModel {
  const RefundModel({
    required this.status,
    required this.sourceType,
    required this.amount,
    required this.currency,
    required this.isFullRefund,
    required this.requiresAdminAction,
    required this.canRetry,
    required this.attemptCount,
    this.paymentId,
    this.refundId,
    this.tripId,
    this.passengerId,
    this.refundPercent,
    this.originalPaymentAmount,
    this.refundedTotal,
    this.remainingRefundableBalance,
    this.paymentMethod,
    this.requestedAtUtc,
    this.lastAttemptAtUtc,
    this.completedAtUtc,
    this.failedAtUtc,
    this.stripeRefundId,
    this.stripePaymentIntentId,
    this.stripeChargeId,
    this.failureCode,
    this.failureReason,
    this.retryBlockedReason,
    this.tripCancellationId,
    this.customerIncidentId,
    this.tripCompensationClaimId,
    this.requestedByAdminId,
    this.adminNote,
    this.isManualObligation = false,
    this.cancellationReason,
  });

  final String? refundId;
  final String? paymentId;
  final String? tripId;
  final String? passengerId;
  final String status;
  final String sourceType;
  final double amount;
  final String currency;
  final double? refundPercent;
  final bool isFullRefund;
  final double? originalPaymentAmount;
  final double? refundedTotal;
  final double? remainingRefundableBalance;
  final String? paymentMethod;
  final DateTime? requestedAtUtc;
  final DateTime? lastAttemptAtUtc;
  final DateTime? completedAtUtc;
  final DateTime? failedAtUtc;
  final String? stripeRefundId;
  final String? stripePaymentIntentId;
  final String? stripeChargeId;
  final String? failureCode;
  final String? failureReason;
  final int attemptCount;
  final bool canRetry;
  final String? retryBlockedReason;
  final bool requiresAdminAction;
  final String? tripCancellationId;
  final String? customerIncidentId;
  final String? tripCompensationClaimId;
  final String? requestedByAdminId;
  final String? adminNote;
  final bool isManualObligation;
  final String? cancellationReason;

  factory RefundModel.fromJson(Map<String, dynamic> json) {
    return RefundModel(
      refundId: _readString(json, 'refundId', fallbackKey: 'id'),
      paymentId: _readString(json, 'paymentId'),
      tripId: _readString(json, 'tripId'),
      passengerId: _readString(json, 'passengerId'),
      status: _readString(json, 'status') ?? '',
      sourceType: _readString(json, 'sourceType') ?? '',
      amount: _readDouble(json, 'amount') ?? 0,
      currency: _readString(json, 'currency') ?? '',
      refundPercent: _readDouble(json, 'refundPercent'),
      isFullRefund: _readBool(json, 'isFullRefund'),
      originalPaymentAmount:
          _readDouble(json, 'originalPaymentAmount') ??
          _readDouble(json, 'originalPaymentAmountSnapshot'),
      refundedTotal: _readDouble(json, 'refundedTotal'),
      remainingRefundableBalance: _readDouble(
        json,
        'remainingRefundableBalance',
      ),
      paymentMethod: _readString(json, 'paymentMethod'),
      requestedAtUtc: _readDate(json, 'requestedAtUtc'),
      lastAttemptAtUtc: _readDate(json, 'lastAttemptAtUtc'),
      completedAtUtc: _readDate(json, 'completedAtUtc'),
      failedAtUtc: _readDate(json, 'failedAtUtc'),
      stripeRefundId: _readString(json, 'stripeRefundId'),
      stripePaymentIntentId: _readString(json, 'stripePaymentIntentId'),
      stripeChargeId: _readString(json, 'stripeChargeId'),
      failureCode: _readString(json, 'failureCode'),
      failureReason: _readString(json, 'failureReason'),
      attemptCount: (_readDouble(json, 'attemptCount') ?? 0).toInt(),
      canRetry: _readBool(json, 'canRetry'),
      retryBlockedReason: _readString(json, 'retryBlockedReason'),
      requiresAdminAction: _readBool(json, 'requiresAdminAction'),
      tripCancellationId: _readString(json, 'tripCancellationId'),
      customerIncidentId: _readString(json, 'customerIncidentId'),
      tripCompensationClaimId: _readString(json, 'tripCompensationClaimId'),
      requestedByAdminId: _readString(json, 'requestedByAdminId'),
      adminNote: _readString(json, 'adminNote'),
      isManualObligation: _readBool(json, 'isManualObligation'),
      cancellationReason: _readString(json, 'cancellationReason'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'refundId': refundId,
      'paymentId': paymentId,
      'tripId': tripId,
      'passengerId': passengerId,
      'status': status,
      'sourceType': sourceType,
      'amount': amount,
      'currency': currency,
      'refundPercent': refundPercent,
      'isFullRefund': isFullRefund,
      'originalPaymentAmount': originalPaymentAmount,
      'refundedTotal': refundedTotal,
      'remainingRefundableBalance': remainingRefundableBalance,
      'paymentMethod': paymentMethod,
      'requestedAtUtc': requestedAtUtc?.toIso8601String(),
      'lastAttemptAtUtc': lastAttemptAtUtc?.toIso8601String(),
      'completedAtUtc': completedAtUtc?.toIso8601String(),
      'failedAtUtc': failedAtUtc?.toIso8601String(),
      'stripeRefundId': stripeRefundId,
      'stripePaymentIntentId': stripePaymentIntentId,
      'stripeChargeId': stripeChargeId,
      'failureCode': failureCode,
      'failureReason': failureReason,
      'attemptCount': attemptCount,
      'canRetry': canRetry,
      'retryBlockedReason': retryBlockedReason,
      'requiresAdminAction': requiresAdminAction,
      'tripCancellationId': tripCancellationId,
      'customerIncidentId': customerIncidentId,
      'tripCompensationClaimId': tripCompensationClaimId,
      'requestedByAdminId': requestedByAdminId,
      'adminNote': adminNote,
      'isManualObligation': isManualObligation,
      'cancellationReason': cancellationReason,
    };
  }

  static String? _readString(
    Map<String, dynamic> json,
    String key, {
    String? fallbackKey,
  }) {
    final value = json[key] ?? (fallbackKey == null ? null : json[fallbackKey]);
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
