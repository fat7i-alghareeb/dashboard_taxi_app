import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/common/widgets/stop_address_actions_widget.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';

/// Compact, in-card stop list used by the trips management row. Renders every
/// stop in the trip (pickup + intermediate waypoints + dropoff) with a
/// connecting timeline rail. Falls back to a two-line pickup/dropoff display
/// if the trip carries no stop list — keeps older payloads rendering safely.
class DashboardTripCardStopsWidget extends StatelessWidget {
  const DashboardTripCardStopsWidget({super.key, required this.trip});

  final DashboardTripEntity trip;

  @override
  Widget build(BuildContext context) {
    final stops = trip.stops;
    final fallbackPickup = trip.pickupLabel ?? AppStrings.tripUnknownAddress;
    final fallbackDropoff = trip.dropoffLabel ?? AppStrings.tripUnknownAddress;

    if (stops.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _StopLine(
            label: fallbackPickup,
            kind: _StopKind.pickup,
            isLast: false,
            canOpenMap: false,
          ),
          _StopLine(
            label: fallbackDropoff,
            kind: _StopKind.dropoff,
            isLast: true,
            canOpenMap: false,
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (int i = 0; i < stops.length; i++)
          _StopLine(
            label: stops[i].displayLabel,
            kind: _resolveKind(i, stops.length),
            indexLabel: _indexLabel(i, stops.length),
            isLast: i == stops.length - 1,
            latitude: stops[i].latitude,
            longitude: stops[i].longitude,
          ),
      ],
    );
  }

  _StopKind _resolveKind(int index, int total) {
    if (index == 0) return _StopKind.pickup;
    if (index == total - 1) return _StopKind.dropoff;
    return _StopKind.intermediate;
  }

  /// For intermediate stops we show a small "1", "2"… inside the dot so the
  /// user can tell apart multiple waypoints at a glance. Pickup/dropoff
  /// already read as endpoints, so they don't need a number.
  String? _indexLabel(int index, int total) {
    if (index == 0 || index == total - 1) return null;
    return '$index';
  }
}

enum _StopKind { pickup, intermediate, dropoff }

class _StopLine extends StatelessWidget {
  const _StopLine({
    required this.label,
    required this.kind,
    required this.isLast,
    this.indexLabel,
    this.latitude,
    this.longitude,
    this.canOpenMap = true,
  });

  final String label;
  final _StopKind kind;
  final bool isLast;
  final String? indexLabel;
  final double? latitude;
  final double? longitude;
  final bool canOpenMap;

  @override
  Widget build(BuildContext context) {
    final dotColor = switch (kind) {
      _StopKind.pickup => context.primary,
      _StopKind.intermediate => AppColors.warning,
      _StopKind.dropoff => context.onSurface.withValues(alpha: 0.55),
    };

    final textOpacity = switch (kind) {
      _StopKind.pickup => 0.85,
      _StopKind.intermediate => 0.80,
      _StopKind.dropoff => 0.65,
    };

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 10.r,
                height: 10.r,
                margin: REdgeInsets.only(top: AppSpacing.xs),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
                child: indexLabel == null
                    ? null
                    : Text(
                        indexLabel!,
                        style: AppTextStyles.s11w500.copyWith(
                          color: Colors.white,
                          height: 1.0,
                          fontSize: 8.sp,
                        ),
                      ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 1.5.r,
                    margin: REdgeInsets.symmetric(vertical: AppSpacing.xs / 2),
                    color: context.onSurface.withValues(alpha: 0.15),
                  ),
                ),
            ],
          ),
          AppSpacing.sm.horizontalSpace,
          Expanded(
            child: Padding(
              padding: REdgeInsets.only(bottom: isLast ? 0 : AppSpacing.sm),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.s12w400.copyWith(
                        color: context.onSurface.withValues(alpha: textOpacity),
                      ),
                    ),
                  ),
                  AppSpacing.xs.horizontalSpace,
                  StopAddressActionsWidget(
                    address: label,
                    latitude: canOpenMap ? latitude : null,
                    longitude: canOpenMap ? longitude : null,
                    highlight: kind == _StopKind.pickup,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
