import 'dart:convert';

import 'package:qt_giphy_test_preet/Constants/ConstantString.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/LoginModel.dart';

class SharedPreferenceHelper {
  // Private constructor
  SharedPreferenceHelper._privateConstructor();

  // The single instance
  static final SharedPreferenceHelper _instance =
      SharedPreferenceHelper._privateConstructor();

  // Getter to access the single instance
  static SharedPreferenceHelper get instance => _instance;

  // SharedPreferences instance
  SharedPreferences? _preferences;

  // Initialize SharedPreferences
  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Set a string value
  Future<bool> setString(String key, String value) async {
    return _preferences!.setString(key, value);
  }

  // Get a string value
  String? getString(String key) {
    return _preferences!.getString(key);
  }

  // Set an integer value
  Future<bool> setInt(String key, int value) async {
    return _preferences!.setInt(key, value);
  }

  // Get an integer value
  int? getInt(String key) {
    return _preferences!.getInt(key);
  }

  // Set a boolean value
  Future<bool> setBool(String key, bool value) async {
    return _preferences!.setBool(key, value);
  }

  // Get a boolean value
  bool? getBool(String key) {
    return _preferences!.getBool(key);
  }

  // Remove a key
  Future<bool> remove(String key) async {
    return _preferences!.remove(key);
  }

  // Clear all preferences
  Future<bool> clear() async {
    return _preferences!.clear();
  }


  Future<LoginModel?> getLoginModel() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    var result = pref.getString(ConstantString.USER_LOGIN);

    print("jkgjjhgkjhjhk00");
    print(result);

    if (result == null) {
      return null;
    } else {
      return LoginModel.fromJson(jsonDecode(result));
    }
  }
}
