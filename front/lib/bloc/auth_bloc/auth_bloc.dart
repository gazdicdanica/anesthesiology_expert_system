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
    on<ResetForm>(_resetForm);
    on<LoginEvent>(_login);
    on<ValidateLoginForm>(_validateLoginForm);
    on<RegisterEvent>(_register);
    on<ValidateRegisterForm>(_validateRegisterForm);
  }

  void _resetForm(ResetForm event, emit) {
    emit(AuthInitial());
  }

  void _login(LoginEvent event, emit) async{
    emit(AuthLoading());

    try {
      final token = await _repository.login(event.email, event.password);
      print(token);
      // await Future.delayed(const Duration(milliseconds: 500));
      emit(LoginSuccess());
    } on CustomException catch (e) {
      emit(CredentialsFailure(e.toString()));
    }catch(e){
      emit(AuthFailure("Došlo je do greške prilikom prijave. Molimo pokušajte ponovo kasnije."));
    }
  }


  void _validateLoginForm(ValidateLoginForm event, emit) async{
    String? emailError;
    String? passwordError;

    emailError = _validateRequiredField(event.email) ? null : 'Email je obavezan';
    passwordError = _validateRequiredField(event.password) ? null : 'Lozinka je obavezna';

    if (emailError != null || passwordError != null) {
      emit(AuthValidationFailure(emailError: emailError, passwordError: passwordError));
    } 
    else {
      emit(AuthValidationSuccess());
    }
  }

  void _register(RegisterEvent event, emit) async {
    emit(AuthLoading());
    try {
      await _repository.register(
        event.email,
        event.password,
        event.role,
        event.licenseNumber,
        event.fullname,
      );
      await Future.delayed(const Duration(milliseconds: 500));
      emit(RegisterSuccess());
    } on CustomException catch (e) {
      emit(AuthValidationFailure(emailError:  e.toString()));
    }catch(e){
      emit(AuthFailure("Došlo je do greške prilikom registracije. Molimo pokušajte ponovo kasnije."));
    }
  }

  void _validateRegisterForm(ValidateRegisterForm event, emit) {
    String? emailError;
    String? passwordError;
    String? fullnameError;
    String? licenseNumberError;
    String? roleError;
    String? confirmPasswordError;

    emailError = _validateEmail(event.email);
    fullnameError = _validateRequiredField(event.fullname) ? null : 'Ime i prezime su obavezni';
    licenseNumberError = _validateLicenseNumber(event.licenseNumber);
    roleError = event.role != null ? null : 'Tip licence je obavezan';
    passwordError = _validatePassword(event.password);
    confirmPasswordError = _validateConfirmPassword(event.password, event.confirmPassword);

    print(event.password != event.confirmPassword);
    
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

  String? _validateLicenseNumber(String? licenseNumber){
    if (licenseNumber == null || licenseNumber.isEmpty) {
      return 'Broj licence je obavezan';
    }else if(!RegExp(r'^\d{6}$').hasMatch(licenseNumber)){
      return 'Broj licence nije ispravnog formata';
    }
    return null;
  }

  String? _validatePassword(String? password){
    if (password == null || password.isEmpty) {
      return 'Lozinka je obavezna';
    }else if(password.length < 6){
      return 'Lozinka mora imati najmanje 6 karaktera';
    }
    return null;
  }

  bool _validateRequiredField(String? value){
    if (value == null || value.isEmpty) {
      return false;
    }
    return true;
  }

}
