import 'dart:convert';

import 'package:charge_station_finder/infrastructure/core/constants.dart';
import 'package:charge_station_finder/infrastructure/dto/userAuthCredential.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShardPrefHelper {
  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  static Future<bool> setString(String key, String value) async {
    final SharedPreferences prefs = await _instance;
    return prefs.setString(key, value);
  }

  static Future<bool> setUser(UserData user) async {
    final SharedPreferences prefs = await _instance;
    return prefs.setString(Constants.User_Key, jsonEncode(user.toJson()));
  }

  static Future<UserData> getUser() async {
    final SharedPreferences prefs = await _instance;
    var user = prefs.getString(Constants.User_Key);
    return UserData.fromJson(jsonDecode(user!));
  } 

  static Future<bool> clear() async {
    final SharedPreferences prefs = await _instance;
    return prefs.clear();
  }
  // has opened before
  static Future<bool> hasOpend() async { 
    final SharedPreferences prefs = await _instance;
    return prefs.getBool(Constants.HasOpened) ?? false;
  }

  // set has opened before
  static Future<bool> setHasOpend() async {
    final SharedPreferences prefs = await _instance;
    return prefs.setBool(Constants.HasOpened, true);
  }
  
}
