import 'package:demo_movies_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeltonMovieItem extends StatelessWidget {
  final double height;
  final double width;
  final double borderRadius;
  final bool isImageItem;

  const SkeltonMovieItem({
    Key? key,
    this.height = 90,
    this.width = 160,
    this.borderRadius = 0,
    this.isImageItem = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      child: Container(
        height: height,
        width: width,
        color: AppColors.lightDarkBackgroundColor,
        child: Shimmer.fromColors(
          baseColor: AppColors.unknownAvatarBackground,
          highlightColor: AppColors.whiteSmoke,
          child: isImageItem
              ? Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.white,
                )
              : Column(
                  children: [
                    Container(
                      height: 160,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 10),
                            _buildSkelton(
                              padding: 46,
                              height: 14,
                            ),
                            const SizedBox(height: 10),
                            _buildSkelton(),
                            const SizedBox(height: 12),
                            _buildSkelton(width: 48, height: 8),
                            const SizedBox(height: 6),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildSkelton({
    double height = 10,
    double? width,
    double borderRadius = 0,
    double padding = 16,
  }) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.only(right: padding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      ),
    );
  }
}
