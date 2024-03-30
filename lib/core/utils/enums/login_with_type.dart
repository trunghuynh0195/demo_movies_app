import 'package:demo_movies_app/core/utils/app_image_paths.dart';
import 'package:demo_movies_app/core/utils/app_strings.dart';

enum LoginWithType {
  google,
  apple,
  facebook,
}

extension LoginWithTypeEX on LoginWithType {
  String get getName {
    switch (this) {
      case LoginWithType.google:
        return AppStrings.google;
      case LoginWithType.apple:
        return AppStrings.apple;
      case LoginWithType.facebook:
        return AppStrings.facebook;
      default:
        return name;
    }
  }

  String get icon {
    switch (this) {
      case LoginWithType.google:
        return AppImagePaths.googleIcon;
      case LoginWithType.apple:
        return AppImagePaths.appleIcon;
      case LoginWithType.facebook:
        return AppImagePaths.facebookIcon;
      default:
        return '';
    }
  }
}
