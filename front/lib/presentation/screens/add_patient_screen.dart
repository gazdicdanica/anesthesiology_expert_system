import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/bloc/patient_bloc/patient_bloc.dart';
import 'package:front/presentation/widgets/add_patient.dart/jmbg_form.dart';
import 'package:front/presentation/widgets/add_patient.dart/patient_form.dart';
import 'package:front/presentation/widgets/loading_widget.dart';

class AddPatientScreen extends StatelessWidget {
  const AddPatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PatientBloc, PatientState>(
        listener: (context, state) {
          if (state is PatientFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is PatientLoading) return const LoadingWidget();

          if (state is PatientSuccess) {
            return PatientForm(
              patient: state.patient,
            );
          }

          return const JmbgForm();
        },
      ),
    );
  }
}
