import 'package:flutter/material.dart';
import 'package:todo_app/core/constants/app/app_constants.dart';
import 'package:todo_app/core/constants/navigation/navigation_constants.dart';
import 'package:todo_app/core/init/navigation/navigation_route.dart';
import 'package:todo_app/core/init/navigation/navigation_service.dart';
import '../../../core/components/text/locale_text.dart';
import '../../../core/base/state/base_state.dart';
import '../../../generated/locale_keys.g.dart';

class TestView extends StatefulWidget {
  const TestView({Key? key}) : super(key: key);

  @override
  _TestViewState createState() => _TestViewState();
}

class _TestViewState extends BaseState<TestView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LocaleText(value: LocaleKeys.welcome),
        leading: IconButton(
          icon: const Icon(Icons.read_more),
          onPressed: () {},
        ),
      ),
      body: ElevatedButton(
        child: const Text("test"),
        onPressed: () async {
          NavigationService.instance.navigateToPageClear("sds");
        },
      ),
    );
  }
}
