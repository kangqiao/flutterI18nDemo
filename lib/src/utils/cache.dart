import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef ModelMapper<T> = T Function(Map<String, dynamic>);

class CacheManager {
  CacheManager._internal();
  factory CacheManager() => _instance;
  static final CacheManager _instance = CacheManager._internal();
  static CacheManager get instance => _instance;

  late SharedPreferences? prefs;

  Future<SharedPreferences> init() async {
    prefs = await SharedPreferences.getInstance();
    return prefs!;
  }

  Future<String?> read({required String key}) async {
    prefs = prefs ?? await init();
    return prefs?.getString(key);
  }

  Future<void> write({required String key, String? value}) async {
    prefs = prefs ?? await init();
    await prefs?.setString(key, value ?? '');
  }

  Future<void> delete({required String key}) async {
    prefs = prefs ?? await init();
    await prefs?.remove(key);
  }

  void deleteAll() async {
    prefs = prefs ?? await init();
    prefs?.clear();
  }

  void setString(String key, String value) {
    prefs?.setString(key, value);
  }

  String? getString(String key, {String? def}) {
    return prefs?.getString(key) ?? def;
  }

  void setDouble(String key, double value) {
    prefs?.setDouble(key, value);
  }

  double? getDouble(String key, {double? def}) {
    return prefs?.getDouble(key) ?? def;
  }

  void setInt(String key, int value) {
    prefs?.setInt(key, value);
  }

  int? getInt(String key, {int? def}) {
    return prefs?.getInt(key) ?? def;
  }

  void setBool(String key, bool value) {
    prefs?.setBool(key, value);
  }

  bool? getBool(String key, {bool? def}) {
    return prefs?.getBool(key) ?? def;
  }

  void setStringList(String key, List<String> value) {
    prefs?.setStringList(key, value);
  }

  List<String> getStringList(
    String key, {
    List<String> def = const [],
  }) {
    return prefs?.getStringList(key) ?? def;
  }

  T? get<T>(String key, ModelMapper<T> modelMapper) {
    try {
      final jsonSrc = CacheManager().getString(key);
      if (jsonSrc != null && jsonSrc.isNotEmpty) {
        final json = jsonDecode(jsonSrc);
        return (json is Map<String, dynamic>) ? modelMapper(json) : null;
      }
    } catch (e, stack) {
      loge(
        'get($key) catch an exception',
        error: e,
        stackTrace: stack,
      );
    }
    return null;
  }

  void put<T>(String key, T data) {
    final jsonSrc = jsonEncode(data);
    setString(key, jsonSrc);
  }

  List<T>? getList<T>(String key, ModelMapper<T> modelMapper) {
    try {
      final jsonSrc = CacheManager().getString(key);
      if (jsonSrc != null && jsonSrc.isNotEmpty) {
        final json = jsonDecode(jsonSrc);
        return (json as List<dynamic>?)
                ?.map((e) => modelMapper(e as Map<String, dynamic>))
                .toList() ??
            const [];
      }
    } catch (err, stack) {
      loge(
        'getList($key) catch an exception',
        error: err,
        stackTrace: stack,
      );
    }
    return null;
  }

  void putList<T>(String key, List<T> list) {
    final jsonSrc = jsonEncode(list);
    setString(key, jsonSrc);
  }

  void loge(
    String msg, {
    required Object error,
    required StackTrace stackTrace,
  }) {
    debugPrint(msg);
  }
}
