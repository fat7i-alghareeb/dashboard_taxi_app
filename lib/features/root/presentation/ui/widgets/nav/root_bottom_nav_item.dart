import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/root/constants/root_constants.dart';

class RootBottomNavItem extends StatelessWidget {
  const RootBottomNavItem({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final foreground = isSelected
        ? context.primary
        : context.onSurface.withValues(alpha: 0.65);

    final background = isSelected
        ? context.primary.withValues(alpha: 0.12)
        : Colors.transparent;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: AppDurations.fast,
        height: RootConstants.bottomNavItemHeight.sp,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(AppRadii.lg.r),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              icon,
              size: RootConstants.bottomNavIconSize.r,
              color: foreground,
            ),
            AppSpacing.xs.verticalSpace,
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.s11w500.copyWith(color: foreground),
            ),
          ],
        ),
      ),
    );
  }
}
