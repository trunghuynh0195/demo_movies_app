import 'package:demo_movies_app/core/theme/app_colors.dart';
import 'package:demo_movies_app/core/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class SearchMoviesWidget extends StatelessWidget {
  const SearchMoviesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: AppTextField(
        borderRadius: 8,
        prefixIcon: Icon(Icons.search),
        hintText: 'Search',
        backgroundColor: AppColors.lightDarkBackgroundColor,
        borderSideColor: AppColors.lightDarkBackgroundColor,
      ),
    );
  }
}
