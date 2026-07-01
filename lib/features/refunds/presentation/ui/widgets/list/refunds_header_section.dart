import 'package:dashboardtaxi/common/imports/imports.dart';

class RefundsHeaderSection extends StatelessWidget {
  const RefundsHeaderSection({
    super.key,
    required this.onRefresh,
    required this.onOpenCustomerRequests,
  });

  final VoidCallback onRefresh;
  final VoidCallback onOpenCustomerRequests;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            AppButton.grey(
              onTap: () => Navigator.maybePop(context),
              layout: AppButtonLayout(
                width: 44.w,
                height: 44.h,
                shape: AppButtonShape.circle,
                contentPadding: REdgeInsets.all(AppSpacing.sm),
              ),
              child: AppButtonChild.icon(
                IconSource.builder(
                  (_) => FaIcon(FontAwesomeIcons.arrowLeft, size: 16.r),
                ),
              ),
            ),
            AppSpacing.md.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.refundsTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.s24w700.copyWith(
                      color: context.onSurface,
                    ),
                  ),
                  AppSpacing.xs.verticalSpace,
                  Text(
                    AppStrings.refundsSubtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.s12w400.copyWith(
                      color: context.onSurface.withValues(alpha: 0.64),
                    ),
                  ),
                ],
              ),
            ),
            AppSpacing.md.horizontalSpace,
            AppButton.primary(
              onTap: onRefresh,
              layout: AppButtonLayout(
                width: 44.w,
                height: 44.h,
                shape: AppButtonShape.circle,
                contentPadding: REdgeInsets.all(AppSpacing.sm),
              ),
              child: AppButtonChild.icon(
                IconSource.builder(
                  (_) => FaIcon(FontAwesomeIcons.arrowsRotate, size: 16.r),
                ),
              ),
            ),
          ],
        ),
        AppSpacing.md.verticalSpace,
        AppButton.grey(
          onTap: onOpenCustomerRequests,
          child: AppButtonChild.labelIcon(
            label: AppStrings.refundRequestsButton,
            icon: IconSource.builder(
              (_) => FaIcon(FontAwesomeIcons.inbox, size: 15.r),
            ),
          ),
        ),
      ],
    ).animate().fadeIn(duration: 220.ms).slideY(begin: 0.06, end: 0);
  }
}
