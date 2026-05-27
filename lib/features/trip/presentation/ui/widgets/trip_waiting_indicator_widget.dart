import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/trip/domain/entities/trip_entity.dart';

class TripWaitingIndicatorWidget extends StatelessWidget {
  const TripWaitingIndicatorWidget({super.key, required this.session});

  final TripWaitingSessionEntity session;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppRadii.sm.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 6.r,
            height: 6.r,
            decoration: const BoxDecoration(
              color: AppColors.warning,
              shape: BoxShape.circle,
            ),
          ),
          AppSpacing.sm.horizontalSpace,
          if (session.minutes != null)
            Text(
              AppStrings.waitingMinutes.replaceAll(
                '{minutes}',
                '${session.minutes}',
              ),
              style: AppTextStyles.s12w500.copyWith(
                color: context.onSurface.withValues(alpha: 0.78),
              ),
            ),
          if (session.estimatedFee != null) ...[
            AppSpacing.sm.horizontalSpace,
            Text(
              AppStrings.waitingEstimatedFee.replaceAll(
                '{fee}',
                session.estimatedFee!.toStringAsFixed(2),
              ),
              style: AppTextStyles.s12w400.copyWith(
                color: context.onSurface.withValues(alpha: 0.60),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
