// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final int id;
  final String fullname;
  final String email;
  final String licenseNumber;
  final String role;
  final String password;

  User({
    required this.id,
    required this.fullname,
    required this.email,
    required this.licenseNumber,
    required this.role,
    required this.password,
  });



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': fullname,
      'email': email,
      'licenseNumber': licenseNumber,
      'role': role,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: int.tryParse(map['id'])!,
      fullname: map['name'] as String,
      email: map['email'] as String,
      licenseNumber: map['licenseNumber'] as String,
      role: map['role'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);
}

enum Role {
  nurse,
  doctor
}

extension RoleExtension on Role {
  String toJson() {
    return toString().split('.').last.toUpperCase();
  }
}

extension StringRoleExtension on String {
  Role toRole() {
    switch (this) {
      case 'DOCTOR':
        return Role.doctor;
      case 'NURSE':
        return Role.nurse;
      default:
        throw Exception('Unknown role: $this');
    }
  }
}