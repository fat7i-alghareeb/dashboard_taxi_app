import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:dashboardtaxi/features/trip/presentation/states/trip_bloc.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/dialogs/driver_trip_cancellation_dialog.dart';

/// Clock-skew tolerance for unlocking the scheduled-trip "Start" action. The
/// button activates up to this long before the booked time so a small phone vs
/// server clock difference doesn't reject the start right at the boundary
/// (mirrors the server-side tolerance in Trip.Start).
const Duration kScheduledStartSkew = Duration(minutes: 1);

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
    if (widget.trip.status == TripStatus.arrived) {
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
          isActive: config.isActive,
          layout: const AppButtonLayout(height: 52),
          onTapWhenInactive: config.onTapWhenInactive,
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
    final arrivedAt = widget.state.arrivedAt;
    final tenMinPassed =
        arrivedAt != null &&
        DateTime.now().difference(_effectiveWaitingStart(arrivedAt)) >=
            const Duration(minutes: 10);
    final scheduledStartAtLocal = widget.trip.scheduledAtUtc?.toLocal();
    final isScheduledStartNotReady =
        scheduledStartAtLocal != null &&
        scheduledStartAtLocal
            .subtract(kScheduledStartSkew)
            .isAfter(DateTime.now());
    final scheduledStartLabel = scheduledStartAtLocal?.toSmartDateTime() ?? '';

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
          isActive: !isScheduledStartNotReady,
          layout: const AppButtonLayout(height: 52),
          onTapWhenInactive: !isScheduledStartNotReady
              ? null
              : () async {
                  final nav = Navigator.of(context);
                  final bloc = context.read<TripBloc>();
                  final confirmed = await AppDialog.show<bool>(
                    context,
                    dialog: AppDialog.basic(
                      title: AppStrings.scheduledStartAdminOverrideTitle,
                      message: AppStrings.scheduledStartAdminOverrideMessage
                          .trParams({'when': scheduledStartLabel}),
                      primaryAction: AppDialogAction.danger(
                        label: AppStrings.adminOverrideProceed,
                        onPressed: () => nav.pop(true),
                      ),
                      secondaryAction: AppDialogAction.secondary(
                        label: AppStrings.cancel,
                        onPressed: () => nav.pop(false),
                      ),
                    ),
                  );
                  if (confirmed == true && mounted) {
                    bloc.add(
                      TripEvent.startTripRequested(
                        widget.trip.id,
                        forceOverride: true,
                      ),
                    );
                  }
                },
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

  DateTime _effectiveWaitingStart(DateTime arrivedAt) {
    final scheduledAtLocal = widget.trip.scheduledAtUtc?.toLocal();
    if (scheduledAtLocal != null && scheduledAtLocal.isAfter(arrivedAt)) {
      return scheduledAtLocal;
    }
    return arrivedAt;
  }

  _LifecycleConfig get _config {
    final scheduledAtLocal = widget.trip.scheduledAtUtc?.toLocal();
    final scheduledLabel = scheduledAtLocal?.toSmartDateTime() ?? '';
    final isEnRouteNotReady = !widget.trip.canMarkEnRoute;

    return switch (widget.trip.status) {
      TripStatus.accepted => _LifecycleConfig(
        label: AppStrings.tripStartEnRouteNavigation,
        hint: AppStrings.tripAssignedHint,
        icon: FontAwesomeIcons.route,
        isLoading: widget.state.markEnRouteState.isLoading,
        isActive: !isEnRouteNotReady,
        onTapWhenInactive: !isEnRouteNotReady
            ? null
            : () async {
                final nav = Navigator.of(context);
                final bloc = context.read<TripBloc>();
                final confirmed = await AppDialog.show<bool>(
                  context,
                  dialog: AppDialog.basic(
                    title: AppStrings.scheduledEnRouteAdminOverrideTitle,
                    message: AppStrings.scheduledEnRouteAdminOverrideMessage
                        .trParams({'when': scheduledLabel}),
                    primaryAction: AppDialogAction.danger(
                      label: AppStrings.adminOverrideProceed,
                      onPressed: () => nav.pop(true),
                    ),
                    secondaryAction: AppDialogAction.secondary(
                      label: AppStrings.cancel,
                      onPressed: () => nav.pop(false),
                    ),
                  ),
                );
                if (confirmed == true && mounted) {
                  bloc.add(
                    TripEvent.markEnRouteRequested(
                      widget.trip.id,
                      forceOverride: true,
                    ),
                  );
                }
              },
        event: TripEvent.markEnRouteRequested(widget.trip.id),
      ),
      TripStatus.enRoute => _LifecycleConfig(
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
    this.isActive = true,
    this.onTapWhenInactive,
  });

  final String label;
  final String hint;
  final FaIconData icon;
  final bool isLoading;
  final TripEvent event;
  final bool isActive;
  final VoidCallback? onTapWhenInactive;
}
