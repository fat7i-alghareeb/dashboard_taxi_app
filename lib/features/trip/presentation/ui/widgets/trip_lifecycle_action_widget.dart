import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:dashboardtaxi/features/trip/presentation/states/trip_bloc.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/dialogs/driver_trip_cancellation_dialog.dart';

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

    final config = _config;
    return _buildPrimaryAction(context, config);
  }

  Widget _buildPrimaryAction(BuildContext context, _LifecycleConfig config) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          config.hint,
          style: AppTextStyles.s14w400.copyWith(
            color: context.onSurface.withValues(alpha: 0.68),
          ),
        ),
        AppSpacing.md.verticalSpace,
        AppButton.primaryGradient(
          isLoading: config.isLoading,
          onTap: () => context.read<TripBloc>().add(config.event),
          child: AppButtonChild.labelIcon(
            label: config.label,
            icon: IconSource.widget(FaIcon(config.icon, size: 16.r), size: 16),
            textStyle: AppTextStyles.s14w400.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildArrivedActions(BuildContext context) {
    final session = widget.trip.activeWaitingSession;
    final arrivedAt = widget.state.arrivedAt;
    final tenMinPassed = arrivedAt != null &&
        DateTime.now().difference(arrivedAt) >= const Duration(minutes: 10);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppStrings.tripArrivedHint,
          style: AppTextStyles.s14w400.copyWith(
            color: context.onSurface.withValues(alpha: 0.68),
          ),
        ),
        AppSpacing.md.verticalSpace,
        // Primary: start trip
        AppButton.primaryGradient(
          isLoading: widget.state.startTripState.isLoading,
          onTap: () => context
              .read<TripBloc>()
              .add(TripEvent.startTripRequested(widget.trip.id)),
          child: AppButtonChild.labelIcon(
            label: AppStrings.tripStartRide,
            icon: IconSource.widget(
              FaIcon(FontAwesomeIcons.play, size: 16.r),
              size: 16,
            ),
            textStyle:
                AppTextStyles.s14w400.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        AppSpacing.sm.verticalSpace,
        // Waiting: start or stop
        if (session == null || !session.isActive) ...[
          AppButton.variant(
            variant: AppButtonVariant.grey,
            fill: AppButtonFill.solid,
            isLoading: widget.state.startWaitingState.isLoading,
            onTap: () => context
                .read<TripBloc>()
                .add(TripEvent.startWaitingRequested(widget.trip.id)),
            child: AppButtonChild.labelIcon(
              label: AppStrings.startWaiting,
              icon: IconSource.widget(
                FaIcon(FontAwesomeIcons.clock, size: 16.r),
                size: 16,
              ),
            ),
          ),
        ] else ...[
          Container(
            padding: REdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: context.onSurface.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.clock,
                  size: 14.r,
                  color: context.onSurface.withValues(alpha: 0.6),
                ),
                AppSpacing.xs.horizontalSpace,
                if (session.minutes != null)
                  Text(
                    AppStrings.waitingMinutes
                        .replaceAll('{minutes}', '${session.minutes}'),
                    style: AppTextStyles.s14w400.copyWith(
                      color: context.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                if (session.estimatedFee != null) ...[
                  AppSpacing.xs.horizontalSpace,
                  Text(
                    AppStrings.waitingEstimatedFee.replaceAll(
                      '{fee}',
                      session.estimatedFee!.toStringAsFixed(2),
                    ),
                    style: AppTextStyles.s14w400.copyWith(
                      color: context.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ],
            ),
          ),
          AppSpacing.xs.verticalSpace,
          AppButton.variant(
            variant: AppButtonVariant.grey,
            fill: AppButtonFill.solid,
            isLoading: widget.state.stopWaitingState.isLoading,
            onTap: () => context
                .read<TripBloc>()
                .add(TripEvent.stopWaitingRequested(widget.trip.id)),
            child: AppButtonChild.labelIcon(
              label: AppStrings.stopWaiting,
              icon: IconSource.widget(
                FaIcon(FontAwesomeIcons.stopCircle, size: 16.r),
                size: 16,
              ),
            ),
          ),
          AppSpacing.xs.verticalSpace,
          Text(
            AppStrings.waitingPolicyNote,
            style: AppTextStyles.s12w400.copyWith(
              color: context.onSurface.withValues(alpha: 0.5),
            ),
            textAlign: TextAlign.center,
          ),
        ],
        // Cancel (no-show) — only after 10 minutes
        if (tenMinPassed) ...[
          AppSpacing.sm.verticalSpace,
          AppButton.variant(
            variant: AppButtonVariant.error,
            fill: AppButtonFill.solid,
            isLoading: widget.state.driverCancelState.isLoading,
            onTap: () => DriverTripCancellationDialog.show(
              context,
              widget.trip.id,
            ),
            child: AppButtonChild.labelIcon(
              label: AppStrings.passengerLateNoShowTitle,
              icon: IconSource.widget(
                FaIcon(FontAwesomeIcons.userSlash, size: 16.r),
                size: 16,
              ),
            ),
          ),
          AppSpacing.xs.verticalSpace,
          Text(
            AppStrings.cancelNoShowPolicyNote,
            style: AppTextStyles.s12w400.copyWith(
              color: context.onSurface.withValues(alpha: 0.5),
            ),
            textAlign: TextAlign.center,
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
