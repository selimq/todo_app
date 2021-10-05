import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/init/navigation/navigation_route.dart';
import 'package:todo_app/core/init/navigation/navigation_service.dart';
import 'package:todo_app/core/init/notifier/provider_list.dart';
import 'package:todo_app/core/init/notifier/theme_notifier.dart';
import 'package:todo_app/feature/test/view/test_view.dart';
import 'core/constants/app/app_constants.dart';
import 'core/init/language/language_manager.dart';

void main() {
  runApp(MultiProvider(
    providers: [...ApplicationProvider.instance.dependItems],
    child: EasyLocalization(
      child: const App(),
      path: ApplicationConstants.LANG_ASSETS_PATH,
      supportedLocales: LanguageManager.instance.supportedLocales,
      fallbackLocale: LanguageManager.instance.enLocale,
    ),
  ));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<ThemeNotifier>(context, listen: false).currentTheme,
      home: const TestView(),
      navigatorKey: NavigationService.instance.navigatorKey,
      onGenerateRoute: NavigationRoute.instance.generateRoute,
    );
  }
}
