import 'package:demo_movies_app/core/extensions/extensions.dart';
import 'package:demo_movies_app/core/theme/app_colors.dart';
import 'package:demo_movies_app/core/theme/dimension.dart';
import 'package:demo_movies_app/core/utils/base_cached_network_image.dart';
import 'package:demo_movies_app/data/models/movie_models/movie_model.dart';
import 'package:demo_movies_app/views/home/widgets/movie_detail/widgets/movies_detail_buttons.dart';
import 'package:flutter/material.dart';

class MovieDetailScreen extends StatelessWidget {
  final MovieModel movieModel;
  const MovieDetailScreen({Key? key, required this.movieModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: 240,
                width: double.infinity,
                foregroundDecoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                ),
                child: BaseCachedNetworkImage(
                  imageUrl: movieModel.posterurl ?? '',
                  borderRadius: 0,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BackButton(),
                  const SizedBox(height: 32),
                  _buildForegroundImage(),
                  const SizedBox(height: 20),
                  MoviesDetailButtons(movieModel: movieModel),
                  const SizedBox(height: 30),
                  _buildMovieInfo(context),
                  const SizedBox(height: 30),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForegroundImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 16),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 8,
              ),
            ],
          ),
          child: BaseCachedNetworkImage(
            imageUrl: movieModel.posterurl ?? '',
            height: 250,
            width: 180,
          ),
        ),
        Container(
          height: 80,
          width: 80,
          margin: const EdgeInsets.only(top: 70, right: 40),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 8,
              ),
            ],
          ),
          child: const Icon(
            Icons.play_arrow,
            color: Colors.white,
            size: 60,
          ),
        ),
      ],
    );
  }

  Widget _buildMovieInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimension.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            movieModel.title ?? '',
            style: context.textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          Text(
            movieModel.storyline ?? '',
            style: context.textTheme.bodySmall?.copyWith(),
          ),
        ],
      ),
    );
  }
}
