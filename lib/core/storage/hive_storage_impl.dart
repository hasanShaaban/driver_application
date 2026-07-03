import 'package:hive_flutter/hive_flutter.dart';
import 'app_storage.dart';

class HiveStorageImpl implements AppStorage {
  static const String _boxName = 'app_storage_box';
  Box? _box;

  @override
  Future<void> init() async {
    _box = await Hive.openBox(_boxName);
  }

  @override
  Future<void> write({required String key, required dynamic value}) async {
    await _box?.put(key, value);
  }

  @override
  dynamic read({required String key}) {
    return _box?.get(key);
  }

  @override
  Future<void> delete({required String key}) async {
    await _box?.delete(key);
  }

  @override
  Future<void> clear() async {
    await _box?.clear();
  }
}
