import 'dart:ffi';

class User {
  final Long id;
  final String name;
  final String email;
  final String licenseNumber;
  final String role;
  final String password;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.licenseNumber,
    required this.role,
    required this.password,
  });
}

enum Role {
  nurse,
  doctor
}