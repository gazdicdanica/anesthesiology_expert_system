part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {
}

class ValidateRegisterForm extends AuthEvent {
  final String fullname;
  final String email;
  final String licenseNumber;
  final Role? role;
  final String password;
  final String confirmPassword;

  ValidateRegisterForm(this.fullname, this.email, this.licenseNumber, this.role, this.password, this.confirmPassword);
}

class RegisterEvent extends AuthEvent {
  final String fullname;
  final String email;
  final String licenseNumber;
  final Role role;
  final String password;

  RegisterEvent(this.fullname, this.email, this.licenseNumber, this.role, this.password);
}
