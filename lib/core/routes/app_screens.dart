enum AppScreens {
  splash,
  dashboard,
}

extension AppScreenExtension on AppScreens {
  String get getName {
    switch (this) {
      case AppScreens.splash:
        return 'splash';
      case AppScreens.dashboard:
        return 'dashboard';
      default:
        return 'Unknown';
    }
  }

  String get path => '/$name';
}
