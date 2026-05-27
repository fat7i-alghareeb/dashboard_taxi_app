import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_status_chip_widget.dart';

class DashboardAdminUserRowWidget extends StatelessWidget {
  const DashboardAdminUserRowWidget({super.key, required this.user});

  final DashboardUserEntity user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Container(
            height: 36.r,
            width: 36.r,
            decoration: BoxDecoration(
              color: context.onSurface.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(AppRadii.sm.r),
            ),
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.userShield,
                size: 13.r,
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
                  user.name.isEmpty
                      ? AppStrings.dashboardSystemActor
                      : user.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.s14w500.copyWith(
                    color: context.onSurface,
                  ),
                ),
                AppSpacing.xs.verticalSpace,
                Text(
                  user.phone,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              DashboardStatusChipWidget(
                label: user.role,
                tone: DashboardStatusTone.primary,
                dense: true,
              ),
              if (user.createdAt != null) ...[
                AppSpacing.xs.verticalSpace,
                Text(
                  user.createdAt!.toSmartDateTime(),
                  style: AppTextStyles.s12w400.copyWith(
                    color: context.onSurface.withValues(alpha: 0.45),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
