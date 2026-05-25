import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';

class DashboardAuditLogRowWidget extends StatelessWidget {
  const DashboardAuditLogRowWidget({super.key, required this.log});

  final DashboardAuditLogEntity log;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FaIcon(FontAwesomeIcons.gear, size: 16.r, color: context.primary),
        AppSpacing.md.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${log.action} ${log.entityName}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.s14w600.copyWith(color: context.onSurface),
              ),
              AppSpacing.xs.verticalSpace,
              Text(
                log.actorName.isEmpty
                    ? AppStrings.dashboardSystemActor
                    : log.actorName,
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
        Text(
          log.createdAt?.toSmartDateTime() ?? AppStrings.tripUnknownAddress,
          style: AppTextStyles.s12w400.copyWith(
            color: context.onSurface.withValues(alpha: 0.62),
          ),
        ),
      ],
    );
  }
}
