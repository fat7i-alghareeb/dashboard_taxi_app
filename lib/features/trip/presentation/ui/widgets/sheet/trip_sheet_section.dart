import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/trip/presentation/states/trip_bloc.dart';
import 'package:dashboardtaxi/features/trip/presentation/states/trip_sheet_stage.dart';

import 'stages/trip_admin_pending_sheet.dart';
import 'stages/trip_at_pickup_sheet.dart';
import 'stages/trip_in_progress_sheet.dart';
import 'stages/trip_incoming_sheet.dart';
import 'stages/trip_summary_sheet.dart';
import 'stages/trip_to_pickup_sheet.dart';

/// Persistent bottom panel that mirrors the customer app's
/// `OrderSheetSection` pattern: a single sheet host that swaps content via
/// `AnimatedSwitcher` based on the trip lifecycle stage.
class TripSheetSection extends StatelessWidget {
  const TripSheetSection({super.key, this.idleBuilder});

  /// Rendered while no active or completed trip exists. Drivers see their
  /// online/offline controls here; admins typically render an empty box.
  final WidgetBuilder? idleBuilder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripBloc, TripState>(
      buildWhen: (a, b) =>
          a.sheetStage != b.sheetStage ||
          a.activeTrip != b.activeTrip ||
          a.completedTrip != b.completedTrip ||
          a.markEnRouteState != b.markEnRouteState ||
          a.markArrivedState != b.markArrivedState ||
          a.startTripState != b.startTripState ||
          a.completeTripState != b.completeTripState,
      builder: (context, state) {
        final stage = state.sheetStage;

        // Idle + no idleBuilder (admin home): render absolutely nothing so the
        // map fills the screen — no chrome, no drag handle, no shadow.
        if (stage == TripSheetStage.idle && idleBuilder == null) {
          return const SizedBox.shrink();
        }

        return _TripSheetChrome(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 280),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: animation.drive(
                    Tween<Offset>(
                      begin: const Offset(0, 0.06),
                      end: Offset.zero,
                    ),
                  ),
                  child: child,
                ),
              );
            },
            layoutBuilder: (currentChild, previousChildren) {
              return Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[...previousChildren, ?currentChild],
              );
            },
            child: KeyedSubtree(
              key: ValueKey<TripSheetStage>(stage),
              child: _buildStageContent(context, state, stage),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStageContent(
    BuildContext context,
    TripState state,
    TripSheetStage stage,
  ) {
    switch (stage) {
      case TripSheetStage.idle:
        return idleBuilder?.call(context) ?? const SizedBox.shrink();
      case TripSheetStage.adminPending:
        final trip = state.pendingTrip;
        if (trip == null) return const SizedBox.shrink();
        return TripAdminPendingSheet(trip: trip, state: state);
      case TripSheetStage.incoming:
        final trip = state.activeTrip;
        if (trip == null) return const SizedBox.shrink();
        return TripIncomingSheet(trip: trip, state: state);
      case TripSheetStage.toPickup:
        final trip = state.activeTrip;
        if (trip == null) return const SizedBox.shrink();
        return TripToPickupSheet(trip: trip, state: state);
      case TripSheetStage.atPickup:
        final trip = state.activeTrip;
        if (trip == null) return const SizedBox.shrink();
        return TripAtPickupSheet(trip: trip, state: state);
      case TripSheetStage.inProgress:
        final trip = state.activeTrip;
        if (trip == null) return const SizedBox.shrink();
        return TripInProgressSheet(trip: trip, state: state);
      case TripSheetStage.summary:
        final trip = state.completedTrip;
        if (trip == null) return const SizedBox.shrink();
        return TripSummarySheet(trip: trip);
    }
  }
}

class _TripSheetChrome extends StatelessWidget {
  const _TripSheetChrome({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.only(
      topLeft: Radius.circular(20.r),
      topRight: Radius.circular(20.r),
    );
    return Material(
      color: context.colorScheme.surface,
      elevation: 12,
      borderRadius: radius,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: REdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.sm,
            AppSpacing.lg,
            AppSpacing.lg,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(child: _DragHandle()),
              AppSpacing.md.verticalSpace,
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class _DragHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64.w,
      height: 4.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: context.onSurface.withValues(alpha: 0.14),
      ),
    );
  }
}
