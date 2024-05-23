import 'package:flutter/material.dart';
import 'package:front/presentation/widgets/auth/role_select.dart';
import 'package:front/theme.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key, required this.onSwitchAuthMode});

  final void Function() onSwitchAuthMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Image.asset(
              "assets/Doctors-bro.png",
              height: MediaQuery.of(context).size.height / 3,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Registrujte se',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                Form(
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
                ),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Već imate nalog?',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            TextButton(
              onPressed: onSwitchAuthMode,
              child: const Text('Prijavite se'),
            ),
          ],
        )
      ],
    );
  }
}
