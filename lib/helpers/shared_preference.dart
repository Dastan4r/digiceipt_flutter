import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceController {
  Future<void> setString(String key, String value) async {
    final _sharedPref = await SharedPreferences.getInstance();

    _sharedPref.setString(key, value);
  }

  Future<String?> getString(String key) async {
    final _sharedPref = await SharedPreferences.getInstance();

    final gettingString = _sharedPref.getString(key);

    return gettingString;
  }

  Future<void> clearAll() async {
    final _sharedPref = await SharedPreferences.getInstance();

    _sharedPref.clear();
  }
}