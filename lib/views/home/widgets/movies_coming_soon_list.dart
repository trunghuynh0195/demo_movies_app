import 'package:carousel_slider/carousel_slider.dart';
import 'package:demo_movies_app/core/utils/base_cached_network_image.dart';
import 'package:demo_movies_app/views/home/view_model/home_view_model.dart';
import 'package:demo_movies_app/views/home/widgets/skelton_movie_item.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MoviesComingSoonList extends ConsumerWidget {
  const MoviesComingSoonList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var movies = ref.watch(homeViewModel.select((state) => state.moviesComingSoon));
    if (movies == null) return _placeholderList(context);

    var moviesReversed = movies.reversed.toList();
    return SizedBox(
      height: 160,
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: moviesReversed.length,
        itemBuilder: (_, index, realIndex) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * (4 / 5),
              child: BaseCachedNetworkImage(
                borderRadius: 12,
                imageUrl: moviesReversed[index].posterurl ?? '',
              ),
            ),
          );
        },
        options: CarouselOptions(
          enlargeCenterPage: true,
          enableInfiniteScroll: false,
          enlargeFactor: 0.24,
          autoPlay: true,
        ),
      ),
    );
  }

  Widget _placeholderList(BuildContext context) {
    return SizedBox(
      height: 160,
      width: double.infinity,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: 20,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, index) {
          return SkeltonMovieItem(
            key: Key(DateTime.now().microsecondsSinceEpoch.toString()),
            borderRadius: 12,
            width: 260,
          );
        },
      ),
    );
  }
}
