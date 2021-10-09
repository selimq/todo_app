import 'dart:convert';

import 'package:get_storage/get_storage.dart';

import '../../base/model/base_model.dart';
import 'icache_manager.dart';

class CacheManager implements ICacheManager {
  static CacheManager? _instance;
  static CacheManager get instance {
    if (_instance != null) return _instance!;
    _instance = CacheManager._init();
    return _instance!;
  }

  @override
  late GetStorage _storage;

  CacheManager._init() {
    initStorage();
  }
  Future<void> initStorage() async {
    await GetStorage.init();
    _storage = GetStorage();
  }

  String _key<T>(String id) {
    return '${T.toString()}-$id';
  }

  @override
  Future<void> addCacheItem<T>(String id, T model) async {
    final _stringModel = jsonEncode(model);
    await _storage.write(_key<T>(id), _stringModel);
  }

  @override
  T getCacheItem<T extends IBaseModel>(String id, IBaseModel model) {
    final cachedData = _storage.read(_key<T>(id));
    final normalModelJson = jsonDecode(cachedData);
    return model.fromJson(normalModelJson);
  }

  @override
  Future<bool> removeCacheItem<T>(String id) {
    // TODO: implement removeCacheItem
    throw UnimplementedError();
  }

  @override
  List<T> getCacheList<T extends IBaseModel>(IBaseModel model) {
    Iterable<String> cachedDataList = _storage.getKeys();
    cachedDataList = cachedDataList.where((element) => element.contains('$T-'));
    if (cachedDataList.isNotEmpty) {
      return cachedDataList
          .map((e) => model.fromJson(jsonDecode(_storage.read(e) ?? '')) as T)
          .toList();
    }
    return [];
  }
}
