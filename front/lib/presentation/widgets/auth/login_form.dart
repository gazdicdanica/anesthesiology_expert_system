import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/bloc/auth_bloc/auth_bloc.dart';
import 'package:front/data/shared_pref/repository/shared_pref_repository.dart';
import 'package:front/presentation/widgets/bottom_navigation.dart';
import 'package:front/theme.dart';
import 'package:lottie/lottie.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (ctx, state) {
        if (state is LoginSuccess) {
          context.read<SharedPrefRepository>().saveEmail(emailController.text.trim());
          context.read<SharedPrefRepository>().saveToken(state.token);
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const CustomBottomNavigation()));
        }

        if (state is AuthFailure) {
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
          key: formKey,
          child: Column(
            children: [
              if (state is CredentialsFailure)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    state.message,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Colors.red),
                  ),
                ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.alternate_email),
                  prefixIconColor: seedColor,
                  labelText: 'Email',
                  errorText: _getEmailError(context),
                  suffixIcon: (state is AuthValidationFailure &&
                          state.emailError != null) || state is CredentialsFailure
                      ? const Icon(Icons.error)
                      : null,
                  suffixIconColor: Colors.red,
                ),
                onChanged: (value) => _validate(context),
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  prefixIconColor: seedColor,
                  labelText: 'Lozinka',
                  errorText: _getPasswordError(context),
                  suffixIcon: (state is AuthValidationFailure &&
                          state.passwordError != null) || state is CredentialsFailure
                      ? const Icon(Icons.error)
                      : null,
                  suffixIconColor: Colors.red,
                ),
                onChanged: (value) => _validate(context),
                obscureText: true,
                autocorrect: false,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _validate(context);
                    _login(context);
                  },
                  child: const Text('Prijavite se'),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  String? _getEmailError(BuildContext context){
    final state = context.read<AuthBloc>().state;
    if (state is AuthValidationFailure && state.emailError != null) {
      return state.emailError;
    }else if(state is CredentialsFailure){
      return " ";
    }

    return null;
  }

  String? _getPasswordError(BuildContext context){
    final state = context.read<AuthBloc>().state;
    if (state is AuthValidationFailure && state.passwordError != null) {
      return state.passwordError;
    }else if(state is CredentialsFailure){
      return " ";
    }

    return null;
  }

  void _login(BuildContext context) {
    final state = context.read<AuthBloc>().state;
    if (state is AuthValidationSuccess) {
      BlocProvider.of<AuthBloc>(context).add(
        LoginEvent(
          emailController.text.trim(),
          passwordController.text.trim(),
        ),
      );
    }
  }

  void _validate(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(
      ValidateLoginForm(
        emailController.text.trim(),
        passwordController.text.trim(),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
