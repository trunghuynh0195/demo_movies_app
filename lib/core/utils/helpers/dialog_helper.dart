import 'dart:io';

import 'package:demo_movies_app/core/extensions/extensions.dart';
import 'package:demo_movies_app/core/utils/app_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DialogHelper {
  /// show a confirming dialog
  /// return a bool value
  static Future<bool> showConfirmDialog(
    BuildContext context, {
    String? title,
    String content = '',
    String? actionText,
    String? cancelText,
    double actionTextSize = 16,
    Color actionTextColor = Colors.blue,
    TextStyle? contentTextStyle,
  }) {
    var titleTextStyle = context.textTheme.titleMedium?.copyWith(fontSize: 17);
    var defaultContentTextStyle = context.textTheme.bodyMedium;
    var actionTextStyle = context.textTheme.labelLarge?.copyWith(fontSize: actionTextSize, color: actionTextColor);

    if (Platform.isIOS) {
      return showCupertinoDialog<bool>(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: title != null ? Text(title, style: titleTextStyle) : null,
            content: Text(content, style: contentTextStyle ?? defaultContentTextStyle),
            actions: [
              CupertinoDialogAction(
                onPressed: () => context.pop(false),
                child: Text(cancelText ?? AppStrings.no, style: actionTextStyle),
              ),
              CupertinoDialogAction(
                onPressed: () => context.pop(true),
                child: Text(actionText ?? AppStrings.yes, style: actionTextStyle),
              ),
            ],
          );
        },
      ).then((value) => value ?? false);
    }
    return showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: title != null ? Text(title, style: titleTextStyle) : null,
        content: Text(content, style: defaultContentTextStyle),
        actions: [
          TextButton(
            onPressed: () => context.pop(false),
            child: Text(AppStrings.no, style: actionTextStyle),
          ),
          TextButton(
            onPressed: () => context.pop(true),
            child: Text(actionText ?? AppStrings.yes, style: actionTextStyle),
          ),
        ],
      ),
    ).then((value) => value ?? false);
  }
}
