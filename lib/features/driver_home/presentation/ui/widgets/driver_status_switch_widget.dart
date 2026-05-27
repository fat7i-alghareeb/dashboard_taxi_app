import 'package:dashboardtaxi/common/imports/imports.dart';

/// A clean, flat online/offline toggle. The track is a tinted pill and the
/// knob is a solid colored disc that slides between the two ends. No
/// gradients, no shadows.
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
    const double height = 56;
    final innerPadding = AppSpacing.xs.r;
    final knobSize = height.h - (innerPadding * 2);

    final activeColor = AppColors.success;
    final trackColor = isOnline
        ? activeColor.withValues(alpha: 0.10)
        : context.onSurface.withValues(alpha: 0.06);
    final borderColor = isOnline
        ? activeColor.withValues(alpha: 0.40)
        : context.onSurface.withValues(alpha: 0.10);
    final knobColor = isOnline
        ? activeColor
        : context.onSurface.withValues(alpha: 0.55);

    return GestureDetector(
      onTap: isLoading ? null : () => onToggle(!isOnline),
      child: AnimatedContainer(
        duration: AppDurations.normal,
        height: height.h,
        decoration: BoxDecoration(
          color: trackColor,
          borderRadius: BorderRadius.circular(AppRadii.xl.r),
          border: Border.all(color: borderColor),
        ),
        padding: REdgeInsets.all(innerPadding / 4),
        child: Stack(
          children: [
            AnimatedAlign(
              duration: AppDurations.normal,
              alignment: isOnline
                  ? AlignmentDirectional.centerStart
                  : AlignmentDirectional.centerEnd,
              child: Padding(
                padding: REdgeInsets.symmetric(horizontal: AppSpacing.xl),
                child: Text(
                  isOnline
                      ? AppStrings.driverOnline.toUpperCase()
                      : AppStrings.driverOffline.toUpperCase(),
                  style: AppTextStyles.s12w500.copyWith(
                    color: isOnline
                        ? activeColor
                        : context.onSurface.withValues(alpha: 0.78),
                    letterSpacing: 1.4,
                  ),
                ),
              ),
            ),
            AnimatedAlign(
              duration: AppDurations.normal,
              alignment: isOnline
                  ? AlignmentDirectional.centerEnd
                  : AlignmentDirectional.centerStart,
              child: AnimatedContainer(
                duration: AppDurations.normal,
                width: knobSize,
                height: knobSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: knobColor,
                ),
                child: Center(
                  child: isLoading
                      ? SizedBox(
                          width: 18.r,
                          height: 18.r,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.r,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              context.onPrimary,
                            ),
                          ),
                        )
                      : FaIcon(
                          isOnline
                              ? FontAwesomeIcons.bolt
                              : FontAwesomeIcons.powerOff,
                          size: 16.r,
                          color: context.onPrimary,
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
