import 'package:demo_movies_app/data/models/movie_models/movie_model.dart';
import 'package:demo_movies_app/data/storage/pref.dart';
import 'package:demo_movies_app/views/favorite_movies/view_model/favorite_movies_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FavoriteMoviesViewModel extends StateNotifier<FavoriteMoviesState> {
  FavoriteMoviesViewModel() : super(const FavoriteMoviesState());

  // set function

  void setFavoriteMovies(List<MovieModel>? value) {
    if (!mounted) return;
    state = state.copyWith(favoriteMovies: value);
  }

  void onFavoriteMovie(bool isFavorite, MovieModel movieModel) {
    List<MovieModel> movies = [...state.favoriteMovies ?? []];
    if (isFavorite) {
      movies.add(movieModel);
    } else {
      movies.remove(movieModel);
    }
    setFavoriteMovies(movies.toSet().toList());
  }

  void initData(List<MovieModel> currentMovies) {
    List<String> favoritedMovieIds = Storage.favoriteMovies;
    List<MovieModel> favoritedMovies = currentMovies.where(
      (currentMovie) {
        return favoritedMovieIds.any((favoritedMovieId) => favoritedMovieId == currentMovie.id);
      },
    ).toList();
    setFavoriteMovies(favoritedMovies);
  }
}

final favoriteMoviesViewModel = StateNotifierProvider<FavoriteMoviesViewModel, FavoriteMoviesState>((ref) => FavoriteMoviesViewModel());
