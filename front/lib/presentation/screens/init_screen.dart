import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/data/shared_pref/repository/shared_pref_repository.dart';
import 'package:front/presentation/screens/auth_screen.dart';
import 'package:front/presentation/widgets/bottom_navigation.dart';

class InitScreen extends StatelessWidget{
  const InitScreen({super.key});

 @override
  Widget build(BuildContext context) {
    final sharedPrefRepository = context.read<SharedPrefRepository>();
    return FutureBuilder<String?>(
      future: sharedPrefRepository.getToken(), // Assume this is the method to get the token
      builder: (context, snapshot) {
        
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData && snapshot.data != null) {
          return const CustomBottomNavigation(); // User is authenticated
        } else {
          return const AuthScreen(); // User needs to log in
        }
      },
    );
  }
  
}