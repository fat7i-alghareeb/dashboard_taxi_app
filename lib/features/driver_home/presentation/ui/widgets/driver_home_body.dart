import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/common/widgets/show_overlay.dart';
import 'package:dashboardtaxi/core/services/location/location_service.dart';
import 'package:dashboardtaxi/core/services/realtime/realtime_connection_state.dart';
import 'package:dashboardtaxi/features/driver/domain/entities/driver_entity.dart';
import 'package:dashboardtaxi/features/driver_home/presentation/states/driver_home_bloc.dart';
import 'package:dashboardtaxi/features/trip/presentation/states/trip_bloc.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_active_overlay_widget.dart';
import 'driver_status_switch_widget.dart';

/// A premium, custom-styled dark-mode dashboard body for drivers.
///
/// Integrates a real-time Google Map showing driver's live coordinate pin,
/// dynamic earnings summaries inside glassmorphism floating cards, and
/// the high-frequency status switch coordinating web-sockets connectivity.
class DriverHomeBody extends StatefulWidget {
  const DriverHomeBody({super.key});

  @override
  State<DriverHomeBody> createState() => _DriverHomeBodyState();
}

class _DriverHomeBodyState extends State<DriverHomeBody> {
  GoogleMapController? _mapController;
  LatLng _currentLocation = const LatLng(
    52.3676,
    4.9041,
  ); // Default to Amsterdam
  StreamSubscription<Position>? _mapPositionSub;
  bool _isMapReady = false;

  static const String _darkMapStyle = '''
  [
    {"elementType": "geometry", "stylers": [{"color": "#1e1e24"}]},
    {"elementType": "labels.icon", "stylers": [{"visibility": "off"}]},
    {"elementType": "labels.text.fill", "stylers": [{"color": "#757575"}]},
    {"elementType": "labels.text.stroke", "stylers": [{"color": "#1e1e24"}]},
    {"featureType": "administrative", "elementType": "geometry", "stylers": [{"color": "#757575"}]},
    {"featureType": "poi", "elementType": "labels.text.fill", "stylers": [{"color": "#757575"}]},
    {"featureType": "poi.park", "elementType": "geometry", "stylers": [{"color": "#121216"}]},
    {"featureType": "poi.park", "elementType": "labels.text.fill", "stylers": [{"color": "#616161"}]},
    {"featureType": "road", "elementType": "geometry.fill", "stylers": [{"color": "#2c2c35"}]},
    {"featureType": "road", "elementType": "labels.text.fill", "stylers": [{"color": "#8a8a8a"}]},
    {"featureType": "road.highway", "elementType": "geometry", "stylers": [{"color": "#383845"}]},
    {"featureType": "water", "elementType": "geometry", "stylers": [{"color": "#0d0d11"}]},
    {"featureType": "water", "elementType": "labels.text.fill", "stylers": [{"color": "#3d3d3d"}]}
  ]
  ''';

  @override
  void initState() {
    super.initState();
    _initLiveLocationTracking();
  }

  Future<void> _initLiveLocationTracking() async {
    final locationService = getIt<LocationService>();

    // Obtain current position immediately to center the map
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

    // Listen to live movement updates
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<DriverHomeBloc>()..add(const DriverHomeEvent.started()),
        ),
        BlocProvider(
          create: (context) =>
              getIt<TripBloc>()..add(const TripEvent.started()),
        ),
      ],
      child: BlocConsumer<DriverHomeBloc, DriverHomeState>(
        listener: (context, state) {
          state.statusState.maybeWhen(
            loading: () {
              showLoadingOverlay(
                context,
                AppStrings.uploading,
              ); // use central loader overlay
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
              // 1. Sleek dark-mode Google Map view
              Positioned.fill(
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _currentLocation,
                    zoom: 15,
                  ),
                  style: _darkMapStyle,
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

              // 2. Glassy Header Banner showing Connectivity Status dot
              Positioned(
                top: AppSpacing.lg.h,
                left: AppSpacing.xl.w,
                right: AppSpacing.xl.w,
                child: SafeArea(child: _buildGlassyHeader(state)),
              ),

              // 3. Sliding / Floating Glassmorphic card overlay representing status switch & earnings
              Positioned(
                bottom: AppSpacing.xxl.h,
                left: AppSpacing.xl.w,
                right: AppSpacing.xl.w,
                child: TripActiveOverlayWidget(
                  idleBuilder: (context) => _buildGlassyControlPanel(
                    context,
                    state,
                    isOnline,
                    isLoading,
                  ),
                ),
              ),
              const TripAssignmentStackOverlayWidget(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildGlassyHeader(DriverHomeState state) {
    final conn = state.connectionState;

    Color statusColor = AppColors.error;
    String statusText = AppStrings.driverDisconnected;

    switch (conn) {
      case RealtimeConnectionState.connected:
        statusColor = AppColors.success;
        statusText = AppStrings.driverConnected;
        break;
      case RealtimeConnectionState.connecting:
      case RealtimeConnectionState.reconnecting:
        statusColor = AppColors.warning;
        statusText = AppStrings.driverReconnecting;
        break;
      case RealtimeConnectionState.disconnected:
        statusColor = AppColors.error;
        statusText = AppStrings.driverDisconnected;
        break;
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadii.md.r),
      child: Container(
        color: context.surface.withValues(alpha: 0.85),
        padding: REdgeInsets.symmetric(
          horizontal: AppSpacing.lg.w,
          vertical: AppSpacing.sm.h,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Glowing Connection Status Dot
            Container(
              width: 10.r,
              height: 10.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: statusColor,
                boxShadow: [
                  BoxShadow(
                    color: statusColor.withValues(alpha: 0.5),
                    blurRadius: 6.r,
                    spreadRadius: 2.r,
                  ),
                ],
              ),
            ),
            AppSpacing.sm.horizontalSpace,
            Text(
              statusText,
              style: AppTextStyles.s14w400.copyWith(
                color: context.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassyControlPanel(
    BuildContext context,
    DriverHomeState state,
    bool isOnline,
    bool isLoading,
  ) {
    final earnings = state.earningsState.getDataWhenSuccess ??
        const DriverEarningsEntity(
          totalTrips: 0,
          totalEarnings: 0,
          currencyCode: 'EUR',
          trips: [],
        );
    final earningsValue = state.earningsState.isLoading
        ? AppStrings.uploading
        : earnings.totalEarningsLabel;
    final tripsValue = state.earningsState.isLoading
        ? AppStrings.uploading
        : earnings.totalTrips.toString();

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadii.lg.r),
      child: Container(
        color: context.surface.withValues(alpha: 0.85),
        padding: REdgeInsets.all(AppSpacing.lg.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Earnings Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMetricColumn(
                  AppStrings.earningsToday,
                  earningsValue,
                  FontAwesomeIcons.circleDollarToSlot,
                  AppColors.success,
                ),
                Container(
                  width: 1.w,
                  height: 40.h,
                  color: context.onSurface.withValues(alpha: 0.1),
                ),
                _buildMetricColumn(
                  AppStrings.tripsCompletedToday,
                  tripsValue,
                  FontAwesomeIcons.route,
                  context.primary,
                ),
              ],
            ),
            AppSpacing.lg.verticalSpace,

            // Status Switch Widget
            DriverStatusSwitchWidget(
              isOnline: isOnline,
              isLoading: isLoading,
              onToggle: (nextState) {
                context.read<DriverHomeBloc>().add(
                  DriverHomeEvent.toggleStatusRequested(nextState),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricColumn(
    String label,
    String value,
    IconData icon,
    Color accentColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            FaIcon(icon, size: 14.r, color: accentColor),
            AppSpacing.xs.horizontalSpace,
            Text(
              label,
              style: AppTextStyles.s14w400.copyWith(
                color: context.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
        AppSpacing.xs.verticalSpace,
        Text(
          value,
          style: AppTextStyles.s24w700.copyWith(color: context.onSurface),
        ),
      ],
    );
  }
}
