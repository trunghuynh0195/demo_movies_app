import 'package:demo_movies_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class Palette {
  final Color text;
  final Color subText;
  final Color border;
  final Color shadow;

  Palette({
    required this.text,
    required this.subText,
    required this.border,
    required this.shadow,
  });

  static final light = Palette(
    text: AppColors.lightText,
    subText: AppColors.lightSubText,
    border: AppColors.lightBorderColor,
    shadow: Colors.black12,
  );

  static final dark = Palette(
    text: AppColors.darkText,
    subText: AppColors.darkSubText,
    shadow: Colors.white12,
    border: AppColors.lightBorderColor,
  );
}
