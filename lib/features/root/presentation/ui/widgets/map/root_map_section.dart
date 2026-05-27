import 'dart:ui' show lerpDouble;

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/common/widgets/show_overlay.dart';
import 'package:dashboardtaxi/features/driver_home/presentation/states/driver_home_bloc.dart';
import 'package:dashboardtaxi/features/root/constants/root_constants.dart';
import 'package:dashboardtaxi/features/root/domain/entities/root_map_location_entity.dart';
import 'package:dashboardtaxi/features/root/presentation/states/root_bloc.dart';
import 'package:dashboardtaxi/utils/constants/app_flow_constants.dart';

import 'root_map_canvas_widget.dart';
import 'root_map_controls_section.dart';

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
    _mapController?.dispose();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    printG('[RootMapSection] onMapCreated');
    _mapController = controller;
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<RootBloc, RootState>(
      listenWhen: (previous, current) =>
          previous.recenterState != current.recenterState,
      listener: _handleRecenterState,
      child: Stack(
        fit: StackFit.expand,
        children: [
          BlocBuilder<DriverHomeBloc, DriverHomeState>(
            buildWhen: (prev, curr) => prev.isOnline != curr.isOnline,
            builder: (context, homeState) {
              final marker = Marker(
                markerId: const MarkerId('driver_position'),
                position: LatLng(
                  _currentLocation.latitude,
                  _currentLocation.longitude,
                ),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  homeState.isOnline
                      ? BitmapDescriptor.hueGreen
                      : BitmapDescriptor.hueRed,
                ),
              );
              return RootMapCanvasWidget(
                currentLocation: _currentLocation,
                driverMarker: marker,
                onMapCreated: _onMapCreated,
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
