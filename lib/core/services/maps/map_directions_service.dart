import 'package:dio/dio.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

import '../../network/api_endpoints.dart';
import '../../../utils/helpers/colored_print.dart';

/// Fetches road-accurate route geometry from the backend directions endpoint
/// and decodes it into per-leg point lists for drawing on the in-app map.
@lazySingleton
class MapDirectionsService {
  const MapDirectionsService(this._dio);

  final Dio _dio;

  /// Returns one decoded point list per leg between consecutive [stops].
  /// Drawing is best-effort: returns an empty list on any failure.
  Future<List<List<LatLng>>> getLegPolylines(List<LatLng> stops) async {
    if (stops.length < 2) return const <List<LatLng>>[];

    try {
      final res = await _dio.post(
        ApiEndpoints.mapsDirections,
        data: {
          'stops': stops
              .map((s) => {'latitude': s.latitude, 'longitude': s.longitude})
              .toList(),
        },
      );

      final json = res.data as Map<String, dynamic>;
      final legsJson = json['legs'] as List<dynamic>? ?? const <dynamic>[];

      final legs = <List<LatLng>>[];
      for (final legRaw in legsJson) {
        final leg = legRaw as Map<String, dynamic>;
        legs.add(_decode(leg['encodedPolyline'] as String? ?? ''));
      }

      // Fall back to the overall polyline if per-leg geometry is missing.
      if (legs.isEmpty || legs.every((leg) => leg.isEmpty)) {
        final overall = _decode(json['encodedPolyline'] as String? ?? '');
        return overall.isEmpty ? const <List<LatLng>>[] : <List<LatLng>>[overall];
      }

      return legs;
    } catch (e) {
      printY('[MapDirectionsService] getLegPolylines failed: $e');
      return const <List<LatLng>>[];
    }
  }

  List<LatLng> _decode(String encoded) {
    if (encoded.isEmpty) return const <LatLng>[];
    return PolylinePoints.decodePolyline(encoded)
        .map((p) => LatLng(p.latitude, p.longitude))
        .toList();
  }
}
