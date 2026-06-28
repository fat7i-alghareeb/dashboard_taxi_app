import 'package:dashboardtaxi/utils/helpers/app_strings.dart';

/// The curated customer-incident types, mirroring the backend enum.
///
/// Enhanced enum: each value carries its backend wire value and exposes
/// [toJson]/[fromJson] plus a localized [label].
enum IncidentType {
  paymentFailed('PaymentFailed'),
  tripCancelledByDriver('TripCancelledByDriver'),
  tripCancelledByPassenger('TripCancelledByPassenger'),
  refunded('Refunded'),
  lowRating('LowRating'),
  lateDriverCompensationClaim('LateDriverCompensationClaim');

  const IncidentType(this.json);

  /// Backend wire value (e.g. "PaymentFailed").
  final String json;

  String toJson() => json;

  /// Parses a backend value, case-insensitively. Returns null for unknown/empty.
  static IncidentType? fromJson(String? value) {
    if (value == null || value.isEmpty) return null;
    final lower = value.toLowerCase();
    for (final type in IncidentType.values) {
      if (type.json.toLowerCase() == lower) return type;
    }
    return null;
  }

  /// Localized, human-readable label.
  String get label => switch (this) {
    IncidentType.paymentFailed => AppStrings.incidentTypePaymentFailed,
    IncidentType.tripCancelledByDriver => AppStrings.incidentTypeDriverCancelled,
    IncidentType.tripCancelledByPassenger =>
      AppStrings.incidentTypePassengerCancelled,
    IncidentType.refunded => AppStrings.incidentTypeRefunded,
    IncidentType.lowRating => AppStrings.incidentTypeLowRating,
    IncidentType.lateDriverCompensationClaim =>
      AppStrings.incidentTypeLateClaim,
  };
}
