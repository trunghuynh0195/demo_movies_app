import 'package:demo_movies_app/core/theme/palette.dart';
import 'package:demo_movies_app/core/utils/size_config.dart';
import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);

  Brightness get brightness => theme.brightness;

  ColorScheme get colors => theme.colorScheme;

  TextTheme get textTheme => theme.textTheme;

  TextTheme get primaryTextTheme => theme.primaryTextTheme;

  Palette get palette => brightness == Brightness.dark ? Palette.dark : Palette.light;

  /// size config
  SizeConfig get s => SizeConfig.of(this);
}
