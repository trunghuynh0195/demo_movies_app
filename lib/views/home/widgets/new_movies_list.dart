import 'package:demo_movies_app/core/extensions/extensions.dart';
import 'package:demo_movies_app/core/routes/app_screens.dart';
import 'package:demo_movies_app/core/theme/app_colors.dart';
import 'package:demo_movies_app/core/utils/base_cached_network_image.dart';
import 'package:demo_movies_app/data/models/movie_models/movie_model.dart';
import 'package:demo_movies_app/views/home/view_model/home_view_model.dart';
import 'package:demo_movies_app/views/home/widgets/skelton_movie_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NewMoviesList extends ConsumerWidget {
  const NewMoviesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var movies = ref.watch(homeViewModel.select((state) => state.moviesComingSoon));

    if (movies == null) return _placeholderList();
    return SizedBox(
      height: 244,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: movies.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, index) {
          return _buildMovieItem(context, movies[index]);
        },
      ),
    );
  }

  Widget _placeholderList() {
    return SizedBox(
      height: 244,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: 20,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, index) {
          return SkeltonMovieItem(
            key: Key(DateTime.now().microsecondsSinceEpoch.toString()),
            height: 200,
            borderRadius: 12,
          );
        },
      ),
    );
  }

  Widget _buildMovieItem(
    BuildContext context,
    MovieModel movieModel,
  ) {
    return GestureDetector(
      onTap: () => context.pushNamed(AppScreens.movieDetail.getName, extra: movieModel),
      behavior: HitTestBehavior.translucent,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Container(
          width: 150,
          decoration: const BoxDecoration(
            color: AppColors.lightDarkBackgroundColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 160,
                width: double.infinity,
                child: BaseCachedNetworkImage(
                  borderRadius: 0,
                  imageUrl: movieModel.posterurl ?? '',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      movieModel.title ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.labelLarge,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      movieModel.genres?.join('/') ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.bodySmall?.copyWith(
                        fontSize: 10,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.yellow, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          movieModel.averageRating.toString(),
                          style: context.textTheme.bodySmall?.copyWith(
                            fontSize: 10,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
