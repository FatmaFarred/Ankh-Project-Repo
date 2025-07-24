import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsManager {
  static Future<bool> saveData(
      {required String key, required dynamic value}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value is int) {
      return await prefs.setInt(key, value);
    } else if (value is String) {
      return await prefs.setString(key, value);
    } else if (value is double) {
      return await prefs.setDouble(key, value);
    } else if (value is bool) {
      return prefs.setBool(key, value);
    } else {
      return prefs.setString(key, value.toString());
    }
  }

  static Future<dynamic> getData({required String key}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  static Future<void> removeData({required String key}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}