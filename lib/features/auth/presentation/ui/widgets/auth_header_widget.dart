import 'package:dashboardtaxi/common/imports/imports.dart';

/// Shared flat header used by all auth screens.
///
/// Renders a compact brand mark at the top (no orange container), a large
/// title, and a quiet subtitle line. Optionally shows a back chevron on the
/// left that pops the route — used by the OTP step and force-reset screen.
class AuthHeaderWidget extends StatelessWidget {
  const AuthHeaderWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.onBack,
  });

  final String title;
  final String subtitle;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (onBack != null) ...[
              Material(
                color: context.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadii.sm.r),
                  side: BorderSide(
                    color: context.onSurface.withValues(alpha: 0.10),
                  ),
                ),
                child: InkWell(
                  onTap: onBack,
                  borderRadius: BorderRadius.circular(AppRadii.sm.r),
                  child: SizedBox(
                    height: 40.r,
                    width: 40.r,
                    child: Center(
                      child: FaIcon(
                        context.chevronStart,
                        size: 14.r,
                        color: context.onSurface.withValues(alpha: 0.78),
                      ),
                    ),
                  ),
                ),
              ),
              AppSpacing.md.horizontalSpace,
            ],
            Assets.images.oranjeLogo
                .image(height: 36.r, fit: BoxFit.contain)
                .animate()
                .fadeIn(duration: 400.ms),
          ],
        ),
        AppSpacing.xl.verticalSpace,
        Text(
          title,
          style: AppTextStyles.s28w700.copyWith(
            color: context.onSurface,
            height: 1.15,
          ),
        ).animate().fadeIn(delay: 120.ms, duration: 400.ms).slideY(
              begin: 0.05,
              end: 0,
              duration: 400.ms,
            ),
        AppSpacing.sm.verticalSpace,
        Text(
          subtitle,
          style: AppTextStyles.s14w400.copyWith(
            color: context.onSurface.withValues(alpha: 0.60),
          ),
        ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
      ],
    );
  }
}
