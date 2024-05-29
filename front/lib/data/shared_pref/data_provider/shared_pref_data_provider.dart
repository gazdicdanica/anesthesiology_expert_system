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
    return Future.value(_sharedPreferences.getString(key));
  }
}
