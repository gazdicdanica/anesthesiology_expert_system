import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/bloc/auth_bloc/auth_bloc.dart';
import 'package:front/models/user.dart';
import 'package:front/presentation/screens/auth_screen.dart';
import 'package:front/presentation/widgets/loading_widget.dart';
import 'package:front/presentation/widgets/profile/field_widget.dart';
import 'package:front/theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User user;

  @override
  void initState() {
    super.initState();

    context.read<AuthBloc>().add(GetUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const AuthScreen()));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nalog'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                Widget content;

                if (state is AuthLoading) {
                  content = const LoadingWidget();
                }
                if (state is UserSuccess) {
                  user = state.user;

                  content = Column(
                    children: [
                      FieldWidget(
                        label: "Ime i prezime",
                        value: user.fullname,
                        icon: Icons.person,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FieldWidget(
                        label: "Broj licence",
                        value: user.licenseNumber,
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
                                foregroundColor:
                                    MaterialStateProperty.all(seedColor),
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
                  );
                } else {
                  content = Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error,
                          color: seedColor,
                          size: 80,
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            textAlign: TextAlign.center,
                            "Došlo je do greške prilikom učitavanja podataka.",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                    onRefresh: () async {
                      BlocProvider.of<AuthBloc>(context).add(GetUserEvent());
                    },
                    child: content);
              },
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
