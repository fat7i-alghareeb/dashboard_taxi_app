import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Theme-driven gradients and shadows.
///
/// Use these through `BuildContext`:
///
/// ```dart
/// decoration: BoxDecoration(
///   gradient: context.gradients.primary,
///   boxShadow: context.shadows.primary,
/// )
/// ```
///
/// Or use the fixed (non-theme) values:
///
/// ```dart
/// gradient: AppThemeGradients.fixed,
/// boxShadow: AppThemeShadows.fixed,
/// ```
///
/// The `context.gradients` and `context.shadows` getters are provided by
/// `utils/extensions/theme_extensions.dart`.

/// Static entry points for obtaining theme-aware gradients and shadows.
///
/// This is intentionally a pure facade (no DI). Values are derived from the
/// current `ThemeData` so they always reflect light/dark mode changes.
class AppThemeEffects {
  AppThemeEffects._();

  static AppThemeGradients gradients(ThemeData theme) => AppThemeGradients(
    colorScheme: theme.colorScheme,
    brightness: theme.brightness,
  );

  static AppThemeShadows shadows(ThemeData theme) => AppThemeShadows(
    colorScheme: theme.colorScheme,
    brightness: theme.brightness,
  );
}

class AppGradientSpec {
  const AppGradientSpec({
    required this.begin,
    required this.end,
    required this.lightStartAlpha,
    required this.lightEndAlpha,
    required this.darkStartAlpha,
    required this.darkEndAlpha,
  });

  final Alignment begin;
  final Alignment end;

  final double lightStartAlpha;
  final double lightEndAlpha;

  final double darkStartAlpha;
  final double darkEndAlpha;
}

class AppShadowSpec {
  const AppShadowSpec({
    required this.blurRadius,
    required this.offset,
    required this.lightOpacity,
    required this.darkOpacity,
  });

  final double blurRadius;
  final Offset offset;

  final double lightOpacity;
  final double darkOpacity;
}

/// Theme-aware gradients derived from the current `ThemeData`.
///
/// Prefer accessing these through `BuildContext`:
///
/// ```dart
/// final g = context.gradients;
/// final gradient = g.primary;
/// ```
class AppThemeGradients {
  const AppThemeGradients({
    required this.colorScheme,
    required this.brightness,
  });

  final ColorScheme colorScheme;
  final Brightness brightness;

  static const AppGradientSpec _primarySpec = AppGradientSpec(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    lightStartAlpha: 0.8,
    lightEndAlpha: 0.7,
    darkStartAlpha: 0.8,
    darkEndAlpha: 0.6,
  );

  static const AppGradientSpec _successSpec = AppGradientSpec(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    lightStartAlpha: 0.8,
    lightEndAlpha: 0.7,
    darkStartAlpha: 0.8,
    darkEndAlpha: 0.6,
  );

  static const AppGradientSpec _errorSpec = AppGradientSpec(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    lightStartAlpha: 0.8,
    lightEndAlpha: 0.7,
    darkStartAlpha: 0.8,
    darkEndAlpha: 0.6,
  );

  static const AppGradientSpec _warningSpec = AppGradientSpec(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    lightStartAlpha: 0.8,
    lightEndAlpha: 0.7,
    darkStartAlpha: 0.8,
    darkEndAlpha: 0.6,
  );

  static const AppGradientSpec _greySpec = AppGradientSpec(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    lightStartAlpha: 0.8,
    lightEndAlpha: 0.7,
    darkStartAlpha: 0.8,
    darkEndAlpha: 0.6,
  );

  static const AppGradientSpec _auroraSpec = AppGradientSpec(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    lightStartAlpha: 0.95,
    lightEndAlpha: 0.85,
    darkStartAlpha: 0.86,
    darkEndAlpha: 0.74,
  );

  static const AppGradientSpec _auroraSoftSpec = AppGradientSpec(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    lightStartAlpha: 0.34,
    lightEndAlpha: 0.24,
    darkStartAlpha: 0.26,
    darkEndAlpha: 0.16,
  );

  LinearGradient get primary =>
      _twoTone(colorScheme.primary, spec: _primarySpec);

  LinearGradient get success => _twoTone(AppColors.success, spec: _successSpec);

  LinearGradient get error => _twoTone(AppColors.error, spec: _errorSpec);

  LinearGradient get warning => _twoTone(AppColors.warning, spec: _warningSpec);

  LinearGradient get grey => _twoTone(colorScheme.outline, spec: _greySpec);

  LinearGradient get aurora => LinearGradient(
    begin: _auroraSpec.begin,
    end: _auroraSpec.end,
    colors: <Color>[
      colorScheme.primary.withValues(alpha: _auroraSpec.lightStartAlpha),
      colorScheme.tertiary.withValues(alpha: _auroraSpec.lightEndAlpha),
      AppColors.warning.withValues(alpha: 0.45),
    ],
  );

  LinearGradient get auroraSoft => LinearGradient(
    begin: _auroraSoftSpec.begin,
    end: _auroraSoftSpec.end,
    colors: <Color>[
      colorScheme.primaryContainer.withValues(
        alpha: _auroraSoftSpec.lightStartAlpha,
      ),
      colorScheme.secondaryContainer.withValues(
        alpha: _auroraSoftSpec.lightEndAlpha,
      ),
      colorScheme.tertiaryContainer.withValues(alpha: 0.18),
    ],
  );

  static const LinearGradient fixed = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[Color(0xFF8B5CF6), Color(0xFF3B82F6)],
  );

  LinearGradient _twoTone(Color base, {required AppGradientSpec spec}) {
    return LinearGradient(
      begin: spec.begin,
      end: spec.end,
      colors: <Color>[
        base.withValues(alpha: spec.lightStartAlpha),
        base.withValues(alpha: spec.lightEndAlpha),
      ],
    );
  }
}

/// Theme-aware shadows derived from the current `ThemeData`.
///
/// Prefer accessing these through `BuildContext`:
///
/// ```dart
/// final s = context.shadows;
/// final shadow = s.primary;
/// ```
class AppThemeShadows {
  const AppThemeShadows({required this.colorScheme, required this.brightness});

  final ColorScheme colorScheme;
  final Brightness brightness;

  static const AppShadowSpec _primarySpec = AppShadowSpec(
    blurRadius: 22,
    offset: Offset(0, 12),
    lightOpacity: 0.4,
    darkOpacity: 0.3,
  );

  static const AppShadowSpec _successSpec = AppShadowSpec(
    blurRadius: 18,
    offset: Offset(0, 10),
    lightOpacity: 0.65,
    darkOpacity: 0.42,
  );

  static const AppShadowSpec _errorSpec = AppShadowSpec(
    blurRadius: 20,
    offset: Offset(0, 10),
    lightOpacity: 0.65,
    darkOpacity: 0.48,
  );

  static const AppShadowSpec _warningSpec = AppShadowSpec(
    blurRadius: 16,
    offset: Offset(0, 9),
    lightOpacity: 0.18,
    darkOpacity: 0.40,
  );

  static const AppShadowSpec _greySpec = AppShadowSpec(
    blurRadius: 14,
    offset: Offset(0, 6),
    lightOpacity: 0.42,
    darkOpacity: 0.15,
  );

  static const AppShadowSpec _auroraSpec = AppShadowSpec(
    blurRadius: 24,
    offset: Offset(0, 12),
    lightOpacity: 0.24,
    darkOpacity: 0.30,
  );

  List<BoxShadow> get primary =>
      _colored(colorScheme.outline, spec: _primarySpec);

  List<BoxShadow> get success =>
      _colored(AppColors.success, spec: _successSpec);

  List<BoxShadow> get error => _colored(AppColors.error, spec: _errorSpec);

  List<BoxShadow> get warning =>
      _colored(AppColors.warning, spec: _warningSpec);

  List<BoxShadow> get grey => _colored(colorScheme.outline, spec: _greySpec);

  List<BoxShadow> get auroraGlow {
    final primaryAlpha = brightness == Brightness.dark ? 0.28 : 0.18;
    final tertiaryAlpha = brightness == Brightness.dark ? 0.22 : 0.14;

    return <BoxShadow>[
      ..._colored(colorScheme.primary, spec: _auroraSpec),
      BoxShadow(
        color: colorScheme.tertiary.withValues(alpha: tertiaryAlpha),
        blurRadius: 30,
        offset: const Offset(0, 16),
      ),
      BoxShadow(
        color: colorScheme.primary.withValues(alpha: primaryAlpha),
        blurRadius: 12,
        offset: const Offset(0, 3),
      ),
    ];
  }

  static const List<BoxShadow> fixed = <BoxShadow>[
    BoxShadow(color: Color(0x33000000), blurRadius: 16, offset: Offset(0, 8)),
  ];

  List<BoxShadow> _colored(Color base, {required AppShadowSpec spec}) {
    final opacity = brightness == Brightness.dark
        ? spec.darkOpacity
        : spec.lightOpacity;

    return <BoxShadow>[
      BoxShadow(
        color: base.withValues(alpha: opacity),
        blurRadius: spec.blurRadius,
        offset: spec.offset,
      ),
    ];
  }
}
