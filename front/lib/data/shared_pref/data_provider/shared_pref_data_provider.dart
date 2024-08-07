import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefDataProvider {
  late SharedPreferences _sharedPreferences;

  SharedPrefDataProvider();

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  saveString(String key, String value) async {
    await _sharedPreferences.setString(key, value);
  }

  Future<String?> getString(String key) async{
    String? value = _sharedPreferences.getString(key);
    return Future.value(value);
  }

  remove(String key) async {
    await _sharedPreferences.remove(key);
  }
}
