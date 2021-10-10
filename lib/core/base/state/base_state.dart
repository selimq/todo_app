import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  ThemeData get themeData => Theme.of(context);
  double dynamicHeight(value) => MediaQuery.of(context).size.height * value;
  double dynamicWidth(value) => MediaQuery.of(context).size.width * value;
}
