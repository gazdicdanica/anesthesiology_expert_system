import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/custom_exception.dart';
import 'package:front/data/auth/repository/auth_repository.dart';
import 'package:front/models/user.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;

  AuthBloc(this._repository) : super(AuthInitial()) {
    on<RegisterEvent>(_register);
    on<ValidateRegisterForm>(_validateRegisterForm);
  }

  void _register(RegisterEvent event, emit) async {
    emit(AuthLoading());
    await Future.delayed(const Duration(seconds: 1));
    try {
      await _repository.register(
        event.email,
        event.password,
        event.role,
        event.licenseNumber,
        event.fullname,
      );
      emit(RegisterSuccess());
    } on CustomException catch (e) {
      emit(AuthValidationFailure(emailError:  e.toString()));
    }catch(e){
      emit(AuthValidationFailure(emailError: "Došlo je do greške prilikom registracije. Molimo pokušajte ponovo kasnije."));
    }
  }

  String? _validateEmail(String? email){
    if (email == null || email.isEmpty) {
      return 'Email je obavezno polje';
    } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email)) {
      return 'Email nije validan';
    }
    return null;
  }

  String? _validateConfirmPassword(String? password, String? confirmPassword){
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Potvrda lozinke je obavezna';
    } else if (password != confirmPassword) {
      return 'Lozinke se ne poklapaju';
    }
    return null;
  }

  bool _isRequiredFieldValid(String? value){
    if (value == null || value.isEmpty) {
      return false;
    }
    return true;
  }

  void _validateRegisterForm(ValidateRegisterForm event, emit) {
    String? emailError;
    String? passwordError;
    String? fullnameError;
    String? licenseNumberError;
    String? roleError;
    String? confirmPasswordError;

    emailError = _validateEmail(event.email);
    fullnameError = _isRequiredFieldValid(event.fullname) ? null : 'Ime i prezime su obavezni';
    licenseNumberError = _isRequiredFieldValid(event.licenseNumber) ? null : 'Broj licence je obavezan';
    roleError = event.role != null ? null : 'Tip licence je obavezan';
    passwordError = _isRequiredFieldValid(event.password) ? null : 'Lozinka je obavezna';
    confirmPasswordError = _validateConfirmPassword(event.password, event.confirmPassword);
    
    if (emailError != null || passwordError != null || fullnameError != null || licenseNumberError != null || roleError != null || confirmPasswordError != null) {
      emit(AuthValidationFailure(
        emailError: emailError,
        passwordError: passwordError,
        fullnameError: fullnameError,
        licenseNumberError: licenseNumberError,
        roleError: roleError,
        confirmPasswordError: confirmPasswordError,
      ));
    } 
    else {
      emit(AuthValidationSuccess());
    }
    
  }
}
