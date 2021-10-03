import 'package:flutter/material.dart';

class LanguageManager {
  static LanguageManager? _instance;
  static LanguageManager get instance {
    _instance ??= LanguageManager._init();
    return _instance!;
  }

  LanguageManager._init();
  final enLocale = const Locale("en");
  final trLocale = const Locale("tr");
  List<Locale> get supportedLocales => [enLocale, trLocale];
}
