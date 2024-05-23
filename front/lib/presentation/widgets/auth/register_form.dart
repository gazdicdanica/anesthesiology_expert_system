import 'package:flutter/material.dart';
import 'package:front/presentation/widgets/auth/role_select.dart';
import 'package:front/theme.dart';

class RegisterForm extends StatelessWidget{
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.person),
              prefixIconColor: seedColor,
              labelText: 'Ime i prezime',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.alternate_email),
              prefixIconColor: seedColor,
              labelText: 'Email',
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const RoleSelect(),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.medical_information),
              prefixIconColor: seedColor,
              labelText: 'Broj licence',
            ),
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
          TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.lock),
              prefixIconColor: seedColor,
              labelText: 'Potvrdi lozinku',
            ),
            obscureText: true,
            autocorrect: false,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Registrujte se'),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
  
}