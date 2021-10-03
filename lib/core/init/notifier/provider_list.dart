import 'package:provider/single_child_widget.dart';

class ApplicationProvider {
  static ApplicationProvider? _instace;
  static ApplicationProvider get instance {
    _instace ??= ApplicationProvider._init();
    return _instace!;
  }

  ApplicationProvider._init();
  List<SingleChildWidget> singleItems = [];
  List<SingleChildWidget> dependItems = [];
  List<SingleChildWidget> uiChangesItems = [];
}
