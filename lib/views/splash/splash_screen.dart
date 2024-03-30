import 'package:demo_movies_app/core/extensions/extensions.dart';
import 'package:demo_movies_app/core/routes/app_screens.dart';
import 'package:demo_movies_app/core/utils/app_image_paths.dart';
import 'package:demo_movies_app/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _init());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: Image.asset(AppImagePaths.appIcon, height: 60),
              ),
              const SizedBox(width: 12),
              Text(
                AppStrings.movies,
                style: context.textTheme.headlineLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _init() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) context.goNamed(AppScreens.dashboard.getName);
  }
}
