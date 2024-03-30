import 'package:demo_movies_app/data/models/movie_models/movie_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    List<MovieModel>? moviesComingSoon,
  }) = _HomeState;
}
