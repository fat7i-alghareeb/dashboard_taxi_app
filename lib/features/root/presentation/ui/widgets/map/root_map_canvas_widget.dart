import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/core/theme/app_map_styles.dart';
import 'package:dashboardtaxi/features/root/domain/entities/root_map_location_entity.dart';

class RootMapCanvasWidget extends StatelessWidget {
  const RootMapCanvasWidget({
    super.key,
    required this.currentLocation,
    required this.onMapCreated,
    this.driverMarker,
    this.onCameraMove,
    this.onCameraIdle,
  });

  final RootMapLocationEntity currentLocation;
  final void Function(GoogleMapController controller) onMapCreated;
  final Marker? driverMarker;
  final void Function(CameraPosition position)? onCameraMove;
  final VoidCallback? onCameraIdle;

  LatLng get _latLng =>
      LatLng(currentLocation.latitude, currentLocation.longitude);

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
          markers: {?driverMarker},
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
