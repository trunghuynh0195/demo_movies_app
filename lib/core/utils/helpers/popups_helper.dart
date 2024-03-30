import 'package:demo_movies_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PopupsHelper {
  /// show snack bar
  static void showSnackBar(
    BuildContext context,
    String content, {
    bool isError = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          content,
          style: TextStyle(color: isError ? AppColors.error : Colors.white),
        ),
      ),
    );
  }
}
