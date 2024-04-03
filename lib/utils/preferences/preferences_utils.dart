import 'package:shared_preferences/shared_preferences.dart';

class PreferencesUtils {
  static late SharedPreferences prefs;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> savePreferencesString(String key, String value) async {
    prefs.setString(key, value);
  }

  String? getPreferencesString(String key) {
    return prefs.getString(key);
  }

  Future<void> savePreferencesBool(String key, bool value) async {
    prefs.setBool(key, value);
  }

  bool? getPreferencesBool(String key) {
    return prefs.getBool(key);
  }

  Future<void> savePreferencesInt(String key, int value) async {
    prefs.setInt(key, value);
  }

  int? getPreferencesInt(String key) {
    return prefs.getInt(key);
  }

  Future<void> removePreferences(String key) async {
    await prefs.remove(key);
  }
}
