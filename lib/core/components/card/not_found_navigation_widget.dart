import 'package:flutter/material.dart';
import 'package:todo_app/core/components/text/locale_text.dart';
import '../../../generated/locale_keys.g.dart';

class NotFoundNavigationWidget extends StatelessWidget {
  const NotFoundNavigationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(child: LocaleText(value: LocaleKeys.not_found)));
  }
}
