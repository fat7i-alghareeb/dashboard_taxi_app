import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:dashboardtaxi/features/trip/presentation/states/trip_bloc.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_assignment_fare_row_widget.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_customer_contact_widget.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_route_card_widget.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_status_chip_widget.dart';

/// A selected trip with no available lifecycle action (completed, cancelled,
/// refunded, payment failed, or other non-actionable status). Shows the trip
/// info + customer contact only.
class TripReadonlySheet extends StatelessWidget {
  const TripReadonlySheet({super.key, required this.trip});

  final TripEntity trip;

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
        AppButton.variant(
          variant: AppButtonVariant.grey,
          fill: AppButtonFill.outline,
          layout: const AppButtonLayout(height: 44),
          onTap: () => context.read<TripBloc>().add(
            const TripEvent.selectionCleared(),
          ),
          child: AppButtonChild.label(
            AppStrings.back,
            textStyle: AppTextStyles.s14w500,
          ),
        ),
      ],
    );
  }
}
