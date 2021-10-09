part of '../core_dio.dart';

extension CoreDioOperations on CoreDio {
  R? _responseParser<R>(IBaseModel model, dynamic data) {
    if (data is List<Map<String, dynamic>>) {
      return data.map((e) => model.fromJson(e)).toList() as R;
    } else if (data is Map<String, dynamic>) {
//!
      return model.fromJson(Map<String, dynamic>.from(data['data'])) as R;
    }
    return data as R;
  }
}
