import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:dashboardtaxi/features/trip/presentation/states/trip_bloc.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/dialogs/driver_trip_cancellation_dialog.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_admin_cancel_button.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_customer_contact_widget.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_route_card_widget.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_status_chip_widget.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_waiting_indicator_widget.dart';

/// Stage 3: driver has arrived at the pickup. Customer has been notified.
/// Primary action puts the trip in progress. Secondary actions cover the
/// waiting timer and (after 10 minutes) no-show cancellation.
class TripAtPickupSheet extends StatelessWidget {
  const TripAtPickupSheet({super.key, required this.trip, required this.state});

  final TripEntity trip;
  final TripState state;

  @override
  Widget build(BuildContext context) {
    final session = trip.activeWaitingSession;
    final arrivedAt = state.arrivedAt;
    final tenMinPassed =
        arrivedAt != null &&
        DateTime.now().difference(arrivedAt) >= const Duration(minutes: 10);

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
          AppStrings.tripArrivedHint,
          style: AppTextStyles.s12w400.copyWith(
            color: context.onSurface.withValues(alpha: 0.60),
          ),
        ),
        AppSpacing.md.verticalSpace,
        TripRouteCardWidget(trip: trip),
        AppSpacing.sm.verticalSpace,
        TripCustomerContactWidget(trip: trip),
        AppSpacing.md.verticalSpace,
        AppButton.primary(
          isLoading: state.startTripState.isLoading,
          layout: const AppButtonLayout(height: 52),
          onTap: () => context.read<TripBloc>().add(
            TripEvent.startTripRequested(trip.id),
          ),
          child: AppButtonChild.labelIcon(
            label: AppStrings.tripStartRide,
            icon: IconSource.widget(
              FaIcon(FontAwesomeIcons.play, size: 14.r),
              size: 14,
            ),
            textStyle: AppTextStyles.s14w600,
          ),
        ),
        AppSpacing.sm.verticalSpace,
        if (session == null || !session.isActive)
          AppButton.outline(
            isLoading: state.startWaitingState.isLoading,
            layout: const AppButtonLayout(height: 44),
            onTap: () => context.read<TripBloc>().add(
              TripEvent.startWaitingRequested(trip.id),
            ),
            child: AppButtonChild.labelIcon(
              label: AppStrings.startWaiting,
              icon: IconSource.widget(
                FaIcon(FontAwesomeIcons.clock, size: 14.r),
                size: 14,
              ),
              textStyle: AppTextStyles.s14w500,
            ),
          )
        else ...[
          TripWaitingIndicatorWidget(session: session),
          AppSpacing.sm.verticalSpace,
          AppButton.outline(
            isLoading: state.stopWaitingState.isLoading,
            layout: const AppButtonLayout(height: 44),
            onTap: () => context.read<TripBloc>().add(
              TripEvent.stopWaitingRequested(trip.id),
            ),
            child: AppButtonChild.labelIcon(
              label: AppStrings.stopWaiting,
              icon: IconSource.widget(
                FaIcon(FontAwesomeIcons.circleStop, size: 14.r),
                size: 14,
              ),
              textStyle: AppTextStyles.s14w500,
            ),
          ),
        ],
        if (tenMinPassed) ...[
          AppSpacing.md.verticalSpace,
          AppButton.outline(
            variant: AppButtonVariant.error,
            isLoading: state.driverCancelState.isLoading,
            layout: const AppButtonLayout(height: 44),
            onTap: () => DriverTripCancellationDialog.show(context, trip.id),
            child: AppButtonChild.labelIcon(
              label: AppStrings.passengerLateNoShowTitle,
              icon: IconSource.widget(
                FaIcon(FontAwesomeIcons.userSlash, size: 14.r),
                size: 14,
              ),
              textStyle: AppTextStyles.s14w500,
            ),
          ),
        ],
        AppSpacing.sm.verticalSpace,
        TripAdminCancelButton(
          tripId: trip.id,
          isLoading: state.adminCancelState.isLoading,
        ),
      ],
    );
  }
}
