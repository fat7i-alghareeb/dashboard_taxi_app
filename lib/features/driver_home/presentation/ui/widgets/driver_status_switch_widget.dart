import 'package:dashboardtaxi/common/imports/imports.dart';

/// A premium, animated status switcher representing Driver Online/Offline toggles.
///
/// Follows strict typography (§4), scaling suffixes (§5), semantic colors (§6),
/// padding tokens (§7), FontAwesome icons (§8) and theme effects (§9).
class DriverStatusSwitchWidget extends StatelessWidget {
  const DriverStatusSwitchWidget({
    super.key,
    required this.isOnline,
    required this.isLoading,
    required this.onToggle,
  });

  final bool isOnline;
  final bool isLoading;
  final ValueChanged<bool> onToggle;

  @override
  Widget build(BuildContext context) {
    final width = 260.w;
    final height = 60.h;
    final innerPadding = AppSpacing.sm.r;
    final knobSize = height - (innerPadding * 2);

    final activeColor = AppColors.success;
    final inactiveColor = context.onSurface.withValues(alpha: 0.3);

    return GestureDetector(
      onTap: isLoading ? null : () => onToggle(!isOnline),
      child: AnimatedContainer(
        duration: AppDurations.normal,
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadii.xl.r),
          color: isOnline
              ? activeColor.withValues(alpha: 0.15)
              : context.surface.withValues(alpha: 0.4),
          border: Border.all(
            color: isOnline ? activeColor : inactiveColor,
            width: 1.5.w,
          ),
          boxShadow: isOnline ? context.shadows.primary : context.shadows.grey,
        ),
        padding: REdgeInsets.all(innerPadding),
        child: Stack(
          children: [
            // Slide Track Status Label
            AnimatedAlign(
              duration: AppDurations.normal,
              alignment: isOnline ? Alignment.centerLeft : Alignment.centerRight,
              child: Padding(
                padding: REdgeInsets.symmetric(horizontal: AppSpacing.lg.w),
                child: Text(
                  isOnline
                      ? AppStrings.driverOnline.toUpperCase()
                      : AppStrings.driverOffline.toUpperCase(),
                  style: AppTextStyles.s14w400.copyWith(
                    color: isOnline ? activeColor : context.onSurface,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            
            // Sliding knob indicator
            AnimatedAlign(
              duration: AppDurations.normal,
              alignment: isOnline ? Alignment.centerRight : Alignment.centerLeft,
              child: AnimatedContainer(
                duration: AppDurations.normal,
                width: knobSize,
                height: knobSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: isOnline
                      ? context.gradients.success
                      : context.gradients.grey,
                  boxShadow: isOnline ? context.shadows.primary : context.shadows.grey,
                ),
                child: Center(
                  child: isLoading
                      ? SizedBox(
                          width: 18.r,
                          height: 18.r,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.r,
                            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : FaIcon(
                          isOnline ? FontAwesomeIcons.bolt : FontAwesomeIcons.powerOff,
                          size: 16.r,
                          color: Colors.white,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
