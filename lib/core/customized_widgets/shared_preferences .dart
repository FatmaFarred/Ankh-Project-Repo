import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsManager {
  static const String userTokenKey = 'user_token';
  static const String userIdKey = 'user_id';
  
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
  
  // User token methods
  static Future<String?> getUserToken() async {
    return await getData(key: userTokenKey) as String?;
  }
  
  static Future<bool> saveUserToken(String token) async {
    return await saveData(key: userTokenKey, value: token);
  }
  
  // User ID methods
  static Future<String?> getUserId() async {
    return await getData(key: userIdKey) as String?;
  }
  
  static Future<bool> saveUserId(String userId) async {
    return await saveData(key: userIdKey, value: userId);
  }
}