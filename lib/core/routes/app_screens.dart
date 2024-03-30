enum AppScreens {
  splash,
  dashboard,
  home,
  movieDetail,
}

extension AppScreenExtension on AppScreens {
  String get getName {
    switch (this) {
      case AppScreens.splash:
        return 'splash';
      case AppScreens.dashboard:
        return 'dashboard';
      case AppScreens.home:
        return 'home';
      case AppScreens.movieDetail:
        return 'movie-detail';
      default:
        return 'Unknown';
    }
  }

  String get path => '/$name';
}
