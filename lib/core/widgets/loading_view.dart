import 'package:demo_movies_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  final Color? backgroundColor;
  final Color? circularProgressColor;
  const LoadingView({
    Key? key,
    this.backgroundColor,
    this.circularProgressColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(color: backgroundColor ?? Colors.grey.withOpacity(0.4)),
      alignment: Alignment.center,
      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(circularProgressColor ?? AppColors.primary)),
    );
  }
}
