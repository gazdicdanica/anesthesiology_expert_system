import 'package:flutter/material.dart';
import 'package:front/presentation/widgets/auth/auth_widget.dart';

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
          builder: (context, constraints) => ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: AuthWidget(
              onSwitchAuthMode: () {_switchAuthMode(context); },
              isLogin: isLogin,
            ),
          ),
        ),
      ),
    );
  }

  void _switchAuthMode(BuildContext context) {
    setState(() {
      isLogin = !isLogin;
    });
  }
}
