import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/core/theme/app_map_styles.dart';
import 'package:dashboardtaxi/features/root/domain/entities/root_map_location_entity.dart';

class RootMapCanvasWidget extends StatelessWidget {
  const RootMapCanvasWidget({
    super.key,
    required this.currentLocation,
    required this.onMapCreated,
    this.onCameraMove,
    this.onCameraIdle,
    this.legPolylines = const <List<LatLng>>[],
    this.tripMarkers = const <Marker>{},
  });

  final RootMapLocationEntity currentLocation;
  final void Function(GoogleMapController controller) onMapCreated;
  final void Function(CameraPosition position)? onCameraMove;
  final VoidCallback? onCameraIdle;

  /// One decoded point list per route leg (drawn in order).
  final List<List<LatLng>> legPolylines;

  /// Pickup / stop / dropoff markers for the active trip.
  final Set<Marker> tripMarkers;

  LatLng get _latLng =>
      LatLng(currentLocation.latitude, currentLocation.longitude);

  Set<Polyline> _buildPolylines(BuildContext context) {
    if (legPolylines.isEmpty) return const <Polyline>{};

    final legColors = <Color>[context.primary, AppColors.success];
    final polylines = <Polyline>{};

    for (var i = 0; i < legPolylines.length; i++) {
      final points = legPolylines[i];
      if (points.length < 2) continue;

      final color = legColors[i % legColors.length];

      polylines.add(
        Polyline(
          polylineId: PolylineId('trip-leg-$i-shadow'),
          points: points,
          width: 8,
          color: color.withValues(alpha: 0.18),
        ),
      );
      polylines.add(
        Polyline(
          polylineId: PolylineId('trip-leg-$i'),
          points: points,
          width: 5,
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
          onMapCreated: onMapCreated,
          onCameraMove: onCameraMove,
          onCameraIdle: onCameraIdle,
          initialCameraPosition: CameraPosition(
            target: _latLng,
            zoom: currentLocation.zoom,
          ),
          markers: tripMarkers,
          polylines: _buildPolylines(context),
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
