import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_kyc_review_sheet.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_status_chip_widget.dart';

class DashboardPendingDriverRowWidget extends StatelessWidget {
  const DashboardPendingDriverRowWidget({super.key, required this.driver});

  final DashboardDriverEntity driver;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Container(
            height: 40.r,
            width: 40.r,
            decoration: BoxDecoration(
              color: context.primary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(AppRadii.sm.r),
            ),
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.solidUser,
                size: 14.r,
                color: context.primary,
              ),
            ),
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
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        '${AppStrings.dashboardLicenseNumber}: ${driver.licenseNumber}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.s12w400.copyWith(
                          color: context.onSurface.withValues(alpha: 0.60),
                        ),
                      ),
                    ),
                    AppSpacing.sm.horizontalSpace,
                    DashboardStatusChipWidget(
                      label: driver.approvalStatus,
                      tone: dashboardToneFromApprovalStatus(
                        driver.approvalStatus,
                      ),
                      dense: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
          AppSpacing.sm.horizontalSpace,
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
    );
  }
}
