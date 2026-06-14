import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/common/widgets/show_overlay.dart';
import 'package:dashboardtaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:dashboardtaxi/features/trip/presentation/states/trip_bloc.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/dialogs/driver_trip_cancellation_dialog.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_admin_cancel_button.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_customer_contact_widget.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_route_card_widget.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_status_chip_widget.dart';

const Duration _kResendArrivedCooldown = Duration(seconds: 30);

/// Stage 3: driver has arrived at the pickup. Customer has been notified.
/// Primary action puts the trip in progress. Secondary actions cover the
/// resend-notification button and (after 10 minutes) no-show cancellation.
class TripAtPickupSheet extends StatefulWidget {
  const TripAtPickupSheet({super.key, required this.trip, required this.state});

  final TripEntity trip;
  final TripState state;

  @override
  State<TripAtPickupSheet> createState() => _TripAtPickupSheetState();
}

class _TripAtPickupSheetState extends State<TripAtPickupSheet> {
  Timer? _cooldownTicker;
  // Drives the 1-second rebuilds for the live waiting countdown / accruing fee.
  Timer? _waitingTicker;

  @override
  void initState() {
    super.initState();
    _maybeStartCooldownTicker();
    _waitingTicker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void didUpdateWidget(covariant TripAtPickupSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    _maybeStartCooldownTicker();
  }

  @override
  void dispose() {
    _cooldownTicker?.cancel();
    _waitingTicker?.cancel();
    super.dispose();
  }

  /// Shows the 10-minute boarding countdown after arrival, switching to the
  /// accruing per-minute waiting fee once the free grace window elapses. This
  /// mirrors what the customer sees; billing is settled server-side.
  Widget _buildWaitingInfo(BuildContext context) {
    final arrivedAt = widget.state.arrivedAt;
    if (arrivedAt == null) return const SizedBox.shrink();

    final session = widget.trip.activeWaitingSession;
    final graceMinutes = session?.graceMinutes ?? 10;
    final ratePerMinute = session?.ratePerMinute ?? 0;
    final elapsed = DateTime.now().difference(arrivedAt);
    final graceRemaining = Duration(minutes: graceMinutes) - elapsed;

    final Widget content;
    final Color tint;
    if (graceRemaining > Duration.zero) {
      final mm = graceRemaining.inMinutes.remainder(60).toString().padLeft(2, '0');
      final ss = graceRemaining.inSeconds.remainder(60).toString().padLeft(2, '0');
      tint = context.primary;
      content = Row(
        children: [
          FaIcon(FontAwesomeIcons.solidClock, color: tint, size: 16.r),
          AppSpacing.sm.horizontalSpace,
          Expanded(
            child: Text(
              AppStrings.tripArrivedBoardWithin.trParams({'time': '$mm:$ss'}),
              style: AppTextStyles.s14w600.copyWith(color: context.onSurface),
            ),
          ),
        ],
      );
    } else {
      final overdueSeconds = elapsed.inSeconds - graceMinutes * 60;
      final billableMinutes = (overdueSeconds / 60).ceil();
      final fee = billableMinutes * ratePerMinute;
      final amount = '${fee.toStringAsFixed(2)} ${widget.trip.currencyCode}';
      tint = AppColors.warning;
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              FaIcon(FontAwesomeIcons.triangleExclamation, color: tint, size: 16.r),
              AppSpacing.sm.horizontalSpace,
              Expanded(
                child: Text(
                  AppStrings.tripWaitingGraceOver,
                  style: AppTextStyles.s12w400.copyWith(color: context.onSurface),
                ),
              ),
            ],
          ),
          AppSpacing.xs.verticalSpace,
          Text(
            AppStrings.tripWaitingFeeAccruing.trParams({'amount': amount}),
            style: AppTextStyles.s16w600.copyWith(color: tint),
          ),
        ],
      );
    }

    return Padding(
      padding: REdgeInsets.only(top: AppSpacing.md),
      child: Container(
        width: double.infinity,
        padding: REdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: tint.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(AppRadii.md.r),
          border: Border.all(color: tint.withValues(alpha: 0.30), width: 1.r),
        ),
        child: content,
      ),
    );
  }

  void _maybeStartCooldownTicker() {
    if (_remainingCooldownSeconds() > 0 && _cooldownTicker == null) {
      _cooldownTicker = Timer.periodic(const Duration(seconds: 1), (_) {
        if (!mounted) return;
        if (_remainingCooldownSeconds() <= 0) {
          _cooldownTicker?.cancel();
          _cooldownTicker = null;
        }
        setState(() {});
      });
    }
  }

  int _remainingCooldownSeconds() {
    final last = widget.state.lastArrivedResendAt;
    if (last == null) return 0;
    final elapsed = DateTime.now().difference(last);
    final remaining = _kResendArrivedCooldown - elapsed;
    return remaining.inSeconds <= 0 ? 0 : remaining.inSeconds + 1;
  }

  @override
  Widget build(BuildContext context) {
    final trip = widget.trip;
    final state = widget.state;
    final arrivedAt = state.arrivedAt;
    final tenMinPassed =
        arrivedAt != null &&
        DateTime.now().difference(arrivedAt) >= const Duration(minutes: 10);
    final cooldownRemaining = _remainingCooldownSeconds();
    final resendDisabled =
        cooldownRemaining > 0 || state.resendArrivedNotificationState.isLoading;
    final resendLabel = cooldownRemaining > 0
        ? AppStrings.notifyAgainCountdown.trParams({
            'seconds': cooldownRemaining,
          })
        : AppStrings.notifyCustomerAgain;

    return MultiBlocListener(
      listeners: [
        BlocListener<TripBloc, TripState>(
          listenWhen: (prev, curr) =>
              prev.resendArrivedNotificationState !=
              curr.resendArrivedNotificationState,
          listener: (context, current) {
            current.resendArrivedNotificationState.whenOrNull(
              success: (_) {
                showSuccessOverlay(context, AppStrings.notificationSent);
                _maybeStartCooldownTicker();
              },
              failure: (message) => showSuccessOverlay(context, message),
            );
          },
        ),
      ],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  AppStrings.tripReferenceCode.trParams({
                    'code': trip.referenceCode,
                  }),
                  style: AppTextStyles.s16w600.copyWith(
                    color: context.onSurface,
                  ),
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
          _buildWaitingInfo(context),
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
          AppButton.outline(
            isLoading: state.resendArrivedNotificationState.isLoading,
            layout: const AppButtonLayout(height: 44),
            onTap: resendDisabled
                ? null
                : () => context.read<TripBloc>().add(
                    TripEvent.resendArrivedNotificationRequested(trip.id),
                  ),
            child: AppButtonChild.labelIcon(
              label: resendLabel,
              icon: IconSource.widget(
                FaIcon(FontAwesomeIcons.bell, size: 14.r),
                size: 14,
              ),
              textStyle: AppTextStyles.s14w500,
            ),
          ),
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
      ),
    );
  }
}
