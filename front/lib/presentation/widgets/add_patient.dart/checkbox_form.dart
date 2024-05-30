import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/bloc/patient_form_bloc/patient_form_bloc.dart';

class CheckboxForm extends StatelessWidget {
  const CheckboxForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientFormBloc, PatientFormState>(
      builder: (context, state) {
        return Column(
          children: [
            const SizedBox(height: 10),
            CheckboxListTile(
              title: const Text('Trudnoća'),
              value: (state
                      as PatientFormValuesState)
                  .pregnant,
              onChanged: (bool? value) {
                context
                    .read<PatientFormBloc>()
                    .add(ToggleCheckbox(field: 'pregnant', value: value!));
              },
            ),
            CheckboxListTile(
              title: const Text('Pušač ili alkoholičar'),
              subtitle: const Text('aktivni'),
              value: state.smokerOrAlcoholic,
              onChanged: (bool? value) {
                context
                    .read<PatientFormBloc>()
                    .add(ToggleCheckbox(field: 'smokerOrAlcoholic', value: value!));
              },
            ),
            CheckboxListTile(
              title: const Text('Zavisnost'),
              subtitle: const Text('narkotici, alkohol'),
              value: state.addictions,
              onChanged: (bool? value) {
                context
                    .read<PatientFormBloc>()
                    .add(ToggleCheckbox(field: 'addictions', value: value!));
              },
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            CheckboxListTile(
              title: const Text('Dijabetes'),
              value: state.hasDiabetes,
              onChanged: (bool? value) {
                context
                    .read<PatientFormBloc>()
                    .add(ToggleCheckbox(field: 'hasDiabetes', value: value!));
              },
            ),
            CheckboxListTile(
              title: const Text('Hipertenzija'),
              value: state.hasHypertension,
              onChanged: (bool? value) {
                context
                    .read<PatientFormBloc>()
                    .add(ToggleCheckbox(field: 'hasHypertension', value: value!));
              },
            ),
            if(state.hasHypertension)
              CheckboxListTile(
                title: const Text('Kontrolisana hipertenzija'),
                value: state.controlledHypertension,
                onChanged: (bool? value) {
                  context
                      .read<PatientFormBloc>()
                      .add(ToggleCheckbox(field: 'controlledHypertension', value: value!));
                },
              ),
            CheckboxListTile(
              title: const Text('Infarkt miokarda'),
              value: state.hadHeartAttack,
              onChanged: (bool? value) {
                context
                    .read<PatientFormBloc>()
                    .add(ToggleCheckbox(field: 'hadHeartAttack', value: value!));
              },
            ),
            CheckboxListTile(
              title: const Text('Srčana insuficijencija'),
              value: state.hasHeartFailure,
              onChanged: (bool? value) {
                context
                    .read<PatientFormBloc>()
                    .add(ToggleCheckbox(field: 'hasHeartFailure', value: value!));
              },
            ),
            CheckboxListTile(
              title: const Text('Moždani udar'),
              value: state.hadStroke,
              onChanged: (bool? value) {
                context
                    .read<PatientFormBloc>()
                    .add(ToggleCheckbox(field: 'hadStroke', value: value!));
              },
            ),
            CheckboxListTile(
              title: const Text('Bubrežna insuficijencija'),
              value: state.hasRenalFailure,
              onChanged: (bool? value) {
                context
                    .read<PatientFormBloc>()
                    .add(ToggleCheckbox(field: 'hasRenalFailure', value: value!));
              },
            ),
          ],
        );
      },
    );
  }
}
