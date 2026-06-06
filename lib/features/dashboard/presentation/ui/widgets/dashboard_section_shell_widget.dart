import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_section_trailing_action_widget.dart';

class DashboardSectionShellWidget extends StatelessWidget {
  const DashboardSectionShellWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
    this.subtitle,
    this.trailingLabel,
    this.onTrailingTap,
    this.itemCount,
    this.decorate = true,
  });

  final String title;
  final FaIconData icon;
  final Widget child;
  final String? subtitle;
  final String? trailingLabel;
  final VoidCallback? onTrailingTap;
  final int? itemCount;

  /// When `false`, skips the outer bordered card so children can be a list of
  /// independently decorated cards (e.g. one card per trip).
  final bool decorate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: REdgeInsets.only(left: AppSpacing.xs, right: AppSpacing.xs),
          child: Row(
            children: [
              Container(
                height: 28.r,
                width: 28.r,
                decoration: BoxDecoration(
                  color: context.primary.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(AppRadii.sm.r),
                ),
                child: Center(
                  child: FaIcon(icon, size: 12.r, color: context.primary),
                ),
              ),
              AppSpacing.md.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.s16w600.copyWith(
                              color: context.onSurface,
                            ),
                          ),
                        ),
                        if (itemCount != null) ...[
                          AppSpacing.sm.horizontalSpace,
                          Text(
                            itemCount.toString(),
                            style: AppTextStyles.s12w500.copyWith(
                              color: context.onSurface.withValues(alpha: 0.45),
                            ),
                          ),
                        ],
                      ],
                    ),
                    if (subtitle != null) ...[
                      AppSpacing.xs.verticalSpace,
                      Text(
                        subtitle!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.s12w400.copyWith(
                          color: context.onSurface.withValues(alpha: 0.55),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (trailingLabel != null && onTrailingTap != null)
                DashboardSectionTrailingActionWidget(
                  label: trailingLabel!,
                  onTap: onTrailingTap!,
                ),
            ],
          ),
        ),
        AppSpacing.md.verticalSpace,
        if (decorate)
          DecoratedBox(
            decoration: BoxDecoration(
              color: context.surface,
              borderRadius: BorderRadius.circular(AppRadii.lg.r),
              border: Border.all(
                color: context.onSurface.withValues(alpha: 0.08),
              ),
            ),
            child: Padding(
              padding: REdgeInsets.all(AppSpacing.lg),
              child: child,
            ),
          )
        else
          child,
      ],
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.04, end: 0);
  }
}
