import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/bloc/patient_bloc/patient_bloc.dart';
import 'package:front/bloc/patient_form_bloc/patient_form_bloc.dart';
import 'package:front/models/patient.dart';
import 'package:front/presentation/widgets/add_patient.dart/checkbox_form.dart';
import 'package:front/theme.dart';

class PatientForm extends StatefulWidget {
  const PatientForm({super.key, this.patient, required this.jmbg});

  final Patient? patient;
  final String jmbg;

  @override
  State<PatientForm> createState() => _PatientFormState();
}

class _PatientFormState extends State<PatientForm> {
  final _fullnameController = TextEditingController();
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<PatientFormBloc>().add(PatientResetForm());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.read<PatientBloc>().add(ResetForm());
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Form(
          child: SingleChildScrollView(
            child: BlocBuilder<PatientFormBloc, PatientFormState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Unesite podatke o pacijentu',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _fullnameController,
                      decoration: InputDecoration(
                        labelText: 'Ime i prezime',
                        prefixIcon: const Icon(
                          Icons.person,
                          color: seedColor,
                        ),
                        errorText: (state as PatientFormValuesState).fullNameError,
                        suffixIcon: state.fullNameError != null
                            ? const Icon(Icons.error, color: Colors.red)
                            : null,
                      ),
                      onChanged: (value) {
                        context.read<PatientFormBloc>().add(
                            TextFieldChanged(field: 'fullname', value: value));
                      },
                    ),
                    TextFormField(
                      controller: _ageController,
                      decoration: InputDecoration(
                        labelText: 'Godine',
                        prefixIcon: const Icon(
                          Icons.person,
                          color: seedColor,
                        ),
                        errorText: (state).ageError,
                        suffixIcon: state.ageError != null
                            ? const Icon(Icons.error, color: Colors.red)
                            : null,
                      ),
                      onChanged: (value) {
                        context
                            .read<PatientFormBloc>()
                            .add(TextFieldChanged(field: 'age', value: value));
                      },
                      keyboardType: TextInputType.number,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _heightController,
                            decoration: InputDecoration(
                              labelText: 'Visina',
                              suffix: Text(
                                "cm",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              prefixIcon: const Icon(
                                Icons.height,
                                color: seedColor,
                              ),
                              errorText: state.heightError,
                              errorMaxLines: 2,
                              suffixIcon: state.heightError != null
                                  ? const Icon(Icons.error, color: Colors.red)
                                  : null,
                            ),
                            onChanged: (value) {
                              context.read<PatientFormBloc>().add(TextFieldChanged(
                                  field: 'height', value: value));
                            },
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: _weightController,
                            decoration: InputDecoration(
                              labelText: 'Težina',
                              suffix: Text(
                                "kg",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              prefixIcon: const Icon(
                                Icons.monitor_weight,
                                color: seedColor,
                              ),
                              errorText: state.weightError,
                              errorMaxLines: 2,
                              suffixIcon: state.weightError != null
                                  ? const Icon(Icons.error, color: Colors.red)
                                  : null,
                            ),
                            onChanged: (value) {
                              context.read<PatientFormBloc>().add(TextFieldChanged(
                                  field: 'weight', value: value));
                            },
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const CheckboxForm(),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('Sačuvaj'),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
