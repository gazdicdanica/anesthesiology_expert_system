import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/bloc/auth_bloc/auth_bloc.dart';
import 'package:front/presentation/screens/auth_screen.dart';
import 'package:front/presentation/widgets/profile/field_widget.dart';
import 'package:front/theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if(state is LogoutSuccess){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AuthScreen()));

        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Podešavanja'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                const FieldWidget(
                  label: "Ime i prezime",
                  value: "Marko Marković",
                  icon: Icons.person,
                ),
                const SizedBox(
                  height: 10,
                ),
                const FieldWidget(
                  label: "Broj licence",
                  value: "123456",
                  icon: Icons.medical_information,
                ),
                const SizedBox(
                  height: 10,
                ),
                const FieldWidget(
                  label: "Lozinka",
                  value: "*",
                  icon: Icons.lock,
                ),
                const Spacer(),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'Izmeni',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                // Logout button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _logout(context);
                    },
                    style: Theme.of(context)
                        .elevatedButtonTheme
                        .style!
                        .copyWith(
                          elevation: MaterialStateProperty.all(5),
                          foregroundColor: MaterialStateProperty.all(seedColor),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                    child: const Text(
                      'Odjavi se',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _logout(BuildContext context) {
    context.read<AuthBloc>().add(LogoutEvent());
  }
}
