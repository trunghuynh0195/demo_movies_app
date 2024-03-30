import 'package:demo_movies_app/data/models/movie_models/movie_model.dart';
import 'package:demo_movies_app/data/repositories/movie_repository/movie_repository.dart';
import 'package:demo_movies_app/views/home/view_model/home_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeViewModel extends StateNotifier<HomeState> {
  HomeViewModel(this._ref) : super(const HomeState());

  final Ref _ref;
  late final _movieRepository = _ref.read(movieRepositoryProvider);

  // set function

  void setMoviesComingSoon(List<MovieModel>? value) {
    if (!mounted) return;
    state = state.copyWith(moviesComingSoon: value);
  }

  /// get movie coming soon lists
  Future<void> getMoviesComingSoon() async {
    try {
      setMoviesComingSoon(null);
      var movies = await _movieRepository.getMoviesComingSoon();
      setMoviesComingSoon(movies);
    } catch (_) {
      rethrow;
    }
  }
}

final homeViewModel = StateNotifierProvider.autoDispose<HomeViewModel, HomeState>((ref) => HomeViewModel(ref));
