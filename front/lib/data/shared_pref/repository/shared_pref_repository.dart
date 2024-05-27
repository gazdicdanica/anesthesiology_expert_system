import 'package:front/data/shared_pref/data_provider/shared_pref_data_provider.dart';

class SharedPrefRepository{
  final SharedPrefDataProvider _dataProvider;

  SharedPrefRepository(this._dataProvider);

  void saveToken(String value) {
    _dataProvider.saveString("token", value);
  }

  String? getToken() {
    return _dataProvider.getString("token");
  }

  void saveEmail(String email) {
    _dataProvider.saveString("email", email);
  }

  String? getEmail() {
    return _dataProvider.getString("email");
  }
}