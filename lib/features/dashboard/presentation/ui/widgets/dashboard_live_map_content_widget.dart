import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/core/theme/app_map_styles.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_live_driver_card_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_live_map_header_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_live_map_stats_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_pending_pickup_card_widget.dart';

class DashboardLiveMapContentWidget extends StatefulWidget {
  const DashboardLiveMapContentWidget({
    super.key,
    required this.drivers,
    required this.pendingTrips,
    required this.assignableDrivers,
  });

  final List<DashboardDriverLocationEntity> drivers;
  final List<DashboardTripEntity> pendingTrips;
  final List<DashboardDriverEntity> assignableDrivers;

  @override
  State<DashboardLiveMapContentWidget> createState() =>
      _DashboardLiveMapContentWidgetState();
}

class _DashboardLiveMapContentWidgetState
    extends State<DashboardLiveMapContentWidget> {
  GoogleMapController? _controller;
  String? _selectedDriverId;
  String? _selectedTripId;

  static const LatLng _fallbackCenter = LatLng(52.3676, 4.9041);

  @override
  void didUpdateWidget(covariant DashboardLiveMapContentWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    final selected = _selectedDriver;
    if (selected?.hasLocation ?? false) {
      _moveToDriver(selected!);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  DashboardDriverLocationEntity? get _selectedDriver {
    if (_selectedDriverId == null) return null;
    return widget.drivers
        .where((driver) => driver.driverId == _selectedDriverId)
        .firstOrNull;
  }

  DashboardTripEntity? get _selectedTrip {
    if (_selectedTripId == null) return null;
    return widget.pendingTrips
        .where((trip) => trip.id == _selectedTripId)
        .firstOrNull;
  }

  LatLng get _initialCenter {
    final firstLocated = widget.drivers
        .where((driver) => driver.hasLocation)
        .firstOrNull;
    if (firstLocated == null) return _fallbackCenter;
    return LatLng(firstLocated.latitude!, firstLocated.longitude!);
  }

  Set<Marker> get _driverMarkers {
    return widget.drivers
        .where((driver) => driver.hasLocation)
        .map(
          (driver) => Marker(
            markerId: MarkerId(driver.driverId),
            position: LatLng(driver.latitude!, driver.longitude!),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              driver.isBusy
                  ? BitmapDescriptor.hueRed
                  : BitmapDescriptor.hueGreen,
            ),
            onTap: () {
              setState(() {
                _selectedDriverId = driver.driverId;
                _selectedTripId = null;
              });
              _moveToDriver(driver);
            },
          ),
        )
        .toSet();
  }

  Set<Marker> get _tripMarkers {
    return widget.pendingTrips
        .where((trip) => trip.hasPickupLocation)
        .map(
          (trip) => Marker(
            markerId: MarkerId('pickup_${trip.id}'),
            position: LatLng(trip.pickupLatitude!, trip.pickupLongitude!),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueYellow,
            ),
            onTap: () {
              setState(() {
                _selectedTripId = trip.id;
                _selectedDriverId = null;
              });
              _moveToTrip(trip);
            },
          ),
        )
        .toSet();
  }

  Future<void> _moveToDriver(DashboardDriverLocationEntity driver) async {
    final controller = _controller;
    if (controller == null || !driver.hasLocation) return;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(driver.latitude!, driver.longitude!),
          zoom: 15,
        ),
      ),
    );
  }

  Future<void> _moveToTrip(DashboardTripEntity trip) async {
    final controller = _controller;
    if (controller == null || !trip.hasPickupLocation) return;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(trip.pickupLatitude!, trip.pickupLongitude!),
          zoom: 15,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selected = _selectedDriver;
    final selectedTrip = _selectedTrip;
    final markers = {..._driverMarkers, ..._tripMarkers};

    return Stack(
      children: [
        Positioned.fill(
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _initialCenter,
              zoom: 12,
            ),
            style: AppMapStyles.dark,
            markers: markers,
            onMapCreated: (controller) {
              _controller = controller;
            },
          ),
        ),
        Positioned(
          top: AppSpacing.xxl.h,
          left: AppSpacing.xl.w,
          right: AppSpacing.xl.w,
          child: const DashboardLiveMapHeaderWidget(),
        ),
        Positioned(
          bottom: AppSpacing.xxl.h,
          left: AppSpacing.xl.w,
          right: AppSpacing.xl.w,
          child: selectedTrip != null
              ? DashboardPendingPickupCardWidget(
                  trip: selectedTrip,
                  drivers: widget.assignableDrivers,
                  liveDrivers: widget.drivers,
                )
              : selected == null
              ? DashboardLiveMapStatsWidget(drivers: widget.drivers)
              : DashboardLiveDriverCardWidget(driver: selected),
        ),
        if (markers.isEmpty)
          Positioned(
            left: AppSpacing.xl.w,
            right: AppSpacing.xl.w,
            bottom: 184.h,
            child: EmptyStateWidget(text: AppStrings.dashboardNoLiveDrivers),
          ),
      ],
    );
  }
}
