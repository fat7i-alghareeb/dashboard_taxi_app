import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/common/widgets/show_overlay.dart';
import 'package:dashboardtaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:dashboardtaxi/features/trip/presentation/states/trip_bloc.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_assignment_panel_widget.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_execution_card_widget.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_loading_shimmer_widget.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_summary_panel_widget.dart';

class TripActiveOverlayWidget extends StatelessWidget {
  const TripActiveOverlayWidget({super.key, required this.idleBuilder});

  final Widget Function(BuildContext context) idleBuilder;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TripBloc, TripState>(
      listenWhen: (previous, current) {
        return previous.activeTripState != current.activeTripState ||
            previous.markEnRouteState != current.markEnRouteState ||
            previous.markArrivedState != current.markArrivedState ||
            previous.startTripState != current.startTripState ||
            previous.completeTripState != current.completeTripState;
      },
      listener: (context, state) {
        for (final status in <BlocStatus<void>>[
          state.markEnRouteState,
          state.markArrivedState,
          state.startTripState,
          state.completeTripState,
        ]) {
          status.maybeWhen(
            failure: (message) => showErrorOverlay(context, message),
            orElse: () {},
          );
        }

        state.activeTripState.maybeWhen(
          failure: (message) => showErrorOverlay(context, message),
          orElse: () {},
        );
      },
      builder: (context, state) {
        final completedTrip = state.completedTrip;
        if (completedTrip != null) {
          return TripSummaryPanelWidget(trip: completedTrip);
        }

        final activeTrip = state.activeTrip;
        if (activeTrip == null) {
          return idleBuilder(context);
        }

        if (state.activeTripState.isLoading &&
            activeTrip.status == TripStatus.driverAssigned) {
          return const TripLoadingShimmerWidget();
        }

        if (activeTrip.status == TripStatus.driverAssigned) {
          return TripExecutionCardWidget(trip: activeTrip, state: state);
        }

        return TripExecutionCardWidget(trip: activeTrip, state: state);
      },
    );
  }
}

class TripAssignmentStackOverlayWidget extends StatelessWidget {
  const TripAssignmentStackOverlayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripBloc, TripState>(
      buildWhen: (previous, current) =>
          previous.activeTrip != current.activeTrip,
      builder: (context, state) {
        final trip = state.activeTrip;
        if (trip == null || trip.status != TripStatus.driverAssigned) {
          return const SizedBox.shrink();
        }

        return TripAssignmentPanelWidget(trip: trip, state: state);
      },
    );
  }
}
