import 'package:dashboardtaxi/common/imports/imports.dart';

/// Compact, intrinsic-height failure state for a Control Center section.
///
/// The shared [FailedStateWidget] fills the available height, which is invalid
/// inside the unbounded vertical space of the screen's `ListView`. This renders
/// a tightly-sized error with a retry button instead.
class ControlCenterSectionError extends StatelessWidget {
  const ControlCenterSectionError({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(
            FontAwesomeIcons.circleExclamation,
            size: 22.r,
            color: context.onSurface.withValues(alpha: 0.4),
          ),
          AppSpacing.sm.verticalSpace,
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyles.s12w400.copyWith(
              color: context.onSurface.withValues(alpha: 0.65),
            ),
          ),
          AppSpacing.md.verticalSpace,
          AppButton.outline(
            layout: const AppButtonLayout(height: 38),
            onTap: onRetry,
            child: AppButtonChild.label(
              AppStrings.retry,
              textStyle: AppTextStyles.s12w500,
            ),
          ),
        ],
      ),
    );
  }
}
