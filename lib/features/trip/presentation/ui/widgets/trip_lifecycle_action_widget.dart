import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:dashboardtaxi/features/trip/presentation/states/trip_bloc.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/dialogs/driver_trip_cancellation_dialog.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_waiting_indicator_widget.dart';

class TripLifecycleActionWidget extends StatefulWidget {
  const TripLifecycleActionWidget({
    super.key,
    required this.trip,
    required this.state,
  });

  final TripEntity trip;
  final TripState state;

  @override
  State<TripLifecycleActionWidget> createState() =>
      _TripLifecycleActionWidgetState();
}

class _TripLifecycleActionWidgetState extends State<TripLifecycleActionWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.trip.status == TripStatus.driverArrived) {
      return _buildArrivedActions(context);
    }
    return _buildPrimaryAction(context, _config);
  }

  Widget _buildPrimaryAction(BuildContext context, _LifecycleConfig config) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          config.hint,
          style: AppTextStyles.s12w400.copyWith(
            color: context.onSurface.withValues(alpha: 0.60),
          ),
        ),
        AppSpacing.md.verticalSpace,
        AppButton.primary(
          isLoading: config.isLoading,
          layout: const AppButtonLayout(height: 52),
          onTap: () => context.read<TripBloc>().add(config.event),
          child: AppButtonChild.labelIcon(
            label: config.label,
            icon: IconSource.widget(FaIcon(config.icon, size: 14.r), size: 14),
            textStyle: AppTextStyles.s14w600,
          ),
        ),
      ],
    );
  }

  Widget _buildArrivedActions(BuildContext context) {
    final session = widget.trip.activeWaitingSession;
    final arrivedAt = widget.state.arrivedAt;
    final tenMinPassed =
        arrivedAt != null &&
        DateTime.now().difference(arrivedAt) >= const Duration(minutes: 10);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppStrings.tripArrivedHint,
          style: AppTextStyles.s12w400.copyWith(
            color: context.onSurface.withValues(alpha: 0.60),
          ),
        ),
        AppSpacing.md.verticalSpace,
        AppButton.primary(
          isLoading: widget.state.startTripState.isLoading,
          layout: const AppButtonLayout(height: 52),
          onTap: () => context.read<TripBloc>().add(
            TripEvent.startTripRequested(widget.trip.id),
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
            isLoading: widget.state.startWaitingState.isLoading,
            layout: const AppButtonLayout(height: 44),
            onTap: () => context.read<TripBloc>().add(
              TripEvent.startWaitingRequested(widget.trip.id),
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
            isLoading: widget.state.stopWaitingState.isLoading,
            layout: const AppButtonLayout(height: 44),
            onTap: () => context.read<TripBloc>().add(
              TripEvent.stopWaitingRequested(widget.trip.id),
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
          AppSpacing.xs.verticalSpace,
          Text(
            AppStrings.waitingPolicyNote,
            textAlign: TextAlign.center,
            style: AppTextStyles.s12w400.copyWith(
              color: context.onSurface.withValues(alpha: 0.45),
            ),
          ),
        ],
        if (tenMinPassed) ...[
          AppSpacing.md.verticalSpace,
          AppButton.outline(
            variant: AppButtonVariant.error,
            isLoading: widget.state.driverCancelState.isLoading,
            layout: const AppButtonLayout(height: 44),
            onTap: () =>
                DriverTripCancellationDialog.show(context, widget.trip.id),
            child: AppButtonChild.labelIcon(
              label: AppStrings.passengerLateNoShowTitle,
              icon: IconSource.widget(
                FaIcon(FontAwesomeIcons.userSlash, size: 14.r),
                size: 14,
              ),
              textStyle: AppTextStyles.s14w500,
            ),
          ),
          AppSpacing.xs.verticalSpace,
          Text(
            AppStrings.cancelNoShowPolicyNote,
            textAlign: TextAlign.center,
            style: AppTextStyles.s12w400.copyWith(
              color: context.onSurface.withValues(alpha: 0.45),
            ),
          ),
        ],
      ],
    );
  }

  _LifecycleConfig get _config {
    return switch (widget.trip.status) {
      TripStatus.driverAssigned => _LifecycleConfig(
        label: AppStrings.tripStartEnRouteNavigation,
        hint: AppStrings.tripAssignedHint,
        icon: FontAwesomeIcons.route,
        isLoading: widget.state.markEnRouteState.isLoading,
        event: TripEvent.markEnRouteRequested(widget.trip.id),
      ),
      TripStatus.driverEnRoute => _LifecycleConfig(
        label: AppStrings.tripHaveArrived,
        hint: AppStrings.tripEnRouteHint,
        icon: FontAwesomeIcons.locationDot,
        isLoading: widget.state.markArrivedState.isLoading,
        event: TripEvent.markArrivedRequested(widget.trip.id),
      ),
      TripStatus.inProgress => _LifecycleConfig(
        label: AppStrings.tripCompleteRide,
        hint: AppStrings.tripInProgressHint,
        icon: FontAwesomeIcons.circleCheck,
        isLoading: widget.state.completeTripState.isLoading,
        event: TripEvent.completeTripRequested(widget.trip.id),
      ),
      _ => _LifecycleConfig(
        label: AppStrings.done,
        hint: AppStrings.tripActiveRide,
        icon: FontAwesomeIcons.circleCheck,
        isLoading: false,
        event: const TripEvent.clearCompletedSummaryRequested(),
      ),
    };
  }
}

class _LifecycleConfig {
  const _LifecycleConfig({
    required this.label,
    required this.hint,
    required this.icon,
    required this.isLoading,
    required this.event,
  });

  final String label;
  final String hint;
  final IconData icon;
  final bool isLoading;
  final TripEvent event;
}
