import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';

class DashboardAuditLogRowWidget extends StatelessWidget {
  const DashboardAuditLogRowWidget({super.key, required this.log});

  final DashboardAuditLogEntity log;

  @override
  Widget build(BuildContext context) {
    final actor = log.actorName.isEmpty
        ? AppStrings.dashboardSystemActor
        : log.actorName;

    return Padding(
      padding: REdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Container(
            height: 32.r,
            width: 32.r,
            decoration: BoxDecoration(
              color: context.onSurface.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(AppRadii.sm.r),
            ),
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.gear,
                size: 12.r,
                color: context.onSurface.withValues(alpha: 0.65),
              ),
            ),
          ),
          AppSpacing.md.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${log.action} · ${log.entityName}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.s14w500.copyWith(
                    color: context.onSurface,
                  ),
                ),
                AppSpacing.xs.verticalSpace,
                Text(
                  actor,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.s12w400.copyWith(
                    color: context.onSurface.withValues(alpha: 0.55),
                  ),
                ),
              ],
            ),
          ),
          AppSpacing.sm.horizontalSpace,
          if (log.createdAt != null)
            Text(
              log.createdAt!.toSmartDateTime(),
              style: AppTextStyles.s12w400.copyWith(
                color: context.onSurface.withValues(alpha: 0.45),
              ),
            ),
        ],
      ),
    );
  }
}
