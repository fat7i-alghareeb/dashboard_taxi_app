import 'package:dashboardtaxi/common/imports/imports.dart';

class DrawerLogoutFooter extends StatelessWidget {
  const DrawerLogoutFooter({super.key, required this.onLogoutTap});

  final VoidCallback onLogoutTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.md,
        AppSpacing.xl,
        context.bottomPadding + AppSpacing.xl,
      ),
      child: AppButton.outline(
        layout: const AppButtonLayout(height: 48, borderRadius: AppRadii.lg),
        child: AppButtonChild.labelIcon(
          label: AppStrings.logout,
          icon: IconSource.icon(FontAwesomeIcons.rightFromBracket),
          iconSize: 14.r,
          textStyle: AppTextStyles.s14w600.copyWith(color: AppColors.error),
        ),
        onTap: onLogoutTap,
      ),
    ).animate().fadeIn().slideY(begin: 0.15, duration: 240.ms);
  }
}
