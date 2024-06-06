part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {
}

class ResetForm extends AuthEvent {}

class ValidateRegisterForm extends AuthEvent {
  final String fullname;
  final String email;
  final String licenseNumber;
  final Role? role;
  final String password;
  final String confirmPassword;

  ValidateRegisterForm(this.fullname, this.email, this.licenseNumber, this.role, this.password, this.confirmPassword);
}

class ValidateLoginForm extends AuthEvent {
  final String email;
  final String password;

  ValidateLoginForm(this.email, this.password);
}

class RegisterEvent extends AuthEvent {
  final String fullname;
  final String email;
  final String licenseNumber;
  final Role role;
  final String password;

  RegisterEvent(this.fullname, this.email, this.licenseNumber, this.role, this.password);
}

class LoginEvent extends AuthEvent{
  final String email;
  final String password;

  LoginEvent(this.email, this.password);
}

class LogoutEvent extends AuthEvent {}

class GetUserEvent extends AuthEvent {}
