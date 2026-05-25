import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';

class DashboardAdminUserRowWidget extends StatelessWidget {
  const DashboardAdminUserRowWidget({super.key, required this.user});

  final DashboardUserEntity user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FaIcon(FontAwesomeIcons.userShield, size: 16.r, color: context.primary),
        AppSpacing.md.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name.isEmpty ? AppStrings.dashboardSystemActor : user.name,
                style: AppTextStyles.s14w600.copyWith(color: context.onSurface),
              ),
              AppSpacing.xs.verticalSpace,
              Text(
                user.phone,
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
              user.role,
              style: AppTextStyles.s12w500.copyWith(color: context.primary),
            ),
            AppSpacing.xs.verticalSpace,
            Text(
              user.createdAt?.toSmartDateTime() ?? AppStrings.tripUnknownAddress,
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
