import 'dart:convert';

import 'package:front/constant.dart';
import 'package:front/custom_exception.dart';
import 'package:front/models/user.dart';
import 'package:http/http.dart' as http;

class AuthDataProvider {
  Future<void> register(String email, String password, Role role,
      String licenseNumber, String fullname) async {
    final res = await http.post(
      Uri.parse("${path}user/register"),
      body: jsonEncode({
        "email": email,
        "password": password,
        "role": role.toJson(),
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
      print(res.body);
      throw CustomException(res.body);
    }
  }
}
