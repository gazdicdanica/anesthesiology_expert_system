import 'package:flutter/material.dart';
import 'package:front/models/patient.dart';

class PatientForm extends StatelessWidget{
  const PatientForm({super.key, this.patient});

  final Patient? patient;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Patient Form'),
    );
  }

}