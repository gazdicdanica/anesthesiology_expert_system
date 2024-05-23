import 'package:flutter/material.dart';
import 'package:front/theme.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key, required this.onSwitchAuthMode});

  final void Function() onSwitchAuthMode; 

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Image.asset(
              "assets/Doctor-bro.png",
              height: MediaQuery.of(context).size.height / 3,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Prijavite se',
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
                ),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nemate nalog?', style: Theme.of(context).textTheme.bodyMedium,),
            TextButton(
              onPressed: onSwitchAuthMode,
              child: const Text('Registrujte se'),
            ),
          ],
        )
        
      ],
    );
  }
}
