import '../../imports/imports.dart';

class EmptyStateRetryButtonWidget extends StatelessWidget {
  const EmptyStateRetryButtonWidget({
    super.key,
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.sm.r),
        child: Padding(
          padding: REdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs,
          ),
          child: Text(
            label,
            style: AppTextStyles.s12w500.copyWith(
              color: context.primary,
              decoration: TextDecoration.underline,
              decorationColor: context.primary.withValues(alpha: 0.45),
            ),
          ),
        ),
      ),
    );
  }
}
