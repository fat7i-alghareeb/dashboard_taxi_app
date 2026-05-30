import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:dashboardtaxi/features/trip/presentation/states/trip_bloc.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_customer_contact_widget.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_route_card_widget.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_status_chip_widget.dart';

/// Stage 4: trip is in progress.
///
/// For a single-stop trip (`stops = [pickup, dropoff]`) we show a single
/// "Finish trip" action. For multi-stop trips we walk through each
/// intermediate stop, calling `POST /trips/{id}/stops/{seq}/complete` per
/// stop. Progress is sourced from [TripState.completedStops], populated by
/// the bloc when the call succeeds or the `TripStopCompleted` SignalR push
/// arrives — whichever lands first.
///
/// The list index of each stop in [TripEntity.stops] is used as the sequence
/// the backend expects, matching how the trip was created.
class TripInProgressSheet extends StatelessWidget {
  const TripInProgressSheet({
    super.key,
    required this.trip,
    required this.state,
  });

  final TripEntity trip;
  final TripState state;

  @override
  Widget build(BuildContext context) {
    // Intermediate stops live between index 1 (after pickup) and stops.length-2
    // (before dropoff). For a single-stop trip these indices form an empty range.
    final intermediateIndices = <int>[
      for (var i = 1; i < trip.stops.length - 1; i++) i,
    ];
    final pendingIndices = intermediateIndices
        .where((i) => !state.completedStops.contains(i))
        .toList();
    final hasMultiStop = intermediateIndices.isNotEmpty;
    final onFinalLeg = pendingIndices.isEmpty;

    final totalIntermediate = intermediateIndices.length;
    final currentNumber = hasMultiStop && !onFinalLeg
        ? totalIntermediate - pendingIndices.length + 1
        : 0;
    final isSavingStop = state.completeStopState.isLoading;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                AppStrings.tripReferenceCode.replaceAll(
                  '{code}',
                  trip.referenceCode,
                ),
                style: AppTextStyles.s16w600.copyWith(color: context.onSurface),
              ),
            ),
            AppSpacing.sm.horizontalSpace,
            TripStatusChipWidget(status: trip.status),
          ],
        ),
        AppSpacing.sm.verticalSpace,
        Text(
          hasMultiStop && !onFinalLeg
              ? AppStrings.tripStopProgress(currentNumber, totalIntermediate)
              : AppStrings.tripInProgressHint,
          style: AppTextStyles.s12w400.copyWith(
            color: context.onSurface.withValues(alpha: 0.60),
          ),
        ),
        AppSpacing.md.verticalSpace,
        TripRouteCardWidget(trip: trip),
        AppSpacing.sm.verticalSpace,
        TripCustomerContactWidget(trip: trip),
        AppSpacing.md.verticalSpace,
        if (hasMultiStop && !onFinalLeg)
          AppButton.primary(
            isLoading: isSavingStop,
            layout: const AppButtonLayout(height: 52),
            onTap: () {
              context.read<TripBloc>().add(
                TripEvent.completeStopRequested(
                  tripId: trip.id,
                  sequence: pendingIndices.first,
                ),
              );
            },
            child: AppButtonChild.labelIcon(
              label: AppStrings.tripFinishStop(currentNumber, totalIntermediate),
              icon: IconSource.widget(
                FaIcon(FontAwesomeIcons.flagCheckered, size: 14.r),
                size: 14,
              ),
              textStyle: AppTextStyles.s14w600,
            ),
          )
        else
          AppButton.primary(
            isLoading: state.completeTripState.isLoading,
            layout: const AppButtonLayout(height: 52),
            onTap: () => context.read<TripBloc>().add(
              TripEvent.completeTripRequested(trip.id),
            ),
            child: AppButtonChild.labelIcon(
              label: AppStrings.tripCompleteRide,
              icon: IconSource.widget(
                FaIcon(FontAwesomeIcons.circleCheck, size: 14.r),
                size: 14,
              ),
              textStyle: AppTextStyles.s14w600,
            ),
          ),
      ],
    );
  }
}
