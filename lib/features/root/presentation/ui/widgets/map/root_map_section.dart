import 'dart:ui' show lerpDouble;

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/common/widgets/show_overlay.dart';
import 'package:dashboardtaxi/core/services/maps/map_directions_service.dart';
import 'package:dashboardtaxi/features/root/constants/root_constants.dart';
import 'package:dashboardtaxi/features/root/domain/entities/root_map_location_entity.dart';
import 'package:dashboardtaxi/features/root/presentation/states/root_bloc.dart';
import 'package:dashboardtaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:dashboardtaxi/features/trip/presentation/states/trip_bloc.dart';
import 'package:dashboardtaxi/features/trip/presentation/states/trip_sheet_stage.dart';
import 'package:dashboardtaxi/utils/constants/app_flow_constants.dart';

import 'root_map_canvas_widget.dart';
import 'root_map_controls_section.dart';

typedef _TripOverlay = ({List<List<LatLng>> legs, Set<Marker> markers});

class RootMapSection extends StatefulWidget {
  const RootMapSection({
    super.key,
    required this.initialLocation,
  });

  final RootMapLocationEntity initialLocation;

  @override
  State<RootMapSection> createState() => _RootMapSectionState();
}

class _RootMapSectionState extends State<RootMapSection>
    with SingleTickerProviderStateMixin {
  GoogleMapController? _mapController;
  late RootMapLocationEntity _currentLocation;
  bool _isAnimating = false;
  late final AnimationController _flightController;

  final MapDirectionsService _directions = getIt<MapDirectionsService>();
  final ValueNotifier<_TripOverlay> _tripOverlay = ValueNotifier<_TripOverlay>(
    (legs: const <List<LatLng>>[], markers: const <Marker>{}),
  );
  String? _lastRouteKey;

  @override
  void initState() {
    super.initState();
    _currentLocation = widget.initialLocation;
    _flightController = AnimationController(
      vsync: this,
      duration: MapConfig.flightDuration,
    );
    printC(
      '[RootMapSection] initState '
      'lat=${_currentLocation.latitude} lng=${_currentLocation.longitude}',
    );
  }

  @override
  void didUpdateWidget(covariant RootMapSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialLocation != widget.initialLocation) {
      _currentLocation = widget.initialLocation;
      _animateToLocation(widget.initialLocation);
    }
  }

  @override
  void dispose() {
    _flightController.dispose();
    _tripOverlay.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    printG('[RootMapSection] onMapCreated');
    _mapController = controller;
    // Draw the route for any trip already selected when the map opens.
    _syncTripRoute(context.read<TripBloc>().state);
  }

  void _onRecenterTap() {
    context.read<RootBloc>().add(const RootEvent.recenterRequested());
  }

  LatLng _lerpLatLng(LatLng a, LatLng b, double t) {
    return LatLng(
      a.latitude + (b.latitude - a.latitude) * t,
      a.longitude + (b.longitude - a.longitude) * t,
    );
  }

  Future<void> _animateToLocation(RootMapLocationEntity location) async {
    if (_isAnimating) return;

    final controller = _mapController;
    if (controller == null) {
      if (mounted) setState(() => _currentLocation = location);
      return;
    }

    _isAnimating = true;

    try {
      final target = LatLng(location.latitude, location.longitude);

      final visibleRegion = await controller.getVisibleRegion();
      final startCenter = LatLng(
        (visibleRegion.northeast.latitude + visibleRegion.southwest.latitude) /
            2,
        (visibleRegion.northeast.longitude +
                visibleRegion.southwest.longitude) /
            2,
      );
      final startZoom = await controller.getZoomLevel();
      final targetZoom = location.zoom;

      final distance = Geolocator.distanceBetween(
        startCenter.latitude,
        startCenter.longitude,
        target.latitude,
        target.longitude,
      );

      if (mounted) setState(() => _currentLocation = location);

      if (distance > 50) {
        _flightController.reset();

        void listener() {
          final t = _flightController.value;
          final currentLatLng = _lerpLatLng(startCenter, target, t);
          final currentZoom = t < 0.5
              ? lerpDouble(startZoom, MapConfig.flightZoomOut, t * 2)!
              : lerpDouble(
                  MapConfig.flightZoomOut,
                  targetZoom,
                  (t - 0.5) * 2,
                )!;
          controller.moveCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(target: currentLatLng, zoom: currentZoom),
            ),
          );
        }

        _flightController.addListener(listener);
        await _flightController.forward();
        _flightController.removeListener(listener);
      } else {
        await controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: target, zoom: targetZoom),
          ),
        );
      }
    } catch (e) {
      printY('[RootMapSection] animation failed: $e');
      if (mounted) setState(() => _currentLocation = location);
    } finally {
      _isAnimating = false;
    }
  }

  void _handleRecenterState(BuildContext context, RootState state) {
    state.recenterState.when(
      initial: () {},
      loading: () {},
      success: (location) => _animateToLocation(location),
      failure: (message) {
        if (mounted && message.isNotEmpty) showErrorOverlay(context, message);
      },
    );
  }

  // --- Trip route drawing -------------------------------------------------

  /// Recomputes the polyline/markers for the active trip whenever it changes.
  /// Before pickup (assigned / en-route) we route from the current location to
  /// the pickup only; from pickup onwards we draw the whole trip with its stops.
  Future<void> _syncTripRoute(TripState tripState) async {
    final trip = tripState.activeTrip;
    final pickup = trip?.pickup;

    if (trip == null || pickup == null) {
      _lastRouteKey = null;
      _tripOverlay.value =
          (legs: const <List<LatLng>>[], markers: const <Marker>{});
      return;
    }

    final stage = tripState.sheetStage;
    final beforePickup = stage == TripSheetStage.incoming ||
        stage == TripSheetStage.toPickup;

    final List<LatLng> routeStops = beforePickup
        ? <LatLng>[
            LatLng(_currentLocation.latitude, _currentLocation.longitude),
            LatLng(pickup.latitude, pickup.longitude),
          ]
        : trip.stops
            .map((s) => LatLng(s.latitude, s.longitude))
            .toList();

    if (routeStops.length < 2) return;

    final key = '${trip.id}|${stage.name}|$beforePickup';
    if (key == _lastRouteKey) return;
    _lastRouteKey = key;

    // Markers are local; show them immediately while the route is fetched.
    final markers = _buildTripMarkers(trip, beforePickup: beforePickup);
    _tripOverlay.value = (legs: _tripOverlay.value.legs, markers: markers);

    final legs = await _directions.getLegPolylines(routeStops);
    if (!mounted || _lastRouteKey != key) return;

    _tripOverlay.value = (legs: legs, markers: markers);
    _fitToRoute(legs, routeStops);
  }

  Set<Marker> _buildTripMarkers(TripEntity trip, {required bool beforePickup}) {
    final markers = <Marker>{};
    final pickup = trip.pickup;
    if (pickup != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('trip-pickup'),
          position: LatLng(pickup.latitude, pickup.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueOrange,
          ),
          infoWindow: InfoWindow(title: pickup.displayLabel),
        ),
      );
    }

    if (!beforePickup) {
      for (var i = 1; i < trip.stops.length - 1; i++) {
        final stop = trip.stops[i];
        markers.add(
          Marker(
            markerId: MarkerId('trip-stop-$i'),
            position: LatLng(stop.latitude, stop.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueYellow,
            ),
            infoWindow: InfoWindow(title: stop.displayLabel),
          ),
        );
      }

      final dropoff = trip.dropoff;
      if (dropoff != null) {
        markers.add(
          Marker(
            markerId: const MarkerId('trip-dropoff'),
            position: LatLng(dropoff.latitude, dropoff.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueAzure,
            ),
            infoWindow: InfoWindow(title: dropoff.displayLabel),
          ),
        );
      }
    }

    return markers;
  }

  Future<void> _fitToRoute(
    List<List<LatLng>> legs,
    List<LatLng> fallback,
  ) async {
    final controller = _mapController;
    if (controller == null) return;

    final points = <LatLng>[for (final leg in legs) ...leg];
    final all = points.isNotEmpty ? points : fallback;
    if (all.length < 2) return;

    try {
      await controller.animateCamera(
        CameraUpdate.newLatLngBounds(_boundsFromPoints(all), 72),
      );
    } catch (e) {
      printY('[RootMapSection] fit route failed: $e');
    }
  }

  LatLngBounds _boundsFromPoints(List<LatLng> points) {
    var minLat = points.first.latitude;
    var maxLat = points.first.latitude;
    var minLng = points.first.longitude;
    var maxLng = points.first.longitude;

    for (final p in points) {
      if (p.latitude < minLat) minLat = p.latitude;
      if (p.latitude > maxLat) maxLat = p.latitude;
      if (p.longitude < minLng) minLng = p.longitude;
      if (p.longitude > maxLng) maxLng = p.longitude;
    }

    const delta = 0.001;
    if ((maxLat - minLat).abs() < 0.0001) {
      maxLat += delta;
      minLat -= delta;
    }
    if ((maxLng - minLng).abs() < 0.0001) {
      maxLng += delta;
      minLng -= delta;
    }

    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RootBloc, RootState>(
          listenWhen: (previous, current) =>
              previous.recenterState != current.recenterState,
          listener: _handleRecenterState,
        ),
        BlocListener<TripBloc, TripState>(
          listenWhen: (previous, current) =>
              previous.activeTrip?.id != current.activeTrip?.id ||
              previous.activeTrip?.status != current.activeTrip?.status ||
              previous.sheetStage != current.sheetStage,
          listener: (context, state) => _syncTripRoute(state),
        ),
      ],
      child: Stack(
        fit: StackFit.expand,
        children: [
          ValueListenableBuilder<_TripOverlay>(
            valueListenable: _tripOverlay,
            builder: (context, overlay, _) {
              return RootMapCanvasWidget(
                currentLocation: _currentLocation,
                onMapCreated: _onMapCreated,
                legPolylines: overlay.legs,
                tripMarkers: overlay.markers,
              );
            },
          ),
          AnimatedPositionedDirectional(
            duration: AppDurations.slow,
            curve: Curves.easeInOut,
            end: AppSpacing.xl,
            bottom: context.bottomPadding +
                RootConstants.bottomNavHeight.sp +
                AppSpacing.xxl,
            child: BlocBuilder<RootBloc, RootState>(
              buildWhen: (prev, curr) =>
                  prev.recenterState != curr.recenterState,
              builder: (context, _) => RootMapControlsSection(
                onRecenterTap: _onRecenterTap,
              ),
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 280.ms)
        .slideY(begin: 0.02, end: 0, duration: 280.ms);
  }
}
