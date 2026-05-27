import 'package:dashboardtaxi/common/imports/imports.dart';

class DashboardSectionTrailingActionWidget extends StatelessWidget {
  const DashboardSectionTrailingActionWidget({
    super.key,
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadii.sm.r),
      child: Padding(
        padding: REdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: AppTextStyles.s12w500.copyWith(color: context.primary),
            ),
            AppSpacing.xs.horizontalSpace,
            FaIcon(context.chevronEnd, size: 10.r, color: context.primary),
          ],
        ),
      ),
    );
  }
}
