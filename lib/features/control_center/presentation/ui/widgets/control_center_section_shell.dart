import 'package:dashboardtaxi/common/imports/imports.dart';

/// Section container for the Control Center, distinct from the legacy dashboard
/// section shell: a gradient icon badge + title/subtitle, an optional trailing
/// action, a thin in-section progress bar, then the body card.
class ControlCenterSectionShell extends StatelessWidget {
  const ControlCenterSectionShell({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.child,
    this.trailingLabel,
    this.onTrailingTap,
    this.isBusy = false,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Widget child;
  final String? trailingLabel;
  final VoidCallback? onTrailingTap;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            SizedBox(
              height: 40.r,
              width: 40.r,

              child: Center(
                child: FaIcon(icon, size: 16.r, color: context.onSurface),
              ),
            ),
            AppSpacing.md.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.s16w600.copyWith(
                      color: context.onSurface,
                    ),
                  ),
                  AppSpacing.xs.verticalSpace,
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.s12w400.copyWith(
                      color: context.onSurface.withValues(alpha: 0.55),
                    ),
                  ),
                ],
              ),
            ),
            if (trailingLabel != null && onTrailingTap != null) ...[
              AppSpacing.sm.horizontalSpace,
              _TrailingAction(label: trailingLabel!, onTap: onTrailingTap!),
            ],
          ],
        ),
        AppSpacing.md.verticalSpace,
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadii.lg.r),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: context.surface,
              borderRadius: BorderRadius.circular(AppRadii.lg.r),
              border: Border.all(
                color: context.onSurface.withValues(alpha: 0.08),
              ),
              boxShadow: context.shadows.grey,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 2.h,
                  child: isBusy
                      ? LinearProgressIndicator(
                          minHeight: 2.h,
                          backgroundColor: Colors.transparent,
                          color: context.primary,
                        )
                      : const SizedBox.shrink(),
                ),
                Padding(padding: REdgeInsets.all(AppSpacing.lg), child: child),
              ],
            ),
          ),
        ),
      ],
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.04, end: 0);
  }
}

class _TrailingAction extends StatelessWidget {
  const _TrailingAction({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: REdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: context.primary.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(AppRadii.sm.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(FontAwesomeIcons.plus, size: 11.r, color: context.primary),
            AppSpacing.xs.horizontalSpace,
            Text(
              label,
              style: AppTextStyles.s12w500.copyWith(color: context.primary),
            ),
          ],
        ),
      ),
    );
  }
}
