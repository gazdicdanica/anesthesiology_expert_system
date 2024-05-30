import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/bloc/auth_bloc/auth_bloc.dart';
import 'package:front/bloc/patient_bloc/patient_bloc.dart';
import 'package:front/data/auth/data_provider/auth_data_provider.dart';
import 'package:front/data/auth/repository/auth_repository.dart';
import 'package:front/data/patient/data_provider/patient_data_provider.dart';
import 'package:front/data/patient/repository/patient_repository.dart';
import 'package:front/data/shared_pref/data_provider/shared_pref_data_provider.dart';
import 'package:front/data/shared_pref/repository/shared_pref_repository.dart';
import 'package:front/presentation/screens/init_screen.dart';
import 'package:front/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPrefDataProvider = SharedPrefDataProvider();
  await sharedPrefDataProvider.init();

  final sharedPrefRepository = SharedPrefRepository(sharedPrefDataProvider);
  runApp(MyApp(repository: sharedPrefRepository));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.repository});

  final SharedPrefRepository repository;

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
          create: (context) => repository,
        ),
        RepositoryProvider(
          create: (context) => PatientRepository(
            PatientDataProvider(repository),
          ),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
              create: (context) => PatientBloc(
                    context.read<PatientRepository>(),
                  )),
        ],
        child: MaterialApp(
          title: 'Anesthesia Assistant',
          theme: theme,
          home: const InitScreen(),
        ),
      ),
    );
  }
}
