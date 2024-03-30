import 'package:demo_movies_app/core/theme/app_colors.dart';
import 'package:demo_movies_app/core/widgets/favorite_movie_widget.dart';
import 'package:demo_movies_app/data/models/movie_models/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MoviesDetailButtons extends ConsumerWidget {
  final MovieModel movieModel;
  const MoviesDetailButtons({Key? key, required this.movieModel}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        children: [
          _buildButton(icon: Icons.add, onTap: () {}),
          const SizedBox(width: 20),
          _buildButton(
            icon: Icons.favorite_border_rounded,
            child: FavoriteMovieWidget(
              movieId: movieModel.id ?? '',
              onChanged: (isFavorite) {},
            ),
          ),
          const SizedBox(width: 20),
          _buildButton(icon: Icons.download, onTap: () {}),
          const SizedBox(width: 20),
          _buildButton(icon: Icons.share, onTap: () {}),
        ],
      ),
    );
  }

  Widget _buildButton({
    Widget? child,
    required IconData icon,
    void Function()? onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.translucent,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.lightDarkBackgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: AppColors.lightDarkBackgroundColor.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 4,
              ),
            ],
          ),
          child: child ?? Icon(icon, size: 30, color: Colors.white),
        ),
      ),
    );
  }
}
