import 'package:flutter/material.dart';
import 'package:todo_app/core/init/theme/app_theme.dart';

class AppThemeLight extends AppTheme {
  static AppThemeLight? _instace;
  static AppThemeLight get instance {
    _instace ??= AppThemeLight._init();
    return _instace!;
  }

  AppThemeLight._init();
  ThemeData get theme => ThemeData.light();
}
