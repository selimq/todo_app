import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'core/constants/app/app_constants.dart';
import 'core/init/cache/cache_manager.dart';
import 'core/init/language/language_manager.dart';
import 'core/init/navigation/navigation_route.dart';
import 'core/init/navigation/navigation_service.dart';
import 'core/init/notifier/provider_list.dart';
import 'core/init/notifier/theme_notifier.dart';
import 'feature/calendar/view/calendar.dart';
import 'feature/calendar/view/notification_service.dart';
import 'feature/test/view/test_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await CacheManager.instance.initStorage();
  await initializeDateFormatting();
  await Firebase.initializeApp();
  await NotificationService().init();

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
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeNotifier>(context, listen: false).currentTheme,
      home: const TestView(),
      navigatorKey: NavigationService.instance.navigatorKey,
      onGenerateRoute: NavigationRoute.instance.generateRoute,
    );
  }
}
