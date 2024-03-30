import 'package:demo_movies_app/views/dashboard/view_model/dashboard_view_model.dart';
import 'package:demo_movies_app/views/dashboard/widgets/dashboard_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    var dashboardVM = ref.read(dashboardViewModel.notifier);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: PageView(
                controller: dashboardVM.dashboardPageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Container(),
                  Container(),
                  Container(),
                  Container(),
                ],
              ),
            ),
            const Positioned(
              left: 0,
              right: 0,
              bottom: 10,
              child: DashboardBottomBar(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
