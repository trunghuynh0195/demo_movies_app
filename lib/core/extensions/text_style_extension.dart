import 'package:demo_movies_app/core/theme/app_text_theme.dart';
import 'package:flutter/material.dart';

extension TextStyleExt on TextStyle {
  TextStyle get light => copyWith(fontWeight: AppTextTheme.light);
  TextStyle get regular => copyWith(fontWeight: AppTextTheme.regular);
  TextStyle get medium => copyWith(fontWeight: AppTextTheme.medium);
  TextStyle get semiBold => copyWith(fontWeight: AppTextTheme.semiBold);
  TextStyle get bold => copyWith(fontWeight: AppTextTheme.bold);
  TextStyle get xBold => copyWith(fontWeight: AppTextTheme.xBold);
  TextStyle get black => copyWith(fontWeight: AppTextTheme.black);
}
