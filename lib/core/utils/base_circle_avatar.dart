import 'package:demo_movies_app/core/extensions/extensions.dart';
import 'package:demo_movies_app/core/extensions/string_extension.dart';
import 'package:demo_movies_app/core/theme/app_colors.dart';
import 'package:demo_movies_app/core/utils/base_cached_network_image.dart';
import 'package:flutter/material.dart';

class BaseCircleAvatar extends StatelessWidget {
  final String imageUrl;
  final String name;
  final double? height;
  final double? width;
  final double imageBorderRadius;
  final Widget? errorWidget;
  final BoxFit? fit;
  final Color? backgroundColorAvatarWithInitialsName;

  const BaseCircleAvatar({
    Key? key,
    required this.imageUrl,
    this.name = '',
    this.height,
    this.width,
    this.imageBorderRadius = 100,
    this.errorWidget,
    this.fit,
    this.backgroundColorAvatarWithInitialsName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseCachedNetworkImage(
      height: height ?? 33,
      width: width ?? 33,
      borderRadius: imageBorderRadius,
      fit: fit ?? BoxFit.fill,
      imageUrl: imageUrl,
      circularProgressStrokeWidth: 1,
      errorWidget: errorWidget ?? _buildAvatarWithInitialsName(context, name: name),
    );
  }

  Widget _buildAvatarWithInitialsName(BuildContext context, {String name = ''}) {
    String rawName = name.isEmpty ? 'User' : name;
    return Container(
      color: backgroundColorAvatarWithInitialsName ?? AppColors.primary,
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          rawName.initialsName(),
          style: context.textTheme.labelLarge?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
