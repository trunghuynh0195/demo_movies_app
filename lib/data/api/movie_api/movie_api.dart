import 'package:demo_movies_app/core/utils/app_api_url.dart';
import 'package:demo_movies_app/data/api/app_dio.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'movie_api.g.dart';

final movieApiProvider = Provider((ref) => MovieApi(ref));

@RestApi()
abstract class MovieApi {
  factory MovieApi(Ref ref) => _MovieApi(ref.read(dioProvider));

  @GET(AppApiUrl.moviesComingSoon)
  Future<String> moviesComingSoon();
}
