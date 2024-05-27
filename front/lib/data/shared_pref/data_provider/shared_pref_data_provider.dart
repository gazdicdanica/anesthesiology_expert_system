import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefDataProvider {
  late SharedPreferences _sharedPreferences;

  SharedPrefDataProvider() {
    init();
  }

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  saveString(String key, String value) async {
    await _sharedPreferences.setString(key, value);
  }

  String? getString(String key) {
    return _sharedPreferences.getString(key);
  }
}
