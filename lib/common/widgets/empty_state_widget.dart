import '../imports/imports.dart';
import 'empty_state/empty_state_badge_widget.dart';
import 'empty_state/empty_state_retry_button_widget.dart';

/// EmptyStateWidget
/// ----------------
///
/// A flat, icon-less empty state that adapts to whatever space it's placed in.
///
/// Two layout modes are detected automatically:
/// - **Compact**: when the surrounding context has unbounded height (e.g. inside
///   a section card or `Column` with `mainAxisSize.min`). The widget renders
///   tightly — just centered text and an optional retry button.
/// - **Fill**: when given a bounded height (e.g. as a screen body or via
///   `StatusBuilder`). The widget centers itself vertically and adds breathing
///   room.
///
/// Optional `onRefresh` enables pull-to-refresh. `onRetrying` adds a retry
/// button below the text. `retryLabel` overrides the default button label.
class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    super.key,
    this.text,
    this.onRefresh,
    this.onRetrying,
    this.retryLabel,
    this.padding,
    this.maxWidth,
    this.textStyle,
  });

  final String? text;

  final Future<void> Function()? onRefresh;
  final VoidCallback? onRetrying;
  final String? retryLabel;

  final EdgeInsetsGeometry? padding;
  final double? maxWidth;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final effectiveText = text?.trim().isNotEmpty == true
        ? text!
        : AppStrings.emptyStateNoData;

    final body = LayoutBuilder(
      builder: (context, constraints) {
        final hasBoundedHeight =
            constraints.hasBoundedHeight && constraints.maxHeight.isFinite;

        final content = Container(
          width: double.infinity,
          padding:
              padding ??
              REdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.lg,
              ),
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: (maxWidth ?? 360).w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const EmptyStateBadgeWidget(),
                AppSpacing.md.verticalSpace,
                Text(
                  effectiveText,
                  textAlign: TextAlign.center,
                  style:
                      textStyle ??
                      AppTextStyles.s14w500.copyWith(
                        color: context.onSurface.withValues(alpha: 0.70),
                        height: 1.45,
                      ),
                ),
                if (onRetrying != null) ...[
                  AppSpacing.md.verticalSpace,
                  EmptyStateRetryButtonWidget(
                    label: retryLabel ?? AppStrings.retry,
                    onTap: onRetrying!,
                  ),
                ],
              ],
            ),
          ),
        );

        if (onRefresh != null) {
          // pull-to-refresh requires a scrollable host
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: hasBoundedHeight
                ? SizedBox(height: constraints.maxHeight, child: content)
                : content,
          );
        }

        if (hasBoundedHeight) {
          return SizedBox(height: constraints.maxHeight, child: content);
        }
        return content;
      },
    );

    final animated = body
        .animate()
        .fadeIn(duration: 220.ms, curve: Curves.easeOutCubic)
        .slideY(begin: 0.03, end: 0, duration: 220.ms);

    if (onRefresh != null) {
      return RefreshIndicator(onRefresh: onRefresh!, child: animated);
    }
    return animated;
  }
}
