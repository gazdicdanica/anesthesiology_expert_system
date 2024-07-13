import 'package:front/data/shared_pref/data_provider/shared_pref_data_provider.dart';
import 'package:jwt_decode/jwt_decode.dart';

class SharedPrefRepository {
  final SharedPrefDataProvider _dataProvider;

  SharedPrefRepository(this._dataProvider);

  void saveToken(String value) async {
    await _dataProvider.saveString("token", value);

    Map<String, dynamic> payload = Jwt.parseJwt(value);
    String role = payload['role'];
    await _dataProvider.saveString("role", role);
  }

  Future<String?> getToken() async {
    String? token = await _dataProvider.getString("token");
    return Future.value(token);
  }

  Future<String?> getRole() async {
    print(await _dataProvider.getString("role"));
    String? role = await _dataProvider.getString("role");
    return Future.value(role);
  }

  void removeToken() async {
    await _dataProvider.remove("token");
  }

  void saveEmail(String email) {
    _dataProvider.saveString("email", email);
  }

  Future<String?> getEmail() async {
    return _dataProvider.getString("email");
  }
}
