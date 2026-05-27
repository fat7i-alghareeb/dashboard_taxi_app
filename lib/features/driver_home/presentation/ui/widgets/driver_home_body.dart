import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/common/widgets/show_overlay.dart';
import 'package:dashboardtaxi/core/domain/extensions/user_role_extensions.dart';
import 'package:dashboardtaxi/core/services/location/location_service.dart';
import 'package:dashboardtaxi/core/services/session/auth_manager.dart';
import 'package:dashboardtaxi/core/theme/app_map_styles.dart';
import 'package:dashboardtaxi/features/driver_home/presentation/states/driver_home_bloc.dart';
import 'package:dashboardtaxi/features/driver_home/presentation/ui/widgets/driver_home_connection_pill_widget.dart';
import 'package:dashboardtaxi/features/driver_home/presentation/ui/widgets/driver_home_controls_panel_widget.dart';
import 'package:dashboardtaxi/features/trip/presentation/states/trip_bloc.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/sheet/trip_sheet_section.dart';

class DriverHomeBody extends StatefulWidget {
  const DriverHomeBody({super.key});

  @override
  State<DriverHomeBody> createState() => _DriverHomeBodyState();
}

class _DriverHomeBodyState extends State<DriverHomeBody> {
  GoogleMapController? _mapController;
  LatLng _currentLocation = const LatLng(52.3676, 4.9041);
  StreamSubscription<Position>? _mapPositionSub;
  bool _isMapReady = false;

  @override
  void initState() {
    super.initState();
    _initLiveLocationTracking();
  }

  /// Returns true when the OS has granted location access.
  ///
  /// Walks through the full geolocator permission flow:
  /// device service check → rationale request → settings redirect on
  /// permanent denial.
  Future<bool> _ensureLocationPermission() async {
    final locationService = getIt<LocationService>();

    final serviceEnabled = await locationService.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppStrings.locationServiceDisabled)),
        );
      }
      return false;
    }

    var permission = await locationService.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await locationService.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppStrings.locationPermissionPermanentlyDenied),
            action: SnackBarAction(
              label: AppStrings.openSettings,
              onPressed: Geolocator.openAppSettings,
            ),
          ),
        );
      }
      return false;
    }

    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  Future<void> _initLiveLocationTracking() async {
    final granted = await _ensureLocationPermission();
    if (!granted) return;

    final locationService = getIt<LocationService>();
    try {
      final initialPosition = await locationService.getCurrentPosition();
      if (mounted) {
        setState(() {
          _currentLocation = LatLng(
            initialPosition.latitude,
            initialPosition.longitude,
          );
        });
        _moveCameraToPosition(_currentLocation);
      }
    } catch (_) {}

    _mapPositionSub = locationService
        .getPositionStream(distanceFilter: 10)
        .listen((position) {
          if (mounted) {
            setState(() {
              _currentLocation = LatLng(position.latitude, position.longitude);
            });
            _moveCameraToPosition(_currentLocation);
          }
        });
  }

  void _moveCameraToPosition(LatLng pos) {
    if (_mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(target: pos, zoom: 16)),
      );
    }
  }

  @override
  void dispose() {
    _mapPositionSub?.cancel();
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDriver = getIt<AuthManager>().currentUser.isDriver;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<DriverHomeBloc>()..add(const DriverHomeEvent.started()),
        ),
        // TripBloc is a lazy singleton (so FCM/SignalR can reach it from
        // outside the widget tree). Use `.value` to avoid closing it on
        // widget dispose.
        BlocProvider<TripBloc>.value(
          value: getIt<TripBloc>()..add(const TripEvent.started()),
        ),
      ],
      child: BlocConsumer<DriverHomeBloc, DriverHomeState>(
        listener: (context, state) {
          state.statusState.maybeWhen(
            loading: () {
              showLoadingOverlay(context, AppStrings.uploading);
            },
            success: (_) {
              clearAllOverlays();
              final successMsg = state.isOnline
                  ? AppStrings.driverNowOnline
                  : AppStrings.driverNowOffline;
              showSuccessOverlay(context, successMsg);
            },
            failure: (message) {
              clearAllOverlays();
              showErrorOverlay(context, message);
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          final isOnline = state.isOnline;
          final isLoading = state.statusState.isLoading;

          return Stack(
            children: [
              Positioned.fill(
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _currentLocation,
                    zoom: 15,
                  ),
                  style: context.isDarkTheme ? AppMapStyles.dark : null,
                  onMapCreated: (controller) {
                    _mapController = controller;
                    setState(() {
                      _isMapReady = true;
                    });
                  },
                  markers: {
                    Marker(
                      markerId: const MarkerId('driver_position'),
                      position: _currentLocation,
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                        isOnline
                            ? BitmapDescriptor.hueGreen
                            : BitmapDescriptor.hueRed,
                      ),
                    ),
                  },
                ),
              ),
              if (!_isMapReady)
                Positioned.fill(
                  child: Container(
                    color: context.surface,
                    child: const Center(child: MainLoadingProgress()),
                  ),
                ),
              Positioned(
                top: AppSpacing.md.h,
                left: 0,
                right: 0,
                child: Center(
                  child: DriverHomeConnectionPillWidget(
                    connectionState: state.connectionState,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: TripSheetSection(
                  idleBuilder: (context) => isDriver
                      ? Padding(
                          padding: REdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                          ),
                          child: DriverHomeControlsPanelWidget(
                            state: state,
                            isOnline: isOnline,
                            isLoading: isLoading,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
