import 'package:flutter/material.dart';
import 'package:front/presentation/widgets/auth/login.dart';
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
        ? SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        isLogin
                            ? 'assets/images/Doctor-bro.png'
                            : 'assets/images/Doctors-bro.png',
                        height: MediaQuery.of(context).size.height / 3,
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          isLogin ? 'Prijavite se': 'Registrujte se' ,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          isLogin ? const LoginForm() : const RegisterForm(),
                        ],
                      ),
                    ],
                  ),
                  NavigationLink(onSwitchAuthMode: onSwitchAuthMode, isLogin: isLogin),
                ],
              ),
            ),
          )
        : Row(
            children: [
              Expanded(
                flex: 2,
                child: Image.asset(
                  isLogin ? 'assets/images/Doctor-bro.png' : 'assets/images/Doctors-bro.png',
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
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            isLogin ? 'Prijavite se': 'Registrujte se' ,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        isLogin ? const   LoginForm() : const RegisterForm(),
                        NavigationLink(onSwitchAuthMode: onSwitchAuthMode, isLogin: isLogin),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
  }

}
