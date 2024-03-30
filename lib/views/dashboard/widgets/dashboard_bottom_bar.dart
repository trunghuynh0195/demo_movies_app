import 'package:demo_movies_app/core/theme/app_colors.dart';
import 'package:demo_movies_app/views/dashboard/view_model/dashboard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DashboardBottomBar extends ConsumerWidget {
  const DashboardBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var dashboardVM = ref.read(dashboardViewModel.notifier);

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.lightDarkBackgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: Row(
        children: [
          _buildButton(
            onPressed: () => dashboardVM.jumpToPage(0),
            icon: Icons.home,
          ),
          const SizedBox(width: 10),
          _buildButton(
            onPressed: () {},
            icon: Icons.spoke_rounded,
          ),
          const SizedBox(width: 10),
          _buildButton(
            onPressed: () => dashboardVM.jumpToPage(2),
            icon: Icons.favorite_outline_outlined,
          ),
          const SizedBox(width: 10),
          _buildButton(
            onPressed: () {},
            icon: Icons.person,
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    void Function()? onPressed,
    required IconData icon,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(icon),
        ),
      ),
    );
  }
}
