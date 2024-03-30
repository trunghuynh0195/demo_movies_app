import 'dart:convert';

import 'package:demo_movies_app/data/api/movie_api/movie_api.dart';
import 'package:demo_movies_app/data/models/movie_models/movie_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final movieRepositoryProvider = Provider((ref) => MovieRepository(ref));

class MovieRepository {
  MovieRepository(this._ref);

  final Ref _ref;
  late final _movieApi = _ref.read(movieApiProvider);

  /// get movie coming soon list
  Future<List<MovieModel>?> getMoviesComingSoon() async {
    try {
      var response = await _movieApi.moviesComingSoon();
      final List<dynamic>? decodedData = json.decode(response) as List<dynamic>?;
      return decodedData?.map((item) => MovieModel.fromJson(item as Map<String, dynamic>)).toList();
    } catch (_) {
      rethrow;
    }
  }
}
