import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared_preferences.dart';

part 'local_storage_provider.g.dart';

typedef Json = Map<String, dynamic>;

@Riverpod(keepAlive: true)
LocalStorage localStorage(LocalStorageRef ref) {
  final preferences = ref.read(sharedPreferencesProvider).requireValue;
  return LocalStorage(preferences);
}

class LocalStorage implements _LocalStorage {
  final SharedPreferences _preferences;

  const LocalStorage(this._preferences);

  @override
  Future<void> save<T>(String key, T value) async {
    if (value is int) {
      await _preferences.setInt(key, value);
    } else if (value is double) {
      await _preferences.setDouble(key, value);
    } else if (value is bool) {
      await _preferences.setBool(key, value);
    } else if (value is String) {
      await _preferences.setString(key, value);
    } else if (value is List<String>) {
      await _preferences.setStringList(key, value);
    } else if (value is Json) {
      final jsonString = jsonEncode(value);
      await _preferences.setString(key, jsonString);
    } else {
      throw Exception('Type ${value.runtimeType.toString()} not supported');
    }
  }

  @override
  Future<T?> read<T>(String key) async {
    if (T == int) {
      return _preferences.getInt(key) as T?;
    } else if (T == double) {
      return _preferences.getDouble(key) as T?;
    } else if (T == bool) {
      return _preferences.getBool(key) as T?;
    } else if (T == String) {
      return _preferences.getString(key) as T?;
    } else if (T == List<String>) {
      return _preferences.getStringList(key) as T?;
    } else if (T == Json) {
      final jsonString = _preferences.getString(key);

      if (jsonString != null) {
        final Map<String, dynamic> json = jsonDecode(jsonString);
        return json as T;
      }

      return null;
    } else {
      throw Exception('Type ${T.toString()} not supported');
    }
  }

  @override
  Future<void> delete(String key) async {
    await _preferences.remove(key);
  }
}

abstract class _LocalStorage {
  Future<void> save<T>(String key, T value);
  Future<T?> read<T>(String key);
  Future<void> delete(String key);
}
