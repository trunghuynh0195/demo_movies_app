import 'package:demo_movies_app/core/extensions/extensions.dart';
import 'package:demo_movies_app/core/theme/app_colors.dart';
import 'package:demo_movies_app/core/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class LoginFieldWidget extends StatefulWidget {
  final String title;
  final bool isPasswordField;
  final String? hintText;
  final TextEditingController? textController;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const LoginFieldWidget({
    Key? key,
    required this.title,
    this.isPasswordField = false,
    this.hintText,
    this.textController,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  State<LoginFieldWidget> createState() => _LoginFieldWidgetState();
}

class _LoginFieldWidgetState extends State<LoginFieldWidget> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.title,
          style: context.textTheme.bodySmall?.copyWith(
            color: Colors.white.withOpacity(0.7),
            fontSize: 10,
          ),
        ),
        const SizedBox(height: 10),
        AppTextField(
          borderRadius: 50,
          textController: widget.textController,
          hintText: widget.hintText,
          hintTextSize: 12,
          borderSideColor: AppColors.lightBorderColor.withOpacity(0.2),
          validator: widget.validator,
          suffixIcon: _buildSuffixIcon(),
          onChanged: widget.onChanged,
          suffixIconConstraints: const BoxConstraints(maxHeight: 50, minHeight: 50),
          isObscure: showPassword && widget.isPasswordField,
        ),
      ],
    );
  }

  Widget _buildSuffixIcon() {
    if (!widget.isPasswordField) return const SizedBox();
    return IconButton(
      onPressed: () => setState(() => showPassword = !showPassword),
      icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
    );
  }
}
