import 'package:demo_movies_app/core/extensions/extensions.dart';
import 'package:flutter/material.dart';

class BaseCircularProgressIndicator extends StatelessWidget {
  final double strokeWidth;
  final Color? color;
  final double? height;
  final double? width;

  const BaseCircularProgressIndicator({
    Key? key,
    this.strokeWidth = 4.0,
    this.color,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height,
        width: width,
        child: CircularProgressIndicator(
          color: color ?? context.theme.primaryColor,
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}
