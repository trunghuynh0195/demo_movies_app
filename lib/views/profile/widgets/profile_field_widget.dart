import 'package:demo_movies_app/core/extensions/extensions.dart';
import 'package:demo_movies_app/core/theme/app_colors.dart';
import 'package:demo_movies_app/core/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ProfileFieldWidget extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController? controller;

  const ProfileFieldWidget({
    Key? key,
    required this.title,
    this.hintText = '',
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.bodySmall?.copyWith(
            color: AppColors.lightBodySmallText,
          ),
        ),
        AppTextField(
          hintText: hintText,
          textController: controller,
          borderType: InputBorderType.underline,
          borderSideColor: Colors.white,
          focusBorderColor: Colors.white,
        ),
      ],
    );
  }
}
