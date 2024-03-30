import 'package:demo_movies_app/data/models/movie_models/movie_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_movies_state.freezed.dart';

@freezed
class FavoriteMoviesState with _$FavoriteMoviesState {
  const factory FavoriteMoviesState({
    List<MovieModel>? favoriteMovies,
  }) = _FavoriteMoviesState;
}
