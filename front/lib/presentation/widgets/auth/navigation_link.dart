import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/bloc/auth_bloc/auth_bloc.dart';

class NavigationLink extends StatelessWidget {
  const NavigationLink(
      {super.key, required this.onSwitchAuthMode, required this.isLogin});

  final VoidCallback onSwitchAuthMode;
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isLogin ? 'Nemate nalog?' : 'Već imate nalog?',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        TextButton(
          onPressed: () {
            context.read<AuthBloc>().add(ResetForm());
            onSwitchAuthMode();
          },
          child: Text(isLogin ? 'Registrujte se' : 'Prijavite se'),
        ),
      ],
    );
  }
}
