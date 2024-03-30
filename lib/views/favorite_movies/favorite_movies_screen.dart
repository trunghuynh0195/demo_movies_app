import 'package:demo_movies_app/core/extensions/extensions.dart';
import 'package:demo_movies_app/core/routes/routes.dart';
import 'package:demo_movies_app/core/theme/dimension.dart';
import 'package:demo_movies_app/core/utils/app_strings.dart';
import 'package:demo_movies_app/core/utils/base_cached_network_image.dart';
import 'package:demo_movies_app/core/widgets/favorite_movie_widget.dart';
import 'package:demo_movies_app/data/models/movie_models/movie_model.dart';
import 'package:demo_movies_app/views/favorite_movies/view_model/favorite_movies_view_model.dart';
import 'package:demo_movies_app/views/home/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FavoriteMoviesScreen extends ConsumerStatefulWidget {
  const FavoriteMoviesScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<FavoriteMoviesScreen> createState() => _FavoriteMoviesScreenState();
}

class _FavoriteMoviesScreenState extends ConsumerState<FavoriteMoviesScreen> {
  late final FavoriteMoviesViewModel _favoriteMoviesVM;

  @override
  void initState() {
    super.initState();
    _favoriteMoviesVM = ref.read(favoriteMoviesViewModel.notifier);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      List<MovieModel> movies = ref.read(homeViewModel).moviesComingSoon ?? [];
      _favoriteMoviesVM.initData(movies);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimension.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Text(
            AppStrings.favorites,
            style: context.textTheme.titleLarge,
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Consumer(
              builder: (_, ref, child) {
                var movies = ref.watch(favoriteMoviesViewModel.select((state) => state.favoriteMovies)) ?? [];

                if (movies.isEmpty) return const Center(child: Text(AppStrings.noFavoriteMovies));
                return ListView.separated(
                  physics: const PageScrollPhysics(),
                  itemCount: movies.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (_, index) {
                    return _buildItem(
                      context,
                      movies[index],
                      Key(DateTime.now().microsecondsSinceEpoch.toString()),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(
    BuildContext context,
    MovieModel movieModel,
    Key? key,
  ) {
    return GestureDetector(
      key: key,
      onTap: () => context.pushNamed(AppScreens.movieDetail.getName, extra: movieModel),
      behavior: HitTestBehavior.translucent,
      child: SizedBox(
        height: 60,
        child: Row(
          children: [
            SizedBox(
              height: 60,
              width: 80,
              child: BaseCachedNetworkImage(
                imageUrl: movieModel.posterurl ?? '',
                borderRadius: 6,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                movieModel.title ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.labelLarge,
              ),
            ),
            const SizedBox(width: 14),
            FavoriteMovieWidget(
              movieId: movieModel.id ?? '',
              onChanged: (isFavorite) => _favoriteMoviesVM.onFavoriteMovie(isFavorite, movieModel),
            ),
          ],
        ),
      ),
    );
  }
}
