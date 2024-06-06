import 'dart:convert';

import 'package:front/data/auth/data_provider/auth_data_provider.dart';
import 'package:front/models/user.dart';

class AuthRepository{

  final AuthDataProvider dataProvider;

  AuthRepository(this.dataProvider);


  Future<void> register(String email, String password, Role role, String licenseNumber, String fullname) async {
    return dataProvider.register(email, password, role, licenseNumber, fullname);
  }

  Future<String> login(String email, String password) async {
    return dataProvider.login(email, password);
  }

  Future<void> logout() async {
    return dataProvider.logout();
  }

  Future<User> getUser() async {
    String response = await dataProvider.getUser();
    String decodedResponse = utf8.decode(response.runes.toList());
    return User.fromJson(jsonDecode(decodedResponse));
  }
}