class AppLocalizationConfig {
  /// Path where JSON localization files live.
  static const String translationsPath = 'assets/l10n';

  /// Fallback language code used by the app and generator.
  static const String fallbackLanguageCode = 'nl';

  /// All supported language codes. Add new languages here only
  /// (e.g. 'tr', 'fr'), and both EasyLocalization and the
  /// AppStrings generator will pick them up.
  static const List<String> supportedLanguageCodes = <String>[
    'en',
    'ar',
    'nl',
    'de',
    'pl',
    'uk',
    'fr',
    'es',
    'ro',
  ];
}

/// High-level language enum used across the app.
///
/// Keep this in sync with [AppLocalizationConfig.supportedLanguageCodes].
enum AppLanguage { ar, en, nl, de, pl, uk, fr, es, ro }

extension AppLanguageX on AppLanguage {
  /// Returns the language code as used in JSON files and headers.
  String get code {
    switch (this) {
      case AppLanguage.ar:
        return 'ar';
      case AppLanguage.en:
        return 'en';
      case AppLanguage.nl:
        return 'nl';
      case AppLanguage.de:
        return 'de';
      case AppLanguage.pl:
        return 'pl';
      case AppLanguage.uk:
        return 'uk';
      case AppLanguage.fr:
        return 'fr';
      case AppLanguage.es:
        return 'es';
      case AppLanguage.ro:
        return 'ro';
    }
  }
}

