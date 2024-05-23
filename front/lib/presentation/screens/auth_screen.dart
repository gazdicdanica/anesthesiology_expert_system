import 'package:flutter/material.dart';
import 'package:front/presentation/widgets/login.dart';
import 'package:front/presentation/widgets/register.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: isLogin ? const LoginForm() : const RegisterForm(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _switchAuthMode() {
    setState(() {
      isLogin = !isLogin;
    });
  }
}
