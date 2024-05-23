import 'package:flutter/material.dart';
import 'package:front/theme.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});


  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.alternate_email),
              prefixIconColor: seedColor,
              labelText: 'Email',
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.lock),
              prefixIconColor: seedColor,
              labelText: 'Lozinka',
            ),
            obscureText: true,
            autocorrect: false,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Prijavite se'),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
