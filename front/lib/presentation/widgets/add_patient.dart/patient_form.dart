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

    if (widget.patient != null) {
      _fullnameController.text = widget.patient!.fullname;
      _ageController.text = widget.patient!.age.toString();
      _heightController.text = widget.patient!.height.toString();
      _weightController.text = widget.patient!.weight.toString();
      context.read<PatientFormBloc>().add(ToggleCheckbox(
          field: 'hasDiabetes', value: widget.patient!.hasDiabetes));
      context.read<PatientFormBloc>().add(ToggleCheckbox(
          field: 'hadHeartAttack', value: widget.patient!.hadHearthAttack));
      context.read<PatientFormBloc>().add(ToggleCheckbox(
          field: 'hasHeartFailure', value: widget.patient!.hasHearthFailure));
      context.read<PatientFormBloc>().add(ToggleCheckbox(
          field: 'hasHypertension', value: widget.patient!.hasHypertension));
      context.read<PatientFormBloc>().add(ToggleCheckbox(
          field: 'controlledHypertension',
          value: widget.patient!.controlledHypertension));
      context.read<PatientFormBloc>().add(
          ToggleCheckbox(field: 'hadStroke', value: widget.patient!.hadStroke));
      context.read<PatientFormBloc>().add(ToggleCheckbox(
          field: 'hasRenalFailure', value: widget.patient!.hasRenalFailure));
      context.read<PatientFormBloc>().add(ToggleCheckbox(
          field: 'addictions', value: widget.patient!.addictions));
      context.read<PatientFormBloc>().add(ToggleCheckbox(
          field: 'smokerOrAlcoholic',
          value: widget.patient!.smokerOrAlcoholic));
      context.read<PatientFormBloc>().add(
          ToggleCheckbox(field: 'pregnant', value: widget.patient!.pregnant));
    }
  }

  @override
  Widget build(BuildContext ctx) {
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
                        widget.patient == null
                            ? 'Unesite podatke o pacijentu'
                            : 'Izmenite podatke o pacijentu',
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
                        errorText:
                            (state as PatientFormValuesState).fullNameError,
                        suffixIcon: state.fullNameError != null
                            ? const Icon(Icons.error, color: Colors.red)
                            : null,
                      ),
                      onChanged: (value) {
                        context.read<PatientFormBloc>().add(
                            TextFieldChanged(field: 'fullname', value: value.trim()));
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
                            .add(TextFieldChanged(field: 'age', value: value.trim()));
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
                              context.read<PatientFormBloc>().add(
                                  TextFieldChanged(
                                      field: 'height', value: value.trim()));
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
                              context.read<PatientFormBloc>().add(
                                  TextFieldChanged(
                                      field: 'weight', value: value.trim()));
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
                        onPressed: () {
                          _validate(context);
                          if (widget.patient == null) {
                            _addPatient(context);
                          } else {
                            _updatePatient(context);
                          }
                        },
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

  void _validate(BuildContext context) {
    final bloc = BlocProvider.of<PatientFormBloc>(context);
    bloc.add(
      TextFieldChanged(
        field: 'fullname',
        value: _fullnameController.text.trim(),
      ),
    );
    bloc.add(
      TextFieldChanged(
        field: 'age',
        value: _ageController.text.trim(),
      ),
    );
    bloc.add(
      TextFieldChanged(
        field: 'height',
        value: _heightController.text.trim(),
      ),
    );
    bloc.add(
      TextFieldChanged(
        field: 'weight',
        value: _weightController.text.trim(),
      ),
    );
  }

  void _addPatient(BuildContext context) {
    final state =
        context.read<PatientFormBloc>().state as PatientFormValuesState;
    if (state.fullNameError != null ||
        state.ageError != null ||
        state.heightError != null ||
        state.weightError != null) {
      return;
    }
    final patient = PatientDTO(
      fullname: _fullnameController.text,
      jmbg: widget.jmbg,
      age: int.parse(_ageController.text),
      height: double.parse(_heightController.text),
      weight: double.parse(_weightController.text),
      hasDiabetes: state.hasDiabetes,
      hadHearthAttack: state.hadHearthAttack,
      hasHearthFailure: state.hasHearthFailure,
      hasHypertension: state.hasHypertension,
      controlledHypertension: state.controlledHypertension,
      hadStroke: state.hadStroke,
      hasRenalFailure: state.hasRenalFailure,
      addictions: state.addictions,
      smokerOrAlcoholic: state.smokerOrAlcoholic,
      pregnant: state.pregnant,
    );
    context.read<PatientBloc>().add(AddPatient(patient));
  }

  void _updatePatient(BuildContext context) {
    if (widget.patient != null) {
      final state =
          context.read<PatientFormBloc>().state as PatientFormValuesState;
      if (state.fullNameError != null ||
          state.ageError != null ||
          state.heightError != null ||
          state.weightError != null) {
        return;
      }
      final patient = PatientDTO(
        fullname: _fullnameController.text,
        jmbg: widget.jmbg,
        age: int.parse(_ageController.text),
        height: double.parse(_heightController.text),
        weight: double.parse(_weightController.text),
        hasDiabetes: state.hasDiabetes,
        hadHearthAttack: state.hadHearthAttack,
        hasHearthFailure: state.hasHearthFailure,
        hasHypertension: state.hasHypertension,
        controlledHypertension: state.controlledHypertension,
        hadStroke: state.hadStroke,
        hasRenalFailure: state.hasRenalFailure,
        addictions: state.addictions,
        smokerOrAlcoholic: state.smokerOrAlcoholic,
        pregnant: state.pregnant,
      );
      context.read<PatientBloc>().add(UpdatePatient(patient));
    }
  }

  @override
  void dispose() {
    _fullnameController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }
}
