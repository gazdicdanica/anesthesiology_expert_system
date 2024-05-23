import 'package:flutter/material.dart';
import 'package:front/presentation/widgets/auth/login.dart';
import 'package:front/presentation/widgets/auth/register.dart';

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
                child: isLogin ?  LoginForm(onSwitchAuthMode: _switchAuthMode,) :  RegisterForm(onSwitchAuthMode: _switchAuthMode,),
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
