import 'package:flutter/material.dart';

class NavigationLink extends StatelessWidget{
  const NavigationLink({super.key, required this.onSwitchAuthMode, required this.isLogin});

  final VoidCallback onSwitchAuthMode;
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isLogin ? 'Nemate nalog?' : 'Već imate nalog?'	,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        TextButton(
          onPressed: onSwitchAuthMode,
          child: Text( isLogin ? 'Registrujte se' : 'Prijavite se' ),
        ),
      ],
    );
  }

}