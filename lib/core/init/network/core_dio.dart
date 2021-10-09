import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import '../../base/model/base_model.dart';
import '../../constants/enums/http_request_enum.dart';
import '../../extension/network_extension.dart';
import 'icore_dio.dart';
part './network_core/network_operations.dart';

class CoreDio with DioMixin implements Dio, ICoreDio {
  final BaseOptions _options;
  CoreDio(this._options) {
    options = _options;
    interceptors.add(InterceptorsWrapper());
    httpClientAdapter = DefaultHttpClientAdapter();
  }
  @override
  Future<R?> myFetch<R, T extends IBaseModel>(String path,
      {required HttpTypes type,
      required T parseModel,
      data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      ProgressCallback? onReceiveProgress}) async {
    final response = await request(path,
        data: data, options: Options(method: type.rawValue));
    switch (response.statusCode) {
      case HttpStatus.ok:
        return _responseParser<R>(parseModel, response.data);
      default:
        return null;
    }
  }

//!

/* BaseError(message: response.statusMessage ?? "Message"9) */

}
