import 'package:dashboardtaxi/common/imports/imports.dart';

class RefundRequestsHeaderSection extends StatelessWidget {
  const RefundRequestsHeaderSection({super.key, required this.onRefresh});

  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return Row(
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
                AppStrings.refundRequestsTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.s24w700.copyWith(color: context.onSurface),
              ),
              AppSpacing.xs.verticalSpace,
              Text(
                AppStrings.refundRequestsSubtitle,
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
    ).animate().fadeIn(duration: 220.ms).slideY(begin: 0.06, end: 0);
  }
}
