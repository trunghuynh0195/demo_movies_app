import 'package:hooks_riverpod/hooks_riverpod.dart';

import './app_system_state.dart';

class AppSystemStateNotifier extends StateNotifier<AppSystemState> {
  AppSystemStateNotifier() : super(const AppSystemState());

  void setLoading(bool value) {
    if (!mounted) return;
    state = state.copyWith(isLoading: value);
  }
}

final appSystemProvider = StateNotifierProvider<AppSystemStateNotifier, AppSystemState>(
  (ref) => AppSystemStateNotifier(),
);
