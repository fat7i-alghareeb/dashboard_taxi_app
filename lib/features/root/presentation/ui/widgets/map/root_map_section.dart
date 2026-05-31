import 'dart:ui' show lerpDouble;

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/common/widgets/show_overlay.dart';
import 'package:dashboardtaxi/core/services/maps/map_directions_service.dart';
import 'package:dashboardtaxi/features/root/constants/root_constants.dart';
import 'package:dashboardtaxi/features/root/domain/entities/root_map_location_entity.dart';
import 'package:dashboardtaxi/features/root/presentation/states/root_bloc.dart';
import 'package:dashboardtaxi/features/root/presentation/utils/map_marker_generator.dart';
import 'package:dashboardtaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:dashboardtaxi/features/trip/presentation/states/trip_bloc.dart';
import 'package:dashboardtaxi/features/trip/presentation/states/trip_sheet_stage.dart';
import 'package:dashboardtaxi/utils/constants/app_flow_constants.dart';

import 'root_map_canvas_widget.dart';
import 'root_map_controls_section.dart';

typedef _TripOverlay = ({
  List<List<LatLng>> legs,
  Set<Marker> markers,
  bool legsAreDashed,
});

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
    (
      legs: const <List<LatLng>>[],
      markers: const <Marker>{},
      legsAreDashed: false,
    ),
  );
  String? _lastRouteKey;
  final Map<String, List<List<LatLng>>> _decodedSegmentsCache =
      <String, List<List<LatLng>>>{};

  // Canvas-rendered A/B pin icons, ported from the customer app's
  // MapMarkerGenerator. Loaded asynchronously on init; the rest of the
  // marker pipeline falls back to default hue pins until they arrive so
  // the map never blocks on icon generation.
  BitmapDescriptor? _pickupMarkerIcon;
  BitmapDescriptor? _destinationMarkerIcon;

  @override
  void initState() {
    super.initState();
    _currentLocation = widget.initialLocation;
    _flightController = AnimationController(
      vsync: this,
      duration: MapConfig.flightDuration,
    );
    _loadCustomMarkers();
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

  Future<void> _loadCustomMarkers() async {
    try {
      final pickup = await MapMarkerGenerator.createCustomMarker(
        text: 'A',
        color: Colors.orange,
        size: 45.r,
      );
      final dropoff = await MapMarkerGenerator.createCustomMarker(
        text: 'B',
        color: Colors.blue,
        size: 45.r,
      );
      if (!mounted) return;
      _pickupMarkerIcon = pickup;
      _destinationMarkerIcon = dropoff;
      // Re-emit current overlay so the new icons take effect on the map.
      final trip = context.read<TripBloc>().state.activeTrip;
      if (trip != null) {
        _lastRouteKey = null;
        _syncTripRoute(context.read<TripBloc>().state);
      }
    } catch (e) {
      printY('[RootMapSection] failed to load custom markers: $e');
    }
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
  ///
  /// Two phases:
  /// - **Before pickup** (incoming / toPickup): route is just driver→pickup,
  ///   fetched from the directions service so it follows the road, and
  ///   rendered as a dashed primary-colored polyline to communicate that
  ///   the trip itself hasn't started yet.
  /// - **From pickup onwards**: we mirror the customer app — decode the
  ///   backend-computed `routeSegments` per leg so the multi-stop polyline
  ///   follows the same legs the customer sees. If the backend didn't store
  ///   any segments we fall back to the directions service over the
  ///   sequence-sorted stops.
  Future<void> _syncTripRoute(TripState tripState) async {
    final trip = tripState.activeTrip;
    final pickup = trip?.pickup;

    if (trip == null || pickup == null) {
      _lastRouteKey = null;
      _tripOverlay.value = (
        legs: const <List<LatLng>>[],
        markers: const <Marker>{},
        legsAreDashed: false,
      );
      return;
    }

    final stage = tripState.sheetStage;
    final beforePickup = stage == TripSheetStage.incoming ||
        stage == TripSheetStage.toPickup;

    // Always read the stops in their canonical order so multi-stop routes
    // never zig-zag because of a stale insertion order from the backend.
    final orderedStops = List<TripStopEntity>.of(trip.stops)
      ..sort((a, b) => a.sequence.compareTo(b.sequence));

    final key = '${trip.id}|${stage.name}|$beforePickup';
    if (key == _lastRouteKey) return;
    _lastRouteKey = key;

    // Markers are local; show them immediately while the route is being
    // computed so the map never appears empty during the fetch.
    final markers = _buildTripMarkers(trip, beforePickup: beforePickup);
    _tripOverlay.value = (
      legs: _tripOverlay.value.legs,
      markers: markers,
      legsAreDashed: _tripOverlay.value.legsAreDashed,
    );

    final List<List<LatLng>> legs;
    final List<LatLng> fallbackPoints;
    final bool legsAreDashed;

    if (beforePickup) {
      final stops = <LatLng>[
        LatLng(_currentLocation.latitude, _currentLocation.longitude),
        LatLng(pickup.latitude, pickup.longitude),
      ];
      legs = await _directions.getLegPolylines(stops);
      fallbackPoints = stops;
      legsAreDashed = true;
    } else {
      final decoded = _decodeRouteSegments(trip);
      if (decoded.isNotEmpty) {
        legs = decoded;
      } else if (orderedStops.length >= 2) {
        legs = await _directions.getLegPolylines(
          orderedStops.map((s) => LatLng(s.latitude, s.longitude)).toList(),
        );
      } else {
        legs = const <List<LatLng>>[];
      }
      fallbackPoints =
          orderedStops.map((s) => LatLng(s.latitude, s.longitude)).toList();
      legsAreDashed = false;
    }

    if (!mounted || _lastRouteKey != key) return;

    _tripOverlay.value = (
      legs: legs,
      markers: markers,
      legsAreDashed: legsAreDashed,
    );
    _fitToRoute(legs, fallbackPoints);
  }

  /// Decodes the backend-stored `routeSegments` for a trip, falling back to
  /// the overview polyline. Results are cached per trip id so repeated stage
  /// changes don't re-decode the same payload.
  List<List<LatLng>> _decodeRouteSegments(TripEntity trip) {
    if (trip.routeSegments.isNotEmpty) {
      final cacheKey = '${trip.id}|segments';
      final cached = _decodedSegmentsCache[cacheKey];
      if (cached != null) return cached;

      final decoded = trip.routeSegments
          .map((segment) => PolylinePoints.decodePolyline(segment.encodedPolyline)
              .map((p) => LatLng(p.latitude, p.longitude))
              .toList())
          .where((leg) => leg.isNotEmpty)
          .toList();

      if (decoded.isNotEmpty) {
        _decodedSegmentsCache[cacheKey] = decoded;
        return decoded;
      }
    }

    final overview = trip.encodedOverviewPolyline;
    if (overview != null && overview.isNotEmpty) {
      final cacheKey = '${trip.id}|overview';
      final cached = _decodedSegmentsCache[cacheKey];
      if (cached != null) return cached;

      final decoded = PolylinePoints.decodePolyline(overview)
          .map((p) => LatLng(p.latitude, p.longitude))
          .toList();

      if (decoded.isNotEmpty) {
        final result = <List<LatLng>>[decoded];
        _decodedSegmentsCache[cacheKey] = result;
        return result;
      }
    }

    return const <List<LatLng>>[];
  }

  /// Builds the marker set for an active trip, mirroring the customer app's
  /// ActiveTripBody:
  /// - Pickup ("A" circle, orange).
  /// - Each intermediate stop colored by progress — next uncompleted = red,
  ///   already completed = green, future = violet.
  /// - Dropoff ("B" circle, blue).
  ///
  /// Falls back to default Google hue pins for the pickup/dropoff icons
  /// while the canvas-rendered A/B images are still loading.
  Set<Marker> _buildTripMarkers(TripEntity trip, {required bool beforePickup}) {
    final markers = <Marker>{};
    final ordered = List<TripStopEntity>.of(trip.stops)
      ..sort((a, b) => a.sequence.compareTo(b.sequence));
    if (ordered.isEmpty) return markers;

    int nextStopIndex = -1;
    for (var i = 0; i < ordered.length; i++) {
      if (!ordered[i].isCompleted) {
        nextStopIndex = i;
        break;
      }
    }

    for (var i = 0; i < ordered.length; i++) {
      final stop = ordered[i];
      final isPickup = i == 0;
      final isDestination = i == ordered.length - 1 && ordered.length > 1;
      final isNext = i == nextStopIndex;

      // Intermediate stops are only visible once we're past pickup phase, to
      // match the existing "show full route after pickup" behaviour.
      if (!isPickup && !isDestination && beforePickup) continue;

      final BitmapDescriptor descriptor;
      if (isPickup) {
        descriptor = _pickupMarkerIcon ??
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange);
      } else if (isDestination) {
        descriptor = _destinationMarkerIcon ??
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
      } else if (isNext) {
        descriptor = BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueRed,
        );
      } else if (stop.isCompleted) {
        descriptor = BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueGreen,
        );
      } else {
        descriptor = BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueViolet,
        );
      }

      // Title: actual address label when known, else the customer-app fallback
      // ("Pickup" / "Drop-off" / "Stop N").
      final hasAddress = stop.label != null && stop.label!.trim().isNotEmpty;
      final String fallback;
      if (isPickup) {
        fallback = AppStrings.tripPickup;
      } else if (isDestination) {
        fallback = AppStrings.tripDropoff;
      } else {
        fallback = AppStrings.tripStopNumber.trParams({'number': '$i'});
      }
      final title = hasAddress ? stop.label! : fallback;

      // Snippet: progress hint, same wording the customer app shows.
      final String? snippet;
      if (stop.isCompleted) {
        snippet = AppStrings.tripStopCompleted;
      } else if (isNext && !isPickup) {
        snippet = AppStrings.tripNextStop;
      } else if (!isPickup && !isDestination) {
        snippet = AppStrings.tripStopUpcoming;
      } else {
        snippet = null;
      }

      markers.add(
        Marker(
          markerId: MarkerId('trip-stop-${stop.sequence}-$i'),
          position: LatLng(stop.latitude, stop.longitude),
          icon: descriptor,
          infoWindow: InfoWindow(title: title, snippet: snippet),
        ),
      );
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
                legsAreDashed: overlay.legsAreDashed,
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
