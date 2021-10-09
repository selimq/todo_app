import 'package:flutter/material.dart';
import '../text/locale_text.dart';
import '../../../generated/locale_keys.g.dart';

class NotFoundNavigationWidget extends StatelessWidget {
  const NotFoundNavigationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(child: LocaleText(value: LocaleKeys.not_found)));
  }
}
