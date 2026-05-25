import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/core/services/location/startup_map_warmup_coordinator.dart';
import 'package:dashboardtaxi/utils/constants/app_flow_constants.dart';
import 'package:dashboardtaxi/core/theme/app_map_styles.dart';

/// Creates a hidden map view during splash to warm up GoogleMap platform
/// resources before the user reaches the root map.
class SplashMapWarmupWidget extends StatefulWidget {
  const SplashMapWarmupWidget({super.key});

  @override
  State<SplashMapWarmupWidget> createState() => _SplashMapWarmupWidgetState();
}

class _SplashMapWarmupWidgetState extends State<SplashMapWarmupWidget> {
  late final StartupMapWarmupCoordinator _warmupCoordinator;

  @override
  void initState() {
    super.initState();
    _warmupCoordinator = getIt<StartupMapWarmupCoordinator>();
    _warmupCoordinator.ensureWarmupStarted();
  }

  void _onMapCreated(GoogleMapController controller) {
    _warmupCoordinator.onMapCreated();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Opacity(
        opacity: 0,
        // Suppress platform-view accessibility noise during warmup.
        child: ExcludeSemantics(
          child: GoogleMap(
            style: context.isDarkTheme ? AppMapStyles.dark : null,
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: LatLng(MapConfig.defaultLat, MapConfig.defaultLng),
              zoom: MapConfig.initialZoom,
            ),
            myLocationButtonEnabled: false,
            compassEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            minMaxZoomPreference: const MinMaxZoomPreference(5, 19),
          ),
        ),
      ),
    );
  }
}
