import 'package:flutter/material.dart';

/// Theme-agnostic static colors used across the app.
///
/// Use these for semantic feedback (success, warning, etc.) that do not
/// change between light and dark themes.
class AppColors {
  AppColors._();

  /// Primary Color (Vibrant Orange)
  static const Color primary = Color(0xFFd79c5c);
  static const Color primaryLight = Color.fromARGB(255, 211, 144, 71);
  static const Color primaryDark = Color(0xFFd79c5c);

  /// Secondary Color (Deep Slate)
  /// Provides a clean, modern, cool-toned contrast to the warm orange primary.
  static const Color secondary = Color(0xFF2D3142);
  static const Color secondaryLight = Color(0xFF4F5D75);
  static const Color secondaryDark = Color(0xFF1C1F2B);

  /// Accent Color (Deep Teal)
  /// A complementary color used to make certain elements pop against the backgrounds.
  static const Color accent = Color(0xFF0081A7);

  /// Platinum (Warm tinted off-white)
  static const Color platinum = Color(0xFFEAE8E3);

  /// Background Colors
  /// Light mode gets a warm, airy tint; Dark mode is a very deep, warm off-black.
  static const Color backGroundLight = Color(0xFFFDFBF9);
  static const Color backGroundDark = Color(0xFF1A1614);

  /// Surface Colors
  /// Slightly elevated from backgrounds.
  static const Color surfaceLight = Color(0xFFFDFBF9);
  static const Color surfaceDark = Color(0xFF1A1614);

  /// Grey/Muted Colors
  /// Shifted to have slight warm/earthy undertones to blend with the orange theme.
  static const Color greyLight = Color(0xFFC2BCB8);
  static const Color greyDark = Color(0xFF7D7570);

  /// Color used for success/toast states (Vibrant Professional Green).
  static const Color success = Color(0xFF218356);

  /// Color used for warning states (Amber Gold).
  static const Color warning = Color(0xFFFFB703);

  /// Color used for error states (Crisp Red).
  static const Color error = Color(0xFFD90429);

  /// Color used for informational highlights (Clear Blue).
  static const Color info = Color(0xFF0077B6);

  /// Brand Gold color.
  static const Color brandGold = Color(0xFFF1B94A);

  /// Landing screen specific gold color.
  static const Color landingGold = Color(0xFFE4A030);
}
