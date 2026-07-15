import 'package:flutter/foundation.dart' show listEquals;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/core/theme/app_map_styles.dart';
import 'package:dashboardtaxi/features/root/domain/entities/root_map_location_entity.dart';

class RootMapCanvasWidget extends StatefulWidget {
  const RootMapCanvasWidget({
    super.key,
    required this.currentLocation,
    required this.onMapCreated,
    this.onCameraMove,
    this.onCameraIdle,
    this.legPolylines = const <List<LatLng>>[],
    this.tripMarkers = const <Marker>{},
    this.legsAreDashed = false,
  });

  final RootMapLocationEntity currentLocation;
  final void Function(GoogleMapController controller) onMapCreated;
  final void Function(CameraPosition position)? onCameraMove;
  final VoidCallback? onCameraIdle;

  /// One decoded point list per route leg (drawn in order).
  final List<List<LatLng>> legPolylines;

  /// Pickup / stop / dropoff markers for the active trip.
  final Set<Marker> tripMarkers;

  /// When true, every leg is rendered as a single dashed primary-colored
  /// polyline (no shadow, no leg color rotation). Used for the
  /// driver→pickup phase to visually distinguish "approach" from the
  /// actual trip route, while still following the road via the decoded
  /// directions polyline.
  ///
  /// When false (default), legs are rendered the customer-app way: a soft
  /// shadow layer underneath and a solid layer on top, rotating through
  /// the leg color palette.
  final bool legsAreDashed;

  @override
  State<RootMapCanvasWidget> createState() => _RootMapCanvasWidgetState();
}

class _RootMapCanvasWidgetState extends State<RootMapCanvasWidget> {
  // Rotating leg colors — kept in sync with the customer app so the route
  // looks identical across both surfaces.
  static const List<Color> _legColors = <Color>[
    Colors.orange,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.red,
    Colors.teal,
    Colors.indigo,
  ];

  Set<Polyline>? _cachedPolylines;
  List<List<LatLng>>? _lastLegPolylinesInput;
  bool? _lastLegsAreDashed;
  bool? _lastIsDarkTheme;

  LatLng get _latLng => LatLng(
    widget.currentLocation.latitude,
    widget.currentLocation.longitude,
  );

  Set<Polyline> _resolvePolylines(BuildContext context) {
    final isDark = context.isDarkTheme;
    if (_cachedPolylines != null &&
        listEquals(_lastLegPolylinesInput, widget.legPolylines) &&
        _lastLegsAreDashed == widget.legsAreDashed &&
        _lastIsDarkTheme == isDark) {
      return _cachedPolylines!;
    }

    final polylines = _buildPolylines(context);

    _cachedPolylines = polylines;
    _lastLegPolylinesInput = widget.legPolylines;
    _lastLegsAreDashed = widget.legsAreDashed;
    _lastIsDarkTheme = isDark;
    return polylines;
  }

  Set<Polyline> _buildPolylines(BuildContext context) {
    final legPolylines = widget.legPolylines;
    if (legPolylines.isEmpty) return const <Polyline>{};

    final polylines = <Polyline>{};

    if (widget.legsAreDashed) {
      // Driver→pickup approach: road-following polyline, rendered dashed so
      // it doesn't look like a real trip leg yet.
      for (var i = 0; i < legPolylines.length; i++) {
        final points = legPolylines[i];
        if (points.length < 2) continue;
        polylines.add(
          Polyline(
            polylineId: PolylineId('trip-leg-$i-dashed'),
            points: points,
            width: 4.r.toInt(),
            color: context.primary.withValues(alpha: 0.75),
            patterns: <PatternItem>[
              PatternItem.dash(18),
              PatternItem.gap(10),
            ],
          ),
        );
      }
      return polylines;
    }

    // Standard trip drawing: shadow + solid per leg, rotating colors.
    for (var i = 0; i < legPolylines.length; i++) {
      final points = legPolylines[i];
      if (points.length < 2) continue;

      final color = _legColors[i % _legColors.length];

      polylines.add(
        Polyline(
          polylineId: PolylineId('trip-leg-$i-shadow'),
          points: points,
          width: 6.r.toInt(),
          color: color.withValues(alpha: 0.15),
        ),
      );
      polylines.add(
        Polyline(
          polylineId: PolylineId('trip-leg-$i'),
          points: points,
          width: 4.r.toInt(),
          color: color,
        ),
      );
    }

    return polylines;
  }

  @override
  Widget build(BuildContext context) {
    printM('[RootMapCanvasWidget] build');
    return RepaintBoundary(
      child: ExcludeSemantics(
        child: GoogleMap(
          style: context.isDarkTheme ? AppMapStyles.dark : null,
          onMapCreated: widget.onMapCreated,
          onCameraMove: widget.onCameraMove,
          onCameraIdle: widget.onCameraIdle,
          initialCameraPosition: CameraPosition(
            target: _latLng,
            zoom: widget.currentLocation.zoom,
          ),
          markers: widget.tripMarkers,
          polylines: _resolvePolylines(context),
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          compassEnabled: false,
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
          minMaxZoomPreference: const MinMaxZoomPreference(5, 19),
        ),
      ),
    );
  }
}
