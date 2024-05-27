import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/bloc/auth_bloc/auth_bloc.dart';
import 'package:front/models/user.dart';
import 'package:front/presentation/widgets/auth/role_select.dart';
import 'package:front/theme.dart';
import 'package:lottie/lottie.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key, required this.onSwitchAuthMode});

  final void Function() onSwitchAuthMode;

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final fullnameController = TextEditingController();
  final licenseNumberController = TextEditingController();
  Role? selectedRole;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          widget.onSwitchAuthMode();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Registracija uspešna.'),
              backgroundColor: seedColor,
            ),
          );
        }else if(state is AuthFailure){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Lottie.asset('assets/lottie/loading.json'),
              ),
            ),
          );
        }
        
        return Form(
          child: Column(
            children: [
              TextFormField(
                controller: fullnameController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  prefixIconColor: seedColor,
                  labelText: 'Ime i prezime',
                  errorText: (state is AuthValidationFailure &&
                          state.fullnameError != null)
                      ? state.fullnameError
                      : null,
                  suffixIcon: (state is AuthValidationFailure &&
                          state.fullnameError != null)
                      ? const Icon(Icons.error)
                      : null,
                  suffixIconColor: Colors.red,
                ),
                onChanged: (value) => _validate(context),
              ),
              TextFormField(
                controller: emailController,
                onChanged: (value) => _validate(context),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.alternate_email),
                  prefixIconColor: seedColor,
                  labelText: 'Email',
                  errorText: (state is AuthValidationFailure &&
                          state.emailError != null)
                      ? state.emailError
                      : null,
                  suffixIcon: (state is AuthValidationFailure &&
                          state.emailError != null)
                      ? const Icon(Icons.error)
                      : null,
                  suffixIconColor: Colors.red,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              RoleSelect(
                validate: () => _validate(context),
                selectRole: _selectRole,
                error:
                    (state is AuthValidationFailure) ? state.roleError : null,
              ),
              TextFormField(
                onChanged: (value) => _validate(context),
                controller: licenseNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.medical_information),
                  prefixIconColor: seedColor,
                  labelText: 'Broj licence',
                  errorText: (state is AuthValidationFailure &&
                          state.licenseNumberError != null)
                      ? state.licenseNumberError
                      : null,
                  suffixIcon: (state is AuthValidationFailure &&
                          state.licenseNumberError != null)
                      ? const Icon(Icons.error)
                      : null,
                  suffixIconColor: Colors.red,
                ),
              ),
              TextFormField(
                onChanged: (value) => _validate(context),
                controller: passwordController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  prefixIconColor: seedColor,
                  labelText: 'Lozinka',
                  errorText: (state is AuthValidationFailure &&
                          state.passwordError != null)
                      ? state.passwordError
                      : null,
                  suffixIcon: (state is AuthValidationFailure &&
                          state.passwordError != null)
                      ? const Icon(Icons.error)
                      : null,
                  suffixIconColor: Colors.red,
                ),
                obscureText: true,
                autocorrect: false,
              ),
              TextFormField(
                onChanged: (value) => _validate(context),
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  prefixIconColor: seedColor,
                  labelText: 'Potvrdite lozinku',
                  errorText: (state is AuthValidationFailure &&
                          state.confirmPasswordError != null)
                      ? state.confirmPasswordError
                      : null,
                  suffixIcon: (state is AuthValidationFailure &&
                          state.confirmPasswordError != null)
                      ? const Icon(Icons.error)
                      : null,
                  suffixIconColor: Colors.red,
                ),
                obscureText: true,
                autocorrect: false,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _validate(context);
                    _register(context);
                  },
                  child: const Text('Registrujte se'),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  void _selectRole(Role? role) {
    selectedRole = role;
  }

  void _register(BuildContext context) {
    final state = context.read<AuthBloc>().state;
    if (state is AuthValidationSuccess) {
      BlocProvider.of<AuthBloc>(context).add(
        RegisterEvent(
          fullnameController.text.trim(),
          emailController.text.trim(),
          licenseNumberController.text.trim(),
          selectedRole!,
          passwordController.text.trim(),
        ),
      );
    }
  }

  void _validate(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(
      ValidateRegisterForm(
        fullnameController.text.trim(),
        emailController.text.trim(),
        licenseNumberController.text.trim(),
        selectedRole,
        passwordController.text.trim(),
        confirmPasswordController.text.trim(),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    fullnameController.dispose();
    licenseNumberController.dispose();
    super.dispose();
  }
}
