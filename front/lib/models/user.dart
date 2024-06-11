import 'dart:convert';

class User {
  final int id;
  final String fullname;
  final String email;
  final String licenseNumber;
  final Role role;
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
      'fullname': fullname,
      'email': email,
      'licenseNumber': licenseNumber,
      'role': role,
      'password': password,
    };
  }

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      fullname: map['fullname'] as String,
      email: map['email'] as String,
      licenseNumber: map['licenseNumber'] as String,
      role: parseRole(map['role']),
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

}

enum Role {
  NURSE,
  DOCTOR
}

Role parseRole(String role) {
  switch (role) {
    case 'NURSE':
      return Role.NURSE;
    case 'DOCTOR':
      return Role.DOCTOR;
    default:
      throw Exception('Unknown role: $role');
  }
}

String getRoleString(Role role) {
  return role.toString().split('.').last.toUpperCase();
  
}
