import 'package:flutter/material.dart';
import 'package:todo_app/feature/test/view/abc_view.dart';
import '../../components/card/not_found_navigation_widget.dart';
import '../../constants/navigation/navigation_constants.dart';
import '../../../feature/test/view/test_view.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();
  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.TEST_VIEW:
        return normalNavigate(const TestView());
      case NavigationConstants.ABC_VIEW:
        return normalNavigate(const ABC());
      default:
        return MaterialPageRoute(
          builder: (context) => const NotFoundNavigationWidget(),
        );
    }
  }

  MaterialPageRoute normalNavigate(Widget widget) => MaterialPageRoute(
        builder: (context) => widget,
      );
}
