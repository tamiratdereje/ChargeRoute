// shared preference helper

import 'package:shared_preferences/shared_preferences.dart';

class ShardPrefHelper{
  static Future<SharedPreferences> get _instance async => _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  static Future<bool> setString(String key, String value) async {
    final SharedPreferences prefs = await _instance;
    return prefs.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    final SharedPreferences prefs = await _instance;
    return prefs.getString(key);
  }

  static Future<bool> setBool(String key, bool value) async {
    final SharedPreferences prefs = await _instance;
    return prefs.setBool(key, value);
  }

  static Future<bool?> getBool(String key) async {
    final SharedPreferences prefs = await _instance;
    return prefs.getBool(key);
  }

  static Future<bool> setInt(String key, int value) async {
    final SharedPreferences prefs = await _instance;
    return prefs.setInt(key, value);
  }

  static Future<int?> getInt(String key) async {
    final SharedPreferences prefs = await _instance;
    return prefs.getInt(key);
  }

  static Future<bool> setDouble(String key, double value) async {
    final SharedPreferences prefs = await _instance;
    return prefs.setDouble(key, value);
  }

  static Future<double?> getDouble(String key) async {
    final SharedPreferences prefs = await _instance;
    return prefs.getDouble(key);
  }

  static Future<bool> setStringList(String key, List<String> value) async {
    final SharedPreferences prefs = await _instance;
    return prefs.setStringList(key, value);
  }

  static Future<List<String>?> getStringList(String key) async {
    final SharedPreferences prefs = await _instance;
    return prefs.getStringList(key);
  }

  static Future<bool> remove(String key) async {
    final SharedPreferences prefs = await _instance;
    return prefs.remove(key);
  }

  static Future<bool> clear() async {
    final SharedPreferences prefs = await _instance;
    return prefs.clear();
  }
}