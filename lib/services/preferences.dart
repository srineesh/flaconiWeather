import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  void setIntValue(String key, int value) async {
    final SharedPreferences pref = await _pref;
    await pref.setInt(key, value);
  }

  void setStringValue(String key, String value) async {
    final SharedPreferences pref = await _pref;
    await pref.setString(key, value);
  }

  Future<int?> retrieveWoeid(String keyName) async {
    final SharedPreferences pref = await _pref;
    int? woeid = pref.getInt(keyName);
    return woeid;
  }

  Future<String?> retrieveString(String keyName) async {
    final SharedPreferences pref = await _pref;
    String? tempPref = pref.getString(keyName);
    return tempPref;
  }
}
