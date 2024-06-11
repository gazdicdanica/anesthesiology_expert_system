part of 'auth_bloc.dart';

@immutable
sealed class AuthState extends Equatable {}

final class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

final class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

final class AuthValidationFailure extends AuthState {
  final String? emailError;
  final String? passwordError;
  final String? fullnameError;
  final String? licenseNumberError;
  final String? roleError;
  final String? confirmPasswordError;

  AuthValidationFailure({
    this.emailError,
    this.passwordError,
    this.fullnameError,
    this.licenseNumberError,
    this.roleError,
    this.confirmPasswordError,
  });

  @override
  List<Object?> get props => [
        emailError,
        passwordError,
        fullnameError,
        licenseNumberError,
        roleError,
        confirmPasswordError,
      ];
}

final class AuthValidationSuccess extends AuthState {
  @override
  List<Object?> get props => [];
}

final class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}

final class CredentialsFailure extends AuthState {
  final String message;

  CredentialsFailure(this.message);

  @override
  List<Object?> get props => [message];
}

final class RegisterSuccess extends AuthState {
  @override
  List<Object?> get props => [];
}

final class LoginSuccess extends AuthState {
  final String token;

  LoginSuccess(this.token);

  @override
  List<Object?> get props => [token];
}

final class LogoutSuccess extends AuthState {
  @override
  List<Object?> get props => [];
}

final class UserSuccess extends AuthState {
  final User user;

  UserSuccess(this.user);

  @override
  List<Object?> get props => [user];
}