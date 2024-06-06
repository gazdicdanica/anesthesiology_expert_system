import 'dart:convert';

import 'package:front/server_path.dart';
import 'package:front/custom_exception.dart';
import 'package:front/data/shared_pref/repository/shared_pref_repository.dart';
import 'package:front/models/user.dart';
import 'package:http/http.dart' as http;

class AuthDataProvider {

  final SharedPrefRepository _sharedPrefRepository;

  AuthDataProvider(this._sharedPrefRepository);

  Future<void> register(String email, String password, Role role,
      String licenseNumber, String fullname) async {
    final res = await http.post(
      Uri.parse("${path}user/register"),
      body: jsonEncode({
        "email": email,
        "password": password,
        "role": getRoleString(role),
        "licenseNumber": licenseNumber,
        "fullname": fullname,
      }),
      headers: {"Content-Type": "application/json"},
    );

    if (res.statusCode == 200) {
      return Future.value();
    } else {
      throw CustomException(res.body);
    }
  }

  Future<String> login(String email, String password) async {
    final res = await http.post(Uri.parse("${path}user/login"),
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
      headers: {"Content-Type": "application/json"},
    );

    if (res.statusCode == 200) {
      return Future.value(res.body);
    } else {
      throw CustomException(res.body);
    }
  }

  Future<void> logout() {
    _sharedPrefRepository.removeToken();
    return Future.value();
  }

  Future<String> getUser() async {
    final token = await _sharedPrefRepository.getToken();
    final res = await http.get(
      Uri.parse("${path}user"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (res.statusCode == 200) {
      return Future.value(res.body);
    } else {
      print(res.body);
      throw CustomException(res.body);
    }
  }
}
