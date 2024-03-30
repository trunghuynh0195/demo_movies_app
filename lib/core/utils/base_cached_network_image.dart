import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_movies_app/core/theme/app_colors.dart';
import 'package:demo_movies_app/core/utils/base_circular_progress_indicator.dart';
import 'package:flutter/material.dart';

class BaseCachedNetworkImage extends StatelessWidget {
  final double borderRadius;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final String imageUrl;
  final double circularProgressStrokeWidth;
  final Color? circularProgressColor;
  final Widget? errorWidget;
  final Alignment alignment;
  final BorderRadiusGeometry? borderRadiusGeometry;
  final EdgeInsetsGeometry circularProgressPadding;

  const BaseCachedNetworkImage({
    Key? key,
    this.borderRadius = 8,
    this.height,
    this.width,
    this.fit,
    required this.imageUrl,
    this.circularProgressStrokeWidth = 2,
    this.circularProgressColor,
    this.errorWidget,
    this.alignment = Alignment.center,
    this.borderRadiusGeometry,
    this.circularProgressPadding = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadiusGeometry ?? BorderRadius.all(Radius.circular(borderRadius)),
      child: _buildImage(),
    );
  }

  Widget _buildImage() {
    if (imageUrl.isEmpty) return _buildErrorWidget();
    return CachedNetworkImage(
      height: height,
      width: width,
      fit: fit ?? BoxFit.cover,
      alignment: alignment,
      imageUrl: imageUrl,
      placeholder: (_, url) {
        return Padding(
          padding: circularProgressPadding,
          child: BaseCircularProgressIndicator(
            strokeWidth: circularProgressStrokeWidth,
            color: circularProgressColor,
          ),
        );
      },
      errorWidget: (_, url, error) {
        return _buildErrorWidget();
      },
    );
  }

  Widget _buildErrorWidget() {
    return SizedBox(
      height: height,
      width: width,
      child: errorWidget ?? const Center(child: Icon(Icons.error, color: AppColors.lightIcon)),
    );
  }
}
