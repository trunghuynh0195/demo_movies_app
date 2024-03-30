import 'package:demo_movies_app/core/extensions/extensions.dart';
import 'package:demo_movies_app/core/utils/app_strings.dart';
import 'package:demo_movies_app/core/utils/helpers/popups_helper.dart';
import 'package:demo_movies_app/views/home/view_model/home_view_model.dart';
import 'package:demo_movies_app/views/home/widgets/home_header_widget.dart';
import 'package:demo_movies_app/views/home/widgets/movies_coming_soon_list.dart';
import 'package:demo_movies_app/views/home/widgets/new_movies_list.dart';
import 'package:demo_movies_app/views/home/widgets/search_movies_widget.dart';
import 'package:demo_movies_app/views/home/widgets/title_movies_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with AutomaticKeepAliveClientMixin {
  late final HomeViewModel _homeVM;

  @override
  void initState() {
    super.initState();
    _homeVM = ref.read(homeViewModel.notifier);
    WidgetsBinding.instance.addPostFrameCallback((_) => _initData());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 16),
              HomeHeaderWidget(),
              SizedBox(height: 16),
              SearchMoviesWidget(),
              SizedBox(height: 24),
              TitleMoviesWidget(
                title: AppStrings.upcomingMovies,
              ),
              SizedBox(height: 10),
              MoviesComingSoonList(),
              SizedBox(height: 24),
              TitleMoviesWidget(
                title: AppStrings.newMovies,
              ),
              SizedBox(height: 10),
              NewMoviesList(),
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _initData() async {
    try {
      await _homeVM.getMoviesComingSoon();
    } on Exception catch (error) {
      if (mounted) PopupsHelper.showSnackBar(context, error.message);
    }
  }

  @override
  bool get wantKeepAlive => true;
}
