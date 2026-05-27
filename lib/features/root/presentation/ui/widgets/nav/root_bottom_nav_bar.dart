import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/root/constants/root_constants.dart';

import 'root_bottom_nav_item.dart';

class RootBottomNavItemConfig {
  const RootBottomNavItemConfig({required this.label, required this.icon});

  final String label;
  final IconData icon;
}

class RootBottomNavBar extends StatelessWidget {
  const RootBottomNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onItemSelected,
  });

  final List<RootBottomNavItemConfig> items;
  final int currentIndex;
  final ValueChanged<int> onItemSelected;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: RootConstants.bottomNavHeight.sp,
        padding: REdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: context.surface,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(RootConstants.bottomNavRadius.r),
          ),
          boxShadow: context.shadows.grey,
          border: Border(
            top: BorderSide(
              color: context.onSurface.withValues(alpha: 0.06),
            ),
          ),
        ),
        child: Row(
          children: [
            for (var i = 0; i < items.length; i++)
              Expanded(
                child: RootBottomNavItem(
                  label: items[i].label,
                  icon: items[i].icon,
                  isSelected: i == currentIndex,
                  onTap: () => onItemSelected(i),
                ),
              ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: AppDurations.normal)
        .slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic);
  }
}
