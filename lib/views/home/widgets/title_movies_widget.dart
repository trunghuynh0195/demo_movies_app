import 'package:demo_movies_app/core/extensions/extensions.dart';
import 'package:demo_movies_app/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

class TitleMoviesWidget extends StatelessWidget {
  final String title;
  const TitleMoviesWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.labelLarge?.copyWith(
                fontSize: 18,
              ),
            ),
          ),
          Text(
            AppStrings.seeAll,
            style: context.textTheme.bodySmall?.copyWith(
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}
