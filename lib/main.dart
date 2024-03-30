import 'package:demo_movies_app/core/theme/theme.dart';
import 'package:demo_movies_app/core/utils/app_strings.dart';
import 'package:demo_movies_app/data/storage/pref.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/routes/routes.dart';
import 'core/widgets/loading_view.dart';
import 'data/providers/app_system/app_system.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Storage.init();

  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return GestureDetector(
      onTap: () => WidgetsBinding.instance.focusManager.primaryFocus?.unfocus(),
      child: MaterialApp.router(
        title: AppStrings.appTitle,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        theme: AppThemeData.light,
        darkTheme: AppThemeData.dark,
        themeMode: ThemeMode.dark,
        builder: (_, widget) {
          return Stack(
            children: [
              widget ?? _buildNotFoundScreen(context),
              _buildLoadingView(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLoadingView() {
    return Consumer(
      builder: (_, ref, child) {
        final bool isLoading = ref.watch(appSystemProvider.select((state) => state.isLoading));

        if (isLoading) return const LoadingView();
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildNotFoundScreen(BuildContext context) {
    bool isCanPop = context.canPop();

    return Scaffold(
      appBar: isCanPop ? AppBar(leading: const BackButton()) : null,
      body: const Center(child: Text(AppStrings.screenNotFound)),
    );
  }
}
