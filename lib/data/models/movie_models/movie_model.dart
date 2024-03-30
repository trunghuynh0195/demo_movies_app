import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_model.freezed.dart';
part 'movie_model.g.dart';

@freezed
class MovieModel with _$MovieModel {
  const MovieModel._();
  const factory MovieModel({
    String? id,
    String? title,
    String? year,
    List<String>? genres,
    List<int>? ratings,
    String? poster,
    String? contentRating,
    String? duration,
    dynamic releaseDate,
    int? averageRating,
    String? originalTitle,
    String? storyline,
    List<String>? actors,
    dynamic imdbRating,
    String? posterurl,
  }) = _MovieModel;

  factory MovieModel.fromJson(Map<String, dynamic> json) => _$MovieModelFromJson(json);

  double get totalAverageRating {
    List<int> ratingList = ratings ?? [];
    if (ratingList.isEmpty) {
      return 0;
    }
    double sum = ratingList.reduce((a, b) => a + b).toDouble();
    return sum / ratingList.length;
  }
}
