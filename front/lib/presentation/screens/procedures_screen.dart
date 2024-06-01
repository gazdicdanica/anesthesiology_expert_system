import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/bloc/patient_bloc/patient_bloc.dart';
import 'package:front/presentation/widgets/add_procedure.dart/procedure_form.dart';

class ProceduresScreen extends StatelessWidget {
  const ProceduresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientBloc, PatientState>(
      builder: (context, state) {
        if (state is UpdatePatientSuccess) {
          return ProcedureForm(
            patient: state.patient,
          );
        } else if (state is AddPatientSuccess) {
          return ProcedureForm(
            patient: state.patient,
          );
        }

        return const Center(
          child: Text('Index 0: Procedures'),
        );

      },
    );
  }
}
