import 'package:flutter/material.dart';
import 'package:front/presentation/widgets/add_patient.dart/jmbg_form.dart';

class AddPatientScreen extends StatelessWidget {
  const AddPatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: JmbgForm(),
    );
  }
}