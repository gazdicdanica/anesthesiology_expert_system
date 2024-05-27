import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/bloc/auth_bloc/auth_bloc.dart';
import 'package:front/data/auth/data_provider/auth_data_provider.dart';
import 'package:front/data/auth/repository/auth_repository.dart';
import 'package:front/data/shared_pref/data_provider/shared_pref_data_provider.dart';
import 'package:front/data/shared_pref/repository/shared_pref_repository.dart';
import 'package:front/presentation/screens/auth_screen.dart';
import 'package:front/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(
            AuthDataProvider(),
          ),
        ),
        RepositoryProvider(
          create: (context) => SharedPrefRepository(
            SharedPrefDataProvider(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              context.read<AuthRepository>(),
            ),
          )
        ],
        child: MaterialApp(
          title: 'Anesthesia Assistant',
          theme: theme,
          home: const AuthScreen(),
        ),
      ),
    );
  }
}
