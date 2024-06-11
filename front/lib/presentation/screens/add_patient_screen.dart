import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/bloc/patient_bloc/patient_bloc.dart';
import 'package:front/presentation/widgets/add_patient/jmbg_form.dart';
import 'package:front/presentation/widgets/add_patient/patient_form.dart';
import 'package:front/presentation/widgets/loading_widget.dart';
import 'package:front/theme.dart';

class AddPatientScreen extends StatefulWidget {
  const AddPatientScreen({super.key, required this.onAddPatientTap});

  final void Function(int) onAddPatientTap;

  @override
  State<AddPatientScreen> createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  String? jmbg;

  void _setJmbg(String? jmbg) {
    setState(() {
      this.jmbg = jmbg;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<PatientBloc, PatientState>(
          listener: (context, state) {
            if (state is PatientFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  elevation: 20.0,
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                ),
              );
            }
            if (state is AddPatientSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  elevation: 20.0,
                  content: Text('Pacijent uspešno dodat'),
                  backgroundColor: snackBarColor,
                ),
              );
              // context.read<PatientBloc>().add(ResetForm());
              _navigateToProcedures();
            }
            if (state is UpdatePatientSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Pacijent uspešno ažuriran'),
                  backgroundColor: snackBarColor,
                ),
              );
              // context.read<PatientBloc>().add(ResetForm());
              _navigateToProcedures();
            }
          },
          builder: (context, state) {
            if (state is PatientLoading) return const LoadingWidget();

            if (state is PatientSuccess) {
              return PatientForm(
                patient: state.patient,
                jmbg: jmbg!,
              );
            }

            return JmbgForm(
              setJmbg: _setJmbg,
              jmbg: jmbg,
            );
          },
        ),
      ),
    );
  }

  void _navigateToProcedures() {
    widget.onAddPatientTap(0);
    _setJmbg(null);
  }
}
