import 'package:flutter/material.dart';
import 'package:dashboardtaxi/utils/helpers/app_strings.dart';

import '../../../domain/entities/incident_type.dart';

/// Presentation helpers (labels, colors, formatting) shared by the incident
/// list and detail screens.
class IncidentUi {
  IncidentUi._();

  static String typeLabel(String type) =>
      IncidentType.fromJson(type)?.label ?? type;

  static String statusLabel(String status) {
    switch (status.toLowerCase()) {
      case 'open':
        return AppStrings.incidentStatusOpen;
      case 'inreview':
        return AppStrings.incidentStatusInReview;
      case 'resolved':
        return AppStrings.incidentStatusResolved;
      case 'dismissed':
        return AppStrings.incidentStatusDismissed;
      default:
        return status;
    }
  }

  static Color severityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'critical':
        return const Color(0xFFEA5455);
      case 'warning':
        return const Color(0xFFFF9F43);
      default:
        return const Color(0xFF6C757D);
    }
  }

  static Color statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'open':
        return const Color(0xFFEA5455);
      case 'inreview':
        return const Color(0xFFFF9F43);
      case 'resolved':
        return const Color(0xFF28C76F);
      case 'dismissed':
        return const Color(0xFF6C757D);
      default:
        return const Color(0xFF6C757D);
    }
  }

  static String formatDate(DateTime? dt) {
    if (dt == null) return '';
    final local = dt.toLocal();
    String two(int v) => v.toString().padLeft(2, '0');
    return '${local.year}-${two(local.month)}-${two(local.day)} '
        '${two(local.hour)}:${two(local.minute)}';
  }
}
