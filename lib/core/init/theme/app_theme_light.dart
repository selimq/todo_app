import 'package:flutter/material.dart';
import '../../constants/app/app_constants.dart';
import 'light/light_theme.interface.dart';
import 'app_theme.dart';

class AppThemeLight extends AppTheme with ILightTheme {
  static AppThemeLight? _instace;
  static AppThemeLight get instance {
    _instace ??= AppThemeLight._init();
    return _instace!;
  }

  AppThemeLight._init();
  ThemeData get theme => ThemeData(
        textTheme: _textTheme,
        colorScheme: _appColorScheme,
        fontFamily: ApplicationConstants.FONT_FAMILY,
      );
  TextTheme get _textTheme =>
      const TextTheme().apply(fontFamily: ApplicationConstants.FONT_FAMILY);

  ColorScheme get _appColorScheme {
    return ColorScheme(
        primary: colorSchemeLight!.azure,
        primaryVariant: colorSchemeLight!.white, //xx
        secondary: colorSchemeLight!.azure,
        secondaryVariant: colorSchemeLight!.lightGray,
        surface: Colors.blue, //xx
        background: const Color(0xfff6f9fc), //xx
        error: Colors.red[900]!,
        onPrimary: Colors.white,
        onSecondary: Colors.black, //x
        onSurface: Colors.purple.shade300,
        onBackground: Colors.black12,
        onError: const Color(0xFFF9B916), //xx
        brightness: Brightness.light);
  }
}
