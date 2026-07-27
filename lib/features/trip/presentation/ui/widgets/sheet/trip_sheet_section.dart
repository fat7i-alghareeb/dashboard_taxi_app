import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/common/widgets/show_overlay.dart';
import 'package:dashboardtaxi/features/trip/presentation/states/trip_bloc.dart';
import 'package:dashboardtaxi/features/trip/presentation/states/trip_sheet_stage.dart';

import 'stages/trip_at_pickup_sheet.dart';
import 'stages/trip_in_progress_sheet.dart';
import 'stages/trip_incoming_sheet.dart';
import 'stages/trip_pending_assignment_sheet.dart';
import 'stages/trip_readonly_sheet.dart';
import 'stages/trip_summary_sheet.dart';
import 'stages/trip_to_pickup_sheet.dart';

/// Persistent bottom panel that mirrors the customer app's
/// `OrderSheetSection` pattern: a single sheet host that swaps content via
/// `AnimatedSwitcher` based on the trip lifecycle stage.
class TripSheetSection extends StatelessWidget {
  const TripSheetSection({super.key, this.idleBuilder, this.onCollapse});

  /// Rendered while no active or completed trip exists. Drivers see their
  /// online/offline controls here; admins typically render an empty box.
  final WidgetBuilder? idleBuilder;
  final VoidCallback? onCollapse;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      // Surface server-side failures for every trip lifecycle action (e.g. the
      // "This ride is owned by {admin}" 403) as an error overlay. The bloc only
      // emits these into their BlocStatus.failure(message); without these
      // listeners the message is logged but never shown to the operator.
      listeners: [
        _failureOverlayListener((s) => s.markEnRouteState),
        _failureOverlayListener((s) => s.markArrivedState),
        _failureOverlayListener((s) => s.startTripState),
        _failureOverlayListener((s) => s.completeTripState),
        _failureOverlayListener((s) => s.completeStopState),
        _failureOverlayListener((s) => s.driverCancelState),
        // Loading the picked trip itself can fail too — without this the tap
        // just looked like nothing happened.
        _failureOverlayListener((s) => s.activeTripState),
      ],
      child: _buildSheet(context),
    );
  }

  /// Builds a listener that shows an error overlay whenever the selected
  /// action state transitions into a failure.
  BlocListener<TripBloc, TripState> _failureOverlayListener(
    BlocStatus<dynamic> Function(TripState state) select,
  ) {
    return BlocListener<TripBloc, TripState>(
      listenWhen: (prev, curr) => select(prev) != select(curr),
      listener: (context, state) => select(state).whenOrNull(
        failure: (message) => showErrorOverlay(context, message),
      ),
    );
  }

  Widget _buildSheet(BuildContext context) {
    return BlocBuilder<TripBloc, TripState>(
      buildWhen: (a, b) =>
          a.sheetStage != b.sheetStage ||
          a.activeTripState != b.activeTripState ||
          a.activeTrip != b.activeTrip ||
          a.completedTrip != b.completedTrip ||
          a.pendingTrips != b.pendingTrips ||
          a.adminSelfAssignState != b.adminSelfAssignState ||
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

        // Collapsing only makes sense once there is a trip to collapse into.
        final canCollapse =
            stage != TripSheetStage.idle &&
            stage != TripSheetStage.loading &&
            stage != TripSheetStage.error;

        return _TripSheetChrome(
          onCollapse: canCollapse ? onCollapse : null,
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
      case TripSheetStage.loading:
        return const _TripSheetLoading();
      case TripSheetStage.error:
        final tripId = state.selectedTripId;
        return FailedStateWidget(
          message: state.activeTripState.errorMessage,
          iconSize: 56,
          onRetrying: tripId == null
              ? null
              : () => context.read<TripBloc>().add(
                  TripEvent.tripSelected(tripId),
                ),
        );
      case TripSheetStage.pendingAssignment:
        final trip = state.activeTrip;
        if (trip == null) return const SizedBox.shrink();
        return TripPendingAssignmentSheet(trip: trip, state: state);
      case TripSheetStage.readonly:
        final trip = state.activeTrip;
        if (trip == null) return const SizedBox.shrink();
        return TripReadonlySheet(trip: trip);
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

/// Skeleton shown between the tap and the trip arriving. Its whole job is to
/// make the sheet slide up on the next frame so a tap is never silent.
class _TripSheetLoading extends StatelessWidget {
  const _TripSheetLoading();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: AppShimmer.box(
                width: 140,
                height: 18,
                borderRadius: AppRadii.sm,
              ),
            ),
            AppSpacing.sm.horizontalSpace,
            AppShimmer.box(width: 64, height: 18, borderRadius: AppRadii.sm),
          ],
        ),
        AppSpacing.md.verticalSpace,
        AppShimmer.box(
          width: double.infinity,
          height: 14,
          borderRadius: AppRadii.sm,
        ),
        AppSpacing.sm.verticalSpace,
        AppShimmer.box(width: 200, height: 14, borderRadius: AppRadii.sm),
        AppSpacing.lg.verticalSpace,
        AppShimmer.box(
          width: double.infinity,
          height: 48,
          borderRadius: AppRadii.lg,
        ),
      ],
    );
  }
}

class _TripSheetChrome extends StatelessWidget {
  const _TripSheetChrome({required this.child, this.onCollapse});

  final Widget child;
  final VoidCallback? onCollapse;

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
              SizedBox(
                height: 44.r,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    _DragHandle(),
                    if (onCollapse != null)
                      PositionedDirectional(
                        start: 0,
                        top: 0,
                        bottom: 0,
                        child: _SheetHeaderButton(
                          tooltip: AppStrings.collapseTripSheet,
                          icon: Icons.keyboard_arrow_down_rounded,
                          onPressed: onCollapse!,
                        ),
                      ),
                    PositionedDirectional(
                      end: 0,
                      top: 0,
                      bottom: 0,
                      child: _SheetHeaderButton(
                        tooltip: AppStrings.cancel,
                        icon: Icons.close_rounded,
                        onPressed: () => context.read<TripBloc>().add(
                          const TripEvent.selectionCleared(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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

class _SheetHeaderButton extends StatelessWidget {
  const _SheetHeaderButton({
    required this.tooltip,
    required this.icon,
    required this.onPressed,
  });

  final String tooltip;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: SizedBox(
        width: 40.r,
        height: 40.r,
        child: Material(
          color: context.onSurface.withValues(alpha: 0.10),
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onPressed,
            child: Center(
              child: Icon(
                icon,
                size: 24.r,
                color: context.onSurface.withValues(alpha: 0.88),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
