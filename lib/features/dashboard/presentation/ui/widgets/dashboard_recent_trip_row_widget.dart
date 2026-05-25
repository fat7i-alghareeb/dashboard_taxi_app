import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';

class DashboardRecentTripRowWidget extends StatelessWidget {
  const DashboardRecentTripRowWidget({super.key, required this.trip});

  final DashboardTripEntity trip;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FaIcon(FontAwesomeIcons.carSide, size: 16.r, color: context.primary),
        AppSpacing.md.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                trip.referenceCode,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.s14w600.copyWith(color: context.onSurface),
              ),
              AppSpacing.xs.verticalSpace,
              Text(
                trip.createdAt?.toSmartDateTime() ??
                    AppStrings.tripUnknownAddress,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.s12w400.copyWith(
                  color: context.onSurface.withValues(alpha: 0.62),
                ),
              ),
            ],
          ),
        ),
        AppSpacing.sm.horizontalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              trip.fareLabel,
              style: AppTextStyles.s14w600.copyWith(color: context.onSurface),
            ),
            AppSpacing.xs.verticalSpace,
            Text(
              trip.status,
              style: AppTextStyles.s12w400.copyWith(
                color: context.onSurface.withValues(alpha: 0.62),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
