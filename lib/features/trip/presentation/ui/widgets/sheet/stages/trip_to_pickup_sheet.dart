import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:dashboardtaxi/features/trip/presentation/states/trip_bloc.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_customer_contact_widget.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_navigation_button_widget.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_route_card_widget.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_status_chip_widget.dart';

/// Stage 2: driver is en-route to the customer's pickup point. Primary action
/// notifies the backend (and downstream the customer) that the driver has
/// arrived.
class TripToPickupSheet extends StatelessWidget {
  const TripToPickupSheet({super.key, required this.trip, required this.state});

  final TripEntity trip;
  final TripState state;

  @override
  Widget build(BuildContext context) {
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
          AppStrings.tripEnRouteHint,
          style: AppTextStyles.s12w400.copyWith(
            color: context.onSurface.withValues(alpha: 0.60),
          ),
        ),
        AppSpacing.md.verticalSpace,
        TripRouteCardWidget(trip: trip),
        AppSpacing.sm.verticalSpace,
        TripCustomerContactWidget(trip: trip),
        AppSpacing.md.verticalSpace,
        TripNavigationButtonWidget(stop: trip.pickup),
        AppSpacing.md.verticalSpace,
        AppButton.primary(
          isLoading: state.markArrivedState.isLoading,
          layout: const AppButtonLayout(height: 52),
          onTap: () {
            context.read<TripBloc>().add(
              TripEvent.markArrivedRequested(trip.id),
            );
          },
          child: AppButtonChild.labelIcon(
            label: AppStrings.tripHaveArrived,
            icon: IconSource.widget(
              FaIcon(FontAwesomeIcons.locationDot, size: 14.r),
              size: 14,
            ),
            textStyle: AppTextStyles.s14w600,
          ),
        ),
      ],
    );
  }
}
