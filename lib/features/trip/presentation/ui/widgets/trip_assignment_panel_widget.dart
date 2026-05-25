import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:dashboardtaxi/features/trip/presentation/states/trip_bloc.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_route_card_widget.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_status_chip_widget.dart';

class TripAssignmentPanelWidget extends StatelessWidget {
  const TripAssignmentPanelWidget({
    super.key,
    required this.trip,
    required this.state,
  });

  final TripEntity trip;
  final TripState state;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.background.withValues(alpha: 0.84),
        ),
        child: SafeArea(
          child: Padding(
            padding: REdgeInsets.all(AppSpacing.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadii.lg.r),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: context.surface.withValues(alpha: 0.94),
                          borderRadius: BorderRadius.circular(AppRadii.lg.r),
                          border: Border.all(
                            color: context.primary.withValues(alpha: 0.26),
                          ),
                        ),
                        child: Padding(
                          padding: REdgeInsets.all(AppSpacing.xl),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.bell,
                                    size: 20.r,
                                    color: context.primary,
                                  ),
                                  AppSpacing.md.horizontalSpace,
                                  Expanded(
                                    child: Text(
                                      AppStrings.tripAssignmentTitle,
                                      style: AppTextStyles.s24w700.copyWith(
                                        color: context.onSurface,
                                      ),
                                    ),
                                  ),
                                  TripStatusChipWidget(status: trip.status),
                                ],
                              ),
                              AppSpacing.md.verticalSpace,
                              Text(
                                AppStrings.tripReferenceCode.replaceAll(
                                  '{code}',
                                  trip.referenceCode,
                                ),
                                style: AppTextStyles.s16w600.copyWith(
                                  color: context.onSurface.withValues(
                                    alpha: 0.72,
                                  ),
                                ),
                              ),
                              AppSpacing.lg.verticalSpace,
                              TripRouteCardWidget(trip: trip),
                              AppSpacing.lg.verticalSpace,
                              _TripAssignmentFareRow(trip: trip),
                              AppSpacing.xl.verticalSpace,
                              AppButton.primaryGradient(
                                isLoading: state.markEnRouteState.isLoading,
                                onTap: () {
                                  context.read<TripBloc>().add(
                                    TripEvent.markEnRouteRequested(trip.id),
                                  );
                                },
                                child: AppButtonChild.labelIcon(
                                  label: AppStrings.tripStartEnRouteNavigation,
                                  icon: IconSource.widget(
                                    FaIcon(FontAwesomeIcons.route, size: 16.r),
                                    size: 16,
                                  ),
                                  textStyle: AppTextStyles.s14w400.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .animate()
                    .fadeIn(duration: AppDurations.normal)
                    .slideY(begin: 0.16),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TripAssignmentFareRow extends StatelessWidget {
  const _TripAssignmentFareRow({required this.trip});

  final TripEntity trip;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _TripInfoTile(
            label: AppStrings.tripFareLabel,
            value: AppStrings.tripFare
                .replaceAll('{fare}', trip.quotedFare.toStringAsFixed(2))
                .replaceAll('{currency}', trip.currencyCode),
            icon: FontAwesomeIcons.circleDollarToSlot,
          ),
        ),
        AppSpacing.md.horizontalSpace,
        Expanded(
          child: _TripInfoTile(
            label: AppStrings.tripVehicleType,
            value: trip.vehicleTypeName ?? trip.vehicleLabel,
            icon: FontAwesomeIcons.carSide,
          ),
        ),
      ],
    );
  }
}

class _TripInfoTile extends StatelessWidget {
  const _TripInfoTile({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppRadii.md.r),
      ),
      child: Padding(
        padding: REdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FaIcon(icon, size: 16.r, color: context.primary),
            AppSpacing.sm.verticalSpace,
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.s14w400.copyWith(
                color: context.onSurface.withValues(alpha: 0.62),
              ),
            ),
            AppSpacing.xs.verticalSpace,
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.s16w600.copyWith(color: context.onSurface),
            ),
          ],
        ),
      ),
    );
  }
}
