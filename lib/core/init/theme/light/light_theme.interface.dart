import 'package:flutter/material.dart';
import 'color_scheme_light.dart';
import 'text_theme_light.dart';

import 'padding_insets.dart';

abstract class ILightTheme {
  TextThemeLight? textThemeLight = TextThemeLight.instance;
  ColorSchemeLight? colorSchemeLight = ColorSchemeLight.instance;
  PaddingInsets insets = PaddingInsets();
}
