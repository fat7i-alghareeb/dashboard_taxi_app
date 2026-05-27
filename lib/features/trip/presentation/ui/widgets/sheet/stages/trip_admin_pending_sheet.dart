import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:dashboardtaxi/features/trip/presentation/states/trip_bloc.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_assignment_fare_row_widget.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_customer_contact_widget.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_route_card_widget.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_status_chip_widget.dart';

/// Admin-only stage: a new trip request has arrived (TripRequested).
/// Admin can take it themselves or dismiss the preview.
class TripAdminPendingSheet extends StatelessWidget {
  const TripAdminPendingSheet({
    super.key,
    required this.trip,
    required this.state,
  });

  final TripEntity trip;
  final TripState state;

  @override
  Widget build(BuildContext context) {
    final isLoading = state.adminSelfAssignState.isLoading;

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
              AppStrings.adminNewTripArrivedTitle.toUpperCase(),
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
        // Show failure message if self-assign failed
        ...state.adminSelfAssignState.maybeWhen(
          failure: (msg) => [
            Text(
              msg,
              style: AppTextStyles.s12w400.copyWith(color: context.error),
              textAlign: TextAlign.center,
            ),
            AppSpacing.sm.verticalSpace,
          ],
          orElse: () => const <Widget>[],
        ),
        AppButton.primary(
          isLoading: isLoading,
          layout: const AppButtonLayout(height: 52),
          onTap: isLoading
              ? null
              : () => context.read<TripBloc>().add(
                    TripEvent.adminSelfAssignRequested(trip.id),
                  ),
          child: AppButtonChild.labelIcon(
            label: AppStrings.adminTakeTrip,
            icon: IconSource.widget(
              FaIcon(FontAwesomeIcons.route, size: 14.r),
              size: 14,
            ),
            textStyle: AppTextStyles.s14w600,
          ),
        ),
        AppSpacing.sm.verticalSpace,
        AppButton.variant(
          variant: AppButtonVariant.grey,
          fill: AppButtonFill.outline,
          layout: const AppButtonLayout(height: 44),
          onTap: isLoading
              ? null
              : () => context.read<TripBloc>().add(
                    const TripEvent.dismissPendingTripRequested(),
                  ),
          child: AppButtonChild.label(
            AppStrings.adminDismissPendingTrip,
            textStyle: AppTextStyles.s14w500,
          ),
        ),
      ],
    );
  }
}
