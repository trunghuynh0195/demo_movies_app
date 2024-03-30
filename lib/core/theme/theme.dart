import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_text_theme.dart';

class AppThemeData {
  AppThemeData._();

  static final ThemeData light = _themeData(lightScheme, AppColors.lightFocusColor);
  static final ThemeData dark = _themeData(darkScheme, AppColors.darkFocusColor);

  static const ColorScheme lightScheme = ColorScheme(
    primary: AppColors.primary,
    primaryContainer: AppColors.primaryContainer,
    secondary: AppColors.secondary,
    secondaryContainer: AppColors.secondaryContainer,
    brightness: Brightness.light,
    background: AppColors.backgroundLight,
    onBackground: AppColors.onBackgroundLight,
    surface: AppColors.primary,
    error: AppColors.error,
    onError: AppColors.lightFillColor,
    onPrimary: AppColors.lightFillColor,
    onSecondary: Color(0xFF322942),
    onSurface: Color(0xFF241E30),
  );

  static const ColorScheme darkScheme = ColorScheme(
    primary: AppColors.primary,
    primaryContainer: AppColors.primaryContainer,
    secondary: AppColors.secondary,
    secondaryContainer: AppColors.secondaryContainer,
    background: AppColors.backgroundDark,
    surface: AppColors.surfaceDark,
    onBackground: AppColors.onBackgroundDark,
    error: AppColors.error,
    onError: AppColors.darkFillColor,
    onPrimary: AppColors.darkFillColor,
    onSecondary: AppColors.darkFillColor,
    onSurface: AppColors.darkFillColor,
    brightness: Brightness.dark,
  );

  static ThemeData _themeData(ColorScheme colorScheme, Color focusColor) {
    final isDark = colorScheme.brightness == Brightness.dark;
    final txtColor = isDark ? AppColors.darkText : AppColors.lightText;

    return ThemeData(
      colorScheme: colorScheme,
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      textTheme: AppTextTheme.theme.apply(
        bodyColor: txtColor,
        displayColor: txtColor,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.onBackground,
        selectedItemColor: colorScheme.primary,
        showUnselectedLabels: false,
        elevation: 1,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.onBackground,
        elevation: 1,
        systemOverlayStyle: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.alphaBlend(
          AppColors.lightFillColor.withOpacity(0.8),
          AppColors.darkFillColor,
        ),
        contentTextStyle: AppTextTheme.theme.bodySmall,
      ),
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
      useMaterial3: true,
    );
  }
}
