import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:dashboardtaxi/features/trip/presentation/states/trip_bloc.dart';

class TripSummaryPanelWidget extends StatelessWidget {
  const TripSummaryPanelWidget({super.key, required this.trip});

  final TripEntity trip;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(color: AppColors.success.withValues(alpha: 0.24)),
      ),
      child: Padding(
        padding: REdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  width: 8.r,
                  height: 8.r,
                  decoration: const BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                  ),
                ),
                AppSpacing.sm.horizontalSpace,
                Text(
                  AppStrings.tripSummaryTitle.toUpperCase(),
                  style: AppTextStyles.s11w500.copyWith(
                    color: AppColors.success,
                    letterSpacing: 1.4,
                  ),
                ),
              ],
            ),
            AppSpacing.md.verticalSpace,
            Text(
              AppStrings.tripSummarySubtitle,
              style: AppTextStyles.s14w400.copyWith(
                color: context.onSurface.withValues(alpha: 0.60),
              ),
            ),
            AppSpacing.lg.verticalSpace,
            Text(
              trip.referenceCode,
              style: AppTextStyles.s16w600.copyWith(color: context.onSurface),
            ),
            AppSpacing.xs.verticalSpace,
            Text(
              AppStrings.tripFare
                  .replaceAll('{fare}', trip.quotedFare.toStringAsFixed(2))
                  .replaceAll('{currency}', trip.currencyCode),
              style: AppTextStyles.s28w700.copyWith(color: AppColors.success),
            ),
            AppSpacing.xl.verticalSpace,
            AppButton.outline(
              variant: AppButtonVariant.success,
              layout: const AppButtonLayout(height: 48),
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
    ).animate().fadeIn(duration: 320.ms).slideY(begin: 0.05, end: 0);
  }
}
