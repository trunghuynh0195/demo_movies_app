import 'package:demo_movies_app/core/extensions/extensions.dart';
import 'package:demo_movies_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum InputBorderType { outline, underline }

class AppTextField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final String? labelText;
  final TextInputType? keyboardType;
  final TextEditingController? textController;
  final EdgeInsets padding;
  final Color hintColor;
  final Color iconColor;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String>? onChanged;
  final bool isObscure;
  final bool autoFocus;
  final TextInputAction? inputAction;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? errorMaxLines;
  final int? maxLength;
  final bool enabledBorder;
  final Color backgroundColor;
  final double borderRadius;
  final Color suffixIconColor;
  final bool readOnly;
  final bool? enabled;
  final void Function()? onTap;
  final BoxConstraints? suffixIconConstraints;
  final Color? borderSideColor;
  final bool enableFocusBorderColor;
  final EdgeInsetsGeometry contentPadding;
  final double? hintTextSize;
  final InputBorderType borderType;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final List<TextInputFormatter>? inputFormatters;
  final String? prefixText;
  final BoxConstraints? prefixIconConstraints;
  final TextStyle? floatingLabelStyle;
  final bool? enableAutoValidator;
  final Color? focusBorderColor;
  final int? maxLines;
  final int? minLines;

  const AppTextField({
    Key? key,
    this.textController,
    this.errorText,
    this.keyboardType,
    this.hintText,
    this.isObscure = false,
    this.padding = const EdgeInsets.all(0),
    this.hintColor = Colors.grey,
    this.iconColor = Colors.grey,
    this.focusNode,
    this.onFieldSubmitted,
    this.onChanged,
    this.autoFocus = false,
    this.inputAction,
    this.labelText,
    this.validator,
    this.suffixIcon,
    this.prefixIcon,
    this.errorMaxLines,
    this.maxLength,
    this.enabledBorder = true,
    this.backgroundColor = Colors.transparent,
    this.borderRadius = 5.0,
    this.borderType = InputBorderType.outline,
    this.suffixIconColor = AppColors.lightIcon,
    this.readOnly = false,
    this.onTap,
    this.enabled,
    this.suffixIconConstraints,
    this.borderSideColor,
    this.enableFocusBorderColor = true,
    this.contentPadding = const EdgeInsets.all(12),
    this.hintTextSize,
    this.floatingLabelBehavior,
    this.inputFormatters,
    this.prefixText,
    this.prefixIconConstraints,
    this.floatingLabelStyle,
    this.enableAutoValidator = false,
    this.focusBorderColor,
    this.maxLines = 1,
    this.minLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final inputBorders = getInputBorders(context);

    return Padding(
      padding: padding,
      child: TextFormField(
        autovalidateMode: (enableAutoValidator ?? false) ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
        controller: textController,
        focusNode: focusNode,
        maxLines: maxLines,
        minLines: minLines,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        autofocus: autoFocus,
        textInputAction: inputAction,
        obscureText: isObscure,
        maxLength: maxLength,
        keyboardType: keyboardType,
        style: textTheme.bodyMedium,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          label: labelText != null ? FittedBox(fit: BoxFit.fitWidth, child: Text(labelText ?? "")) : null,
          labelStyle: textTheme.bodyMedium?.copyWith(color: hintColor),
          floatingLabelStyle: floatingLabelStyle ?? textTheme.bodyMedium?.copyWith(color: context.theme.primaryColor),
          hintText: hintText,
          hintStyle: textTheme.bodyMedium?.copyWith(color: hintColor, fontSize: hintTextSize),
          filled: true,
          fillColor: backgroundColor,
          border: inputBorders['border'],
          enabledBorder: inputBorders['enabled'],
          focusedBorder: inputBorders['focused'],
          isDense: true,
          contentPadding: contentPadding,
          counterText: '',
          errorText: errorText,
          errorStyle: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w200,
            fontStyle: FontStyle.italic,
          ),
          suffixIcon: suffixIcon,
          suffixIconColor: suffixIconColor,
          prefixIcon: prefixIcon,
          errorMaxLines: errorMaxLines,
          suffixIconConstraints: suffixIconConstraints,
          prefixIconConstraints: prefixIconConstraints,
          floatingLabelBehavior: floatingLabelBehavior,
          prefixText: prefixText,
        ),
        validator: validator,
        readOnly: readOnly,
        enabled: enabled,
        onTap: onTap,
      ),
    );
  }

  Map<String, InputBorder> getInputBorders(BuildContext context) {
    final bRadius = BorderRadius.circular(borderRadius);
    Color borderColor = borderSideColor ?? context.palette.border;
    Color focusBorderSideColor = focusBorderColor ?? context.theme.primaryColor;
    if (borderType == InputBorderType.underline) {
      return {
        'border': UnderlineInputBorder(borderSide: BorderSide(color: borderColor)),
        'enabled': UnderlineInputBorder(borderSide: BorderSide(color: borderColor)),
        'focused': UnderlineInputBorder(
          borderSide: BorderSide(color: focusBorderSideColor),
        )
      };
    }

    return {
      'border': OutlineInputBorder(
        borderSide: BorderSide(color: borderColor),
        borderRadius: bRadius,
      ),
      'enabled': OutlineInputBorder(
        borderSide: enabledBorder ? BorderSide(color: borderColor) : BorderSide.none,
        borderRadius: bRadius,
      ),
      'focused': OutlineInputBorder(
        borderSide: enabledBorder ? BorderSide(color: focusBorderSideColor) : BorderSide.none,
        borderRadius: bRadius,
      )
    };
  }
}
