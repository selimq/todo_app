import 'package:dio/dio.dart';
import '../../base/model/base_model.dart';
import '../../constants/enums/http_request_enum.dart';

abstract class ICoreDio {
  Future<R?> myFetch<R, T extends IBaseModel>(String path,
      {required HttpTypes type,
      required T parseModel,
      data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      ProgressCallback? onReceiveProgress});
}
