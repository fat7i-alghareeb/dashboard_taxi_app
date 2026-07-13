import 'package:dashboardtaxi/common/imports/imports.dart';

/// Shared screen header used by admin review-queue screens (refunds,
/// compensation, refund requests, ...): round back button, title
/// (+ optional subtitle), optional round refresh button, and an optional
/// secondary action row below.
class AppScreenHeader extends StatelessWidget {
  const AppScreenHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.onBack,
    this.onRefresh,
    this.secondaryAction,
  });

  final String title;
  final String? subtitle;
  final VoidCallback? onBack;
  final VoidCallback? onRefresh;
  final Widget? secondaryAction;

  @override
  Widget build(BuildContext context) {
    final titleColumn = Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: AppTextStyles.s24w700.copyWith(color: context.onSurface),
    );

    final titleWidget = subtitle == null
        ? titleColumn
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleColumn,
              AppSpacing.xs.verticalSpace,
              Text(
                subtitle!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.s12w400.copyWith(
                  color: context.onSurface.withValues(alpha: 0.64),
                ),
              ),
            ],
          );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            AppButton.grey(
              onTap: onBack ?? () => Navigator.maybePop(context),
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
            Expanded(child: titleWidget),
            if (onRefresh != null) ...[
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
          ],
        ),
        if (secondaryAction != null) ...[
          AppSpacing.md.verticalSpace,
          secondaryAction!,
        ],
      ],
    ).animate().fadeIn(duration: 220.ms).slideY(begin: 0.06, end: 0);
  }
}
