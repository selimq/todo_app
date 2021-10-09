import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../navigation/navigation_service.dart';
import 'theme_notifier.dart';

class ApplicationProvider {
  static ApplicationProvider? _instace;
  static ApplicationProvider get instance {
    _instace ??= ApplicationProvider._init();
    return _instace!;
  }

  ApplicationProvider._init();
  List<SingleChildWidget> singleItems = [];
  List<SingleChildWidget> dependItems = [
    ChangeNotifierProvider(create: (context) => ThemeNotifier()),
    Provider.value(value: NavigationService.instance)
  ];
  List<SingleChildWidget> uiChangesItems = [];
}
