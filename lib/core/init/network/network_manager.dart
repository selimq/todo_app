import 'package:dio/dio.dart';

import 'core_dio.dart';
import 'icore_dio.dart';

class NetworkManager {
  static NetworkManager? _instace;
  static NetworkManager get instance {
    _instace ??= NetworkManager._init();
    return _instace!;
  }

  late ICoreDio coreDio;

  NetworkManager._init() {
    final baseOptions = BaseOptions(baseUrl: "https://apiurel", headers: {});
    coreDio = CoreDio(baseOptions);
  }
}
