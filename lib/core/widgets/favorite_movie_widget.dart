import 'package:demo_movies_app/data/storage/pref.dart';
import 'package:flutter/material.dart';

class FavoriteMovieWidget extends StatefulWidget {
  final String movieId;
  final double? size;
  final Color? color;
  final void Function(bool)? onChanged;

  const FavoriteMovieWidget({
    Key? key,
    required this.movieId,
    this.size,
    this.color,
    this.onChanged,
  }) : super(key: key);

  @override
  State<FavoriteMovieWidget> createState() => _FavoriteMovieWidgetState();
}

class _FavoriteMovieWidgetState extends State<FavoriteMovieWidget> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    isFavorite = Storage.favoriteMovies.any((item) => item == widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _favoriteMovie,
      child: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_outline_outlined,
        color: widget.color ?? Colors.white,
        size: widget.size,
      ),
    );
  }

  void _favoriteMovie() {
    List<String> movies = Storage.favoriteMovies;

    isFavorite = !isFavorite;

    if (isFavorite) {
      movies.add(widget.movieId);
    } else {
      movies.remove(widget.movieId);
    }

    Storage.favoriteMovies = movies.toSet().toList();
    widget.onChanged?.call(isFavorite);
    setState(() {});
  }
}
