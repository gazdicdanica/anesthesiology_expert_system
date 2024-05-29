import 'package:front/data/shared_pref/data_provider/shared_pref_data_provider.dart';

class SharedPrefRepository {
  final SharedPrefDataProvider _dataProvider;

  SharedPrefRepository(this._dataProvider);

  void saveToken(String value) async {
    await _dataProvider.saveString("token", value);
  }

  Future<String?> getToken() async {
    String? token = await _dataProvider.getString("token");
    return Future.value(token);
  }

  void saveEmail(String email) {
    _dataProvider.saveString("email", email);
  }

  Future<String?> getEmail() async {
    return _dataProvider.getString("email");
  }
}
