import 'package:demo_movies_app/core/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RegisterFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const RegisterFieldWidget({
    Key? key,
    required this.hintText,
    this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      hintText: hintText,
      textController: controller,
      borderSideColor: Colors.white.withOpacity(0.5),
      focusBorderColor: Colors.white.withOpacity(0.5),
      borderRadius: 8,
      validator: validator,
    );
  }
}
