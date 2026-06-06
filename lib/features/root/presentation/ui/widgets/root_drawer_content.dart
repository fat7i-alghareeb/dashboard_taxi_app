import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/common/widgets/sheets/selection_list_sheet.dart';
import 'package:dashboardtaxi/core/config/localization_config.dart';
import 'package:dashboardtaxi/core/domain/extensions/user_role_extensions.dart';
import 'package:dashboardtaxi/core/services/localization/locale_service.dart';
import 'package:dashboardtaxi/core/services/session/auth_manager.dart';
import 'package:dashboardtaxi/core/services/session/auth_state_notifier.dart';
import 'package:dashboardtaxi/core/theme/theme_controller.dart';
import 'package:dashboardtaxi/features/admin_management/presentation/ui/screens/create_admin_screen.dart';
import 'package:dashboardtaxi/features/auth/presentation/ui/screens/change_password_screen.dart';
import 'package:dashboardtaxi/features/compensation/presentation/ui/screens/compensation_claims_screen.dart';
import 'package:dashboardtaxi/features/control_center/presentation/ui/screens/control_center_screen.dart';
import 'package:dashboardtaxi/features/notifications/presentation/ui/screens/send_notification_screen.dart';
// import 'package:dashboardtaxi/features/dashboard/presentation/ui/screens/dashboard_live_map_screen.dart';
// import 'package:dashboardtaxi/features/dashboard/presentation/ui/screens/dashboard_screen.dart';
// import 'package:dashboardtaxi/features/dashboard/presentation/ui/screens/dashboard_trips_screen.dart';

import 'drawer/drawer_header_section.dart';
import 'drawer/drawer_logout_footer.dart';
import 'drawer/drawer_menu_item.dart';

class RootDrawerContent extends StatelessWidget {
  const RootDrawerContent({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = getIt<AuthStateNotifier>();

    return ColoredBox(
      color: context.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListenableBuilder(
              listenable: authState,
              builder: (context, _) {
                final isAdmin = authState.user.isAdmin;
                return ListView(
                  padding: REdgeInsets.only(bottom: AppSpacing.xl.h),
                  children: [
                    const DrawerHeaderSection(),
                    if (isAdmin) ..._buildAdminSection(context),
                    _buildSectionHeader(
                      context,
                      AppStrings.drawerSectionSettings,
                    ),
                    _buildLanguageSelector(context),
                    _buildThemeSelector(context),
                  ],
                );
              },
            ),
          ),
          Container(
            height: 1,
            color: context.onSurface.withValues(alpha: 0.06),
          ),
          DrawerLogoutFooter(onLogoutTap: () => _handleLogout(context)),
        ],
      ),
    );
  }

  List<Widget> _buildAdminSection(BuildContext context) {
    return [
      _buildSectionHeader(context, AppStrings.drawerSectionAdmin),
      // DrawerMenuItem(
      //   icon: FontAwesomeIcons.gaugeHigh,
      //   label: AppStrings.drawerAdminDashboard,
      //   onTap: () {
      //     Navigator.maybePop(context);
      //     context.pushNamed(DashboardScreen.pageName);
      //   },
      // ),
      // DrawerMenuItem(
      //   icon: FontAwesomeIcons.route,
      //   label: AppStrings.drawerAdminTrips,
      //   onTap: () {
      //     Navigator.maybePop(context);
      //     context.pushNamed(DashboardTripsScreen.pageName);
      //   },
      // ),
      // DrawerMenuItem(
      //   icon: FontAwesomeIcons.locationDot,
      //   label: AppStrings.drawerAdminLiveFleet,
      //   onTap: () {
      //     Navigator.maybePop(context);
      //     context.pushNamed(DashboardLiveMapScreen.pageName);
      //   },
      // ),
      DrawerMenuItem(
        icon: FontAwesomeIcons.sliders,
        label: AppStrings.controlCenter,
        onTap: () {
          Navigator.maybePop(context);
          context.pushNamed(ControlCenterScreen.pageName);
        },
      ),
      DrawerMenuItem(
        icon: FontAwesomeIcons.handHoldingDollar,
        label: AppStrings.dashboardCompensationClaims,
        onTap: () {
          Navigator.maybePop(context);
          context.pushNamed(CompensationClaimsScreen.pageName);
        },
      ),
      DrawerMenuItem(
        icon: FontAwesomeIcons.bullhorn,
        label: AppStrings.drawerSendNotification,
        onTap: () {
          Navigator.maybePop(context);
          context.pushNamed(SendNotificationScreen.pageName);
        },
      ),
      DrawerMenuItem(
        icon: FontAwesomeIcons.userShield,
        label: AppStrings.drawerAddAdmin,
        onTap: () {
          Navigator.maybePop(context);
          context.pushNamed(CreateAdminScreen.pageName);
        },
      ),
      DrawerMenuItem(
        icon: FontAwesomeIcons.key,
        label: AppStrings.drawerChangePassword,
        onTap: () {
          Navigator.maybePop(context);
          context.pushNamed(ChangePasswordScreen.pageName);
        },
      ),
    ];
  }

  Widget _buildSectionHeader(BuildContext context, String label) {
    return Padding(
      padding: REdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.sm,
      ),
      child: Text(
        label,
        style: AppTextStyles.s11w500.copyWith(
          color: context.onSurface.withValues(alpha: 0.40),
          letterSpacing: 1.1,
        ),
      ),
    );
  }

  Widget _buildThemeSelector(BuildContext context) {
    final themeController = getIt<ThemeController>();
    return ListenableBuilder(
      listenable: themeController,
      builder: (context, _) {
        final isDark = themeController.isDarkMode;
        return DrawerMenuItem(
          icon: isDark ? FontAwesomeIcons.moon : FontAwesomeIcons.sun,
          label: AppStrings.selectTheme,
          value: isDark ? AppStrings.dark : AppStrings.light,
          onTap: () async {
            final result = await SelectionListSheet.show<bool>(
              context,
              title: AppStrings.selectTheme,
              selectedValue: isDark,
              items: [
                SelectionItem(
                  label: AppStrings.light,
                  value: false,
                  icon: FontAwesomeIcons.sun,
                ),
                SelectionItem(
                  label: AppStrings.dark,
                  value: true,
                  icon: FontAwesomeIcons.moon,
                ),
              ],
            );

            if (result != null && result != isDark) {
              themeController.toggleTheme();
            }
          },
        );
      },
    );
  }

  Widget _buildLanguageSelector(BuildContext context) {
    final currentLocale = context.locale;

    return DrawerMenuItem(
      icon: FontAwesomeIcons.globe,
      label: AppStrings.selectLanguage,
      value: _getLanguageName(currentLocale),
      onTap: () async {
        final result = await SelectionListSheet.show<AppLanguage>(
          context,
          title: AppStrings.selectLanguage,
          selectedValue: _getAppLanguageFromLocale(currentLocale),
          items: [
            SelectionItem(label: AppStrings.languageEN, value: AppLanguage.en),
            SelectionItem(label: AppStrings.languageAR, value: AppLanguage.ar),
            SelectionItem(label: AppStrings.languageNL, value: AppLanguage.nl),
            SelectionItem(label: AppStrings.languageDE, value: AppLanguage.de),
            SelectionItem(label: AppStrings.languagePL, value: AppLanguage.pl),
            SelectionItem(
              label: AppLanguageX(AppLanguage.uk).code.toUpperCase(),
              value: AppLanguage.uk,
            ),
            SelectionItem(label: AppStrings.languageFR, value: AppLanguage.fr),
            SelectionItem(label: AppStrings.languageES, value: AppLanguage.es),
            SelectionItem(label: AppStrings.languageRO, value: AppLanguage.ro),
          ],
        );

        if (result != null && context.mounted) {
          await getIt<LocaleService>().changeLanguage(result, context);
        }
      },
    );
  }

  String _getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return AppStrings.languageEN;
      case 'ar':
        return AppStrings.languageAR;
      case 'nl':
        return AppStrings.languageNL;
      case 'de':
        return AppStrings.languageDE;
      case 'pl':
        return AppStrings.languagePL;
      case 'uk':
        return 'UK';
      case 'fr':
        return AppStrings.languageFR;
      case 'es':
        return AppStrings.languageES;
      case 'ro':
        return AppStrings.languageRO;
      default:
        return AppStrings.languageEN;
    }
  }

  AppLanguage _getAppLanguageFromLocale(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return AppLanguage.en;
      case 'ar':
        return AppLanguage.ar;
      case 'nl':
        return AppLanguage.nl;
      case 'de':
        return AppLanguage.de;
      case 'pl':
        return AppLanguage.pl;
      case 'uk':
        return AppLanguage.uk;
      case 'fr':
        return AppLanguage.fr;
      case 'es':
        return AppLanguage.es;
      case 'ro':
        return AppLanguage.ro;
      default:
        return AppLanguage.en;
    }
  }

  Future<void> _handleLogout(BuildContext context) async {
    final confirm = await AppDialog.show<bool>(
      context,
      dialog: AppDialog.basic(
        title: AppStrings.logout,
        message: AppStrings.logoutConfirmMessage,
        secondaryAction: AppDialogAction.secondary(
          label: AppStrings.cancel,
          onPressed: () => Navigator.pop(context, false),
        ),
        primaryAction: AppDialogAction.danger(
          label: AppStrings.logout,
          onPressed: () => Navigator.pop(context, true),
        ),
      ),
    );

    if (confirm == true) {
      await getIt<AuthManager>().logout();
    }
  }
}
