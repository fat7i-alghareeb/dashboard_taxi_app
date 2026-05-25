import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_kyc_review_sheet.dart';

class DashboardPendingDriverRowWidget extends StatelessWidget {
  const DashboardPendingDriverRowWidget({super.key, required this.driver});

  final DashboardDriverEntity driver;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.surface.withValues(alpha: 0.58),
        borderRadius: BorderRadius.circular(AppRadii.sm.r),
        border: Border.all(color: context.onSurface.withValues(alpha: 0.08)),
      ),
      child: Padding(
        padding: REdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            FaIcon(
              FontAwesomeIcons.solidUser,
              size: 16.r,
              color: context.primary,
            ),
            AppSpacing.md.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    driver.fullName.isEmpty ? driver.id : driver.fullName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.s14w600.copyWith(
                      color: context.onSurface,
                    ),
                  ),
                  AppSpacing.xs.verticalSpace,
                  Text(
                    '${AppStrings.dashboardLicenseNumber}: ${driver.licenseNumber}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.s12w400.copyWith(
                      color: context.onSurface.withValues(alpha: 0.62),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  driver.approvalStatus,
                  style: AppTextStyles.s14w600.copyWith(
                    color: AppColors.warning,
                  ),
                ),
                AppSpacing.sm.verticalSpace,
                AppButton.outline(
                  onTap: () => DashboardKycReviewSheet.show(context, driver),
                  layout: AppButtonLayout(
                    height: 34,
                    contentPadding: REdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.xs,
                    ),
                  ),
                  child: AppButtonChild.label(
                    AppStrings.dashboardReviewDocuments,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
