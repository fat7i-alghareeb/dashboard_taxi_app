import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:dashboardtaxi/features/trip/presentation/states/trip_bloc.dart';

class TripSummaryPanelWidget extends StatelessWidget {
  const TripSummaryPanelWidget({super.key, required this.trip});

  final TripEntity trip;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadii.lg.r),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.surface.withValues(alpha: 0.92),
          borderRadius: BorderRadius.circular(AppRadii.lg.r),
          border: Border.all(color: AppColors.success.withValues(alpha: 0.24)),
        ),
        child: Padding(
          padding: REdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FaIcon(
                FontAwesomeIcons.circleCheck,
                size: 32.r,
                color: AppColors.success,
              ),
              AppSpacing.md.verticalSpace,
              Text(
                AppStrings.tripSummaryTitle,
                style: AppTextStyles.s24w700.copyWith(color: context.onSurface),
              ),
              AppSpacing.xs.verticalSpace,
              Text(
                AppStrings.tripSummarySubtitle,
                style: AppTextStyles.s14w400.copyWith(
                  color: context.onSurface.withValues(alpha: 0.66),
                ),
              ),
              AppSpacing.lg.verticalSpace,
              Text(
                AppStrings.tripReferenceCode.replaceAll(
                  '{code}',
                  trip.referenceCode,
                ),
                style: AppTextStyles.s16w600.copyWith(color: context.onSurface),
              ),
              AppSpacing.xs.verticalSpace,
              Text(
                AppStrings.tripFare
                    .replaceAll('{fare}', trip.quotedFare.toStringAsFixed(2))
                    .replaceAll('{currency}', trip.currencyCode),
                style: AppTextStyles.s24w700.copyWith(color: AppColors.success),
              ),
              AppSpacing.xl.verticalSpace,
              AppButton.success(
                onTap: () {
                  context.read<TripBloc>().add(
                    const TripEvent.clearCompletedSummaryRequested(),
                  );
                },
                child: AppButtonChild.label(AppStrings.tripReturnOnline),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: AppDurations.normal).slideY(begin: 0.08);
  }
}
