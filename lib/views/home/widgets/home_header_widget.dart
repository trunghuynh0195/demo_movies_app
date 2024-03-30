import 'package:demo_movies_app/core/extensions/extensions.dart';
import 'package:demo_movies_app/core/routes/routes.dart';
import 'package:demo_movies_app/core/utils/app_strings.dart';
import 'package:demo_movies_app/core/utils/base_circle_avatar.dart';
import 'package:demo_movies_app/data/storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello ${Storage.user?.name ?? ''}',
                  style: context.textTheme.titleLarge,
                ),
                Text(
                  AppStrings.whatToWatch,
                  style: context.textTheme.bodySmall?.copyWith(fontSize: 10),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () => context.pushNamed(AppScreens.profile.getName),
            child: BaseCircleAvatar(
              imageUrl: Storage.user?.avatar ?? '',
              name: Storage.user?.name ?? '',
              height: 50,
              width: 50,
            ),
          ),
        ],
      ),
    );
  }
}
