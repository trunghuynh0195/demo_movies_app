import 'package:demo_movies_app/core/extensions/extensions.dart';
import 'package:demo_movies_app/core/theme/app_colors.dart';
import 'package:demo_movies_app/core/theme/dimension.dart';
import 'package:demo_movies_app/core/utils/enums/app_button_type.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final void Function()? onPressed;
  final AppButtonType type;
  final String? label;
  final Widget? child;
  final Widget? icon;
  final List<Color>? colors;
  final Color? outlineColor;
  final TextStyle? labelStyle;
  final Color? labelColor;
  final EdgeInsetsGeometry? padding;
  final Color shadowColor;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? borderSideColor;
  final Color? surfaceTintColor;
  final Color? foregroundColor;
  final double? height;
  final double? width;
  final double? elevation;

  const AppButton({
    Key? key,
    this.type = AppButtonType.primary,
    required this.onPressed,
    this.label,
    this.child,
    this.icon,
    this.colors,
    this.outlineColor,
    this.labelStyle,
    this.padding,
    this.shadowColor = Colors.transparent,
    this.height,
    this.borderRadius,
    this.backgroundColor,
    this.borderSideColor,
    this.elevation = 0,
    this.width,
    this.foregroundColor,
    this.surfaceTintColor,
    this.labelColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final minSize = Size.fromHeight(height ?? AppDimension.componentHeight);
    final textColor = labelColor ?? (onPressed == null ? AppColors.lightBodySmallText : Colors.white);
    final defaultTextStyle = context.primaryTextTheme.labelLarge?.copyWith(color: textColor);
    final fontSize = context.primaryTextTheme.bodyMedium?.fontSize;

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? minSize.height * 0.5),
      side: BorderSide(color: borderSideColor ?? Colors.transparent),
    );

    final childWidget = child ??
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[icon!, const SizedBox(width: 4)],
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 1),
                  child: Text(
                    label ?? '',
                    style: labelStyle ?? defaultTextStyle,
                  ),
                ),
              ),
            ),
          ],
        );

    switch (type) {
      case AppButtonType.link:
        return TextButton(
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: EdgeInsets.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: onPressed,
          child: Text(
            label ?? "",
            style: defaultTextStyle?.copyWith(
              color: AppColors.blue,
              fontStyle: FontStyle.italic,
              decoration: TextDecoration.underline,
            ),
          ),
        );
      case AppButtonType.text:
        Color rawLabelColor = labelStyle?.color ?? labelColor ?? AppColors.primary;
        Color? defaultLabelColor = onPressed == null ? AppColors.lightSubText : rawLabelColor;

        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: onPressed,
          child: Padding(
            padding: padding ?? EdgeInsets.zero,
            child: SizedBox(
              height: height,
              width: width,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label ?? '',
                  style: (labelStyle ?? defaultTextStyle)?.copyWith(color: defaultLabelColor),
                ),
              ),
            ),
          ),
        );
      case AppButtonType.ghost:
        return TextButton(
          onPressed: onPressed,
          child: child ?? Text(label ?? '', style: TextStyle(fontSize: fontSize)),
        );

      case AppButtonType.outline:
        return OutlinedButton(
          style: OutlinedButton.styleFrom(
            minimumSize: minSize,
            shape: shape,
            side: BorderSide(
              color: outlineColor ?? AppColors.primary,
              width: 1,
            ),
          ),
          onPressed: onPressed,
          child: childWidget,
        );

      default:
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            shadowColor: shadowColor,
            elevation: elevation,
            shape: shape,
            padding: padding ?? const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            backgroundColor: backgroundColor ?? context.theme.primaryColor,
            surfaceTintColor: surfaceTintColor ?? AppColors.lightBodySmallText,
            foregroundColor: foregroundColor ?? AppColors.lightBodySmallText,
            minimumSize: Size(width ?? double.infinity, height ?? AppDimension.componentHeight),
            maximumSize: Size(width ?? double.infinity, height ?? AppDimension.componentHeight),
          ),
          onPressed: onPressed,
          child: childWidget,
        );
    }
  }
}
