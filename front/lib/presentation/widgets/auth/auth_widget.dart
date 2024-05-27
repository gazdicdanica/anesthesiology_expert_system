import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/bloc/auth_bloc/auth_bloc.dart';
import 'package:front/presentation/widgets/auth/login_form.dart';
import 'package:front/presentation/widgets/auth/navigation_link.dart';
import 'package:front/presentation/widgets/auth/register_form.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget(
      {super.key, required this.onSwitchAuthMode, required this.isLogin});

  final void Function() onSwitchAuthMode;
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final isPortrait = orientation == Orientation.portrait;

    return isPortrait
        ? BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          if (state is! AuthLoading)
                          Image.asset(
                            isLogin
                                ? 'assets/images/Doctor-bro.png'
                                : 'assets/images/Doctors-bro.png',
                            height: MediaQuery.of(context).size.height / 3,
                          ),
                          const SizedBox(height: 20),
                          if (state is! AuthLoading)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              isLogin ? 'Prijavite se' : 'Registrujte se',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          const SizedBox(height: 20),
                          isLogin ? const LoginForm() :  RegisterForm(onSwitchAuthMode: onSwitchAuthMode,),
                        ],
                      ),
                      if (state is! AuthLoading)
                        NavigationLink(
                            onSwitchAuthMode: onSwitchAuthMode,
                            isLogin: isLogin),
                    ],
                  ),
                ),
              );
            },
          )
        : BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Row(
                children: [
                  if (state is! AuthLoading)
                  Expanded(
                    flex: 2,
                    child: Image.asset(
                      isLogin
                          ? 'assets/images/Doctor-bro.png'
                          : 'assets/images/Doctors-bro.png',
                      height: MediaQuery.of(context).size.height / 1.5,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (state is! AuthLoading)
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                isLogin ? 'Prijavite se' : 'Registrujte se',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            isLogin ? const LoginForm() :  RegisterForm(onSwitchAuthMode: onSwitchAuthMode,),
                            if (state is! AuthLoading)
                              NavigationLink(
                                  onSwitchAuthMode: onSwitchAuthMode,
                                  isLogin: isLogin),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
  }
}
