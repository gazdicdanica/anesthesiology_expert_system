import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/bloc/patient_bloc/patient_bloc.dart';
import 'package:front/models/patient.dart';

class PatientForm extends StatelessWidget{
  const PatientForm({super.key, this.patient});

  final Patient? patient;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
           context.read<PatientBloc>().add(ResetForm());
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Text('Patient Form'),
    );
  }

}