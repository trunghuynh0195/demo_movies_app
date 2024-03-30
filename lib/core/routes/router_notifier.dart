import 'package:demo_movies_app/core/routes/app_screens.dart';
import 'package:demo_movies_app/views/dashboard/dashboard_screen.dart';
import 'package:demo_movies_app/views/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

/// This notifier exposes nothing (void) but implements [Listenable].
/// This notifier is meant to just access its internal [Notifier].
///
/// This notifier triggers our router's listener everytime is needed.
/// In this simple case, we do so when `auth` changes.
///
/// SIDE NOTE.
/// This might look overcomplicated at a first glance;
/// Instead, this method aims to follow some good some good practices:
///   1. It doesn't require us to pipe down any `ref` parameter
///   2. Since it's not meant to be _watched_, it uselessly rebuild a [GoRouter]
///      every time something changes
///   3. It works as a complete replacement for [ChangeNotifier] (it's a [Listenable] implementation)
///   4. It allows for listening to multiple providers if needed
class RouterNotifier extends AutoDisposeNotifier<bool> implements Listenable {
  VoidCallback? routerListener;

  /// Our application routes. Obtained through code generation
  List<GoRoute> get routes => [
        _splashRouter,
        _mainRouter,
      ];

  final _splashRouter = GoRoute(
    path: AppScreens.splash.path,
    name: AppScreens.splash.getName,
    builder: (context, GoRouterState state) => const SplashScreen(),
  );

  final _mainRouter = GoRoute(
    path: AppScreens.dashboard.path,
    name: AppScreens.dashboard.getName,
    builder: (context, GoRouterState state) => const DashboardScreen(),
  );

  /// Adds [GoRouter]'s listener as specified by its [Listenable].
  /// [GoRouteInformationProvider] uses this method on creation to handle its
  /// internal [ChangeNotifier].
  /// Check out the internal implementation of [GoRouter] and
  /// [GoRouteInformationProvider] to see this in action.
  @override
  void addListener(VoidCallback listener) {
    routerListener = listener;
  }

  /// Removes [GoRouter]'s listener as specified by its [Listenable].
  /// [GoRouteInformationProvider] uses this method when disposing,
  /// so that it removes its callback when destroyed.
  /// Check out the internal implementation of [GoRouter] and
  /// [GoRouteInformationProvider] to see this in action.
  @override
  void removeListener(VoidCallback listener) {
    routerListener = null;
  }

  @override
  bool build() => true;
}

final routerNotifierProvider = AutoDisposeNotifierProvider<RouterNotifier, bool>(() => RouterNotifier());
