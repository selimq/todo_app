import 'package:get_storage/get_storage.dart';
import '../../base/model/base_model.dart';

abstract class ICacheManager {
  late GetStorage _storage;
  Future<void> addCacheItem<T>(String id, T model);
  Future<void> removeCacheItem<T>(String id);
  T getCacheItem<T extends IBaseModel>(String id, IBaseModel model);
  List<T> getCacheList<T extends IBaseModel>(IBaseModel model);
}
