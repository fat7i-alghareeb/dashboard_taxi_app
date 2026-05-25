import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/common/widgets/sheets/selection_list_sheet.dart';
import 'package:dashboardtaxi/core/config/localization_config.dart';
import 'package:dashboardtaxi/core/services/localization/locale_service.dart';
import 'package:dashboardtaxi/core/services/session/auth_manager.dart';
import 'package:dashboardtaxi/core/theme/theme_controller.dart';

import 'drawer/drawer_header_section.dart';
import 'drawer/drawer_logout_footer.dart';
import 'drawer/drawer_menu_item.dart';

class RootDrawerContent extends StatelessWidget {
  const RootDrawerContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              padding: REdgeInsets.only(
                top: AppSpacing.sm.h,
                bottom: AppSpacing.xl.h,
              ),
              children: [
                const DrawerHeaderSection(),
                AppSpacing.md.verticalSpace,

                // Global Settings & Configurations (Design with only essential core options)
                _buildLanguageSelector(context),
                _buildThemeSelector(context),
                DrawerMenuItem(
                  icon: FontAwesomeIcons.gear,
                  label: AppStrings.settings,
                  onTap: () {
                    // Placeholder for future settings screen, keeping it visually present and active
                  },
                ),
              ],
            ),
          ),
          DrawerLogoutFooter(onLogoutTap: () => _handleLogout(context)),
        ],
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
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppStrings.logout),
        content: Text(AppStrings.logout),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              AppStrings.logout,
              style: TextStyle(color: context.error),
            ),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await getIt<AuthManager>().logout();
    }
  }
}
