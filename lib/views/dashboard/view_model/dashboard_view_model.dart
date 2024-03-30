import 'package:demo_movies_app/views/dashboard/view_model/dashboard_state.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DashboardViewModel extends StateNotifier<DashboardState> {
  DashboardViewModel() : super(const DashboardState());

  // raw data
  final PageController dashboardPageController = PageController();

  // set function

  void setTabIndex(int value) {
    if (!mounted) return;
    state = state.copyWith(tabIndex: value);
  }

  void jumpToPage(int page) {
    dashboardPageController.jumpToPage(page);
  }
}

final dashboardViewModel = StateNotifierProvider.autoDispose<DashboardViewModel, DashboardState>((ref) => DashboardViewModel());
