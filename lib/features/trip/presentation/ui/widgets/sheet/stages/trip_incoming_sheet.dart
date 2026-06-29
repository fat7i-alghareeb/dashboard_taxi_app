import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:dashboardtaxi/features/trip/presentation/states/trip_bloc.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_admin_cancel_button.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_assignment_fare_row_widget.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_customer_contact_widget.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_route_card_widget.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_status_chip_widget.dart';

/// Accepted reservation owned by the current admin.
class TripIncomingSheet extends StatelessWidget {
  const TripIncomingSheet({super.key, required this.trip, required this.state});

  final TripEntity trip;
  final TripState state;

  @override
  Widget build(BuildContext context) {
    final dispatchWindowLocal = trip.dispatchWindowOpensAtUtc?.toLocal();
    final isEnRouteNotReady = !trip.canMarkEnRoute;
    final scheduledLabel =
        trip.scheduledAtUtc?.toLocal().toSmartDateTime() ??
        dispatchWindowLocal?.toSmartDateTime() ??
        '';

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              width: 6.r,
              height: 6.r,
              decoration: BoxDecoration(
                color: context.primary,
                shape: BoxShape.circle,
              ),
            ),
            AppSpacing.sm.horizontalSpace,
            Text(
              AppStrings.tripStatusDriverAssigned.toUpperCase(),
              style: AppTextStyles.s11w500.copyWith(
                color: context.primary,
                letterSpacing: 1.4,
              ),
            ),
          ],
        ),
        AppSpacing.sm.verticalSpace,
        Row(
          children: [
            Expanded(
              child: Text(
                trip.referenceCode,
                style: AppTextStyles.s20w700.copyWith(color: context.onSurface),
              ),
            ),
            AppSpacing.sm.horizontalSpace,
            TripStatusChipWidget(status: trip.status),
          ],
        ),
        AppSpacing.md.verticalSpace,
        TripRouteCardWidget(trip: trip),
        AppSpacing.sm.verticalSpace,
        TripCustomerContactWidget(trip: trip),
        AppSpacing.md.verticalSpace,
        Container(height: 1, color: context.onSurface.withValues(alpha: 0.06)),
        AppSpacing.md.verticalSpace,
        TripAssignmentFareRowWidget(trip: trip),
        AppSpacing.lg.verticalSpace,
        AppButton.primary(
          isLoading: state.markEnRouteState.isLoading,
          isActive: !isEnRouteNotReady,
          layout: const AppButtonLayout(height: 52),
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
                  if (confirmed == true) {
                    bloc.add(
                      TripEvent.markEnRouteRequested(
                        trip.id,
                        forceOverride: true,
                      ),
                    );
                  }
                },
          onTap: () {
            context.read<TripBloc>().add(
              TripEvent.markEnRouteRequested(trip.id),
            );
          },
          child: AppButtonChild.labelIcon(
            label: AppStrings.tripStartEnRouteNavigation,
            icon: IconSource.widget(
              FaIcon(FontAwesomeIcons.route, size: 14.r),
              size: 14,
            ),
            textStyle: AppTextStyles.s14w600,
          ),
        ),
        AppSpacing.sm.verticalSpace,
        TripAdminCancelButton(
          tripId: trip.id,
          isLoading: state.adminCancelState.isLoading,
        ),
      ],
    );
  }
}
