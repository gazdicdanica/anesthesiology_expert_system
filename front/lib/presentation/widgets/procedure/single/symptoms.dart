import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/bloc/procedure_single_bloc/procedure_single_bloc.dart';
import 'package:front/models/alarm.dart';
import 'package:front/models/procedure.dart';

class Symptoms extends StatefulWidget {
  const Symptoms({super.key, required this.procedure});

  final Procedure procedure;

  @override
  State<Symptoms> createState() => _SymptomsState();
}

class _SymptomsState extends State<Symptoms> {
  late Procedure procedure;

  bool dyspnea = false;
  bool wheezing = false;
  bool fever = false;
  bool absentBreathSounds = false;
  bool pulmonaryEdema = false;
  bool chestPain = false;
  bool arythmia = false;

  @override
  void initState() {
    super.initState();
    procedure = widget.procedure;

    _updateValues();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProcedureSingleBloc, ProcedureSingleState>(
      builder: (context, state) {
        if (state is UpdateAndSuccess) {
          if(state.procedure != null){
            procedure = state.procedure!;
            Future.microtask(() => _updateValues());
          }
          return Column(children: [
            CheckboxListTile(
              title: const Text('Dyspnoea'),
              subtitle: const Text('Plitko disanje'),
              value: dyspnea,
              enabled: !hasSymptom(Symptom.Dyspnea),
              onChanged: (bool? value) {
                setState(() {
                  dyspnea = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Zviždanje u grudima'),
              value: wheezing,
              enabled: !hasSymptom(Symptom.Wheezing),
              onChanged: (bool? value) {
                setState(() {
                  wheezing = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Temperatura'),
              value: fever,
              enabled: !hasSymptom(Symptom.Fever),
              onChanged: (bool? value) {
                setState(() {
                  fever = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Nečujno disanje'),
              value: absentBreathSounds,
              enabled: !hasSymptom(Symptom.AbsentBreathSounds),
              onChanged: (bool? value) {
                setState(() {
                  absentBreathSounds = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Plućni edem'),
              value: pulmonaryEdema,
              enabled: !hasSymptom(Symptom.PulmonaryEdema),
              onChanged: (bool? value) {
                setState(() {
                  pulmonaryEdema = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Bol u grudima'),
              value: chestPain,
              enabled: !hasSymptom(Symptom.ChestPain),
              onChanged: (bool? value) {
                setState(() {
                  chestPain = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Aritmije'),
              value: arythmia,
              enabled: !hasSymptom(Symptom.Arythmia),
              onChanged: (bool? value) {
                setState(() {
                  arythmia = value!;
                });
              },
            ),
            if(!procedure.postOperative!.isReleased)
              Container(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: state is ProcedureUpdateLoading
                      ? () {}
                      : () {
                          _diagnosis();
                        },
                  child: state is ProcedureDiagnosisLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text('Dijagnoza'),
                ),
              )
          ]);
        }
        return const SizedBox();
      },
    );
  }

  bool hasSymptom(Symptom symptom) => procedure.postOperative!.alarms
          .any((a) => a.symptom == symptom);

  void _updateValues() {
    setState(() {
      dyspnea = hasSymptom(Symptom.Dyspnea) || dyspnea;
      wheezing = hasSymptom(Symptom.Wheezing) || wheezing;
      fever = hasSymptom(Symptom.Fever) || fever;
      absentBreathSounds = hasSymptom(Symptom.AbsentBreathSounds) || absentBreathSounds;
      pulmonaryEdema = hasSymptom(Symptom.PulmonaryEdema) || pulmonaryEdema;
      chestPain = hasSymptom(Symptom.ChestPain) || chestPain;
      arythmia = hasSymptom(Symptom.Arythmia) || arythmia;
    });
  }


  void _diagnosis(){
    Set<Symptom> symptoms = {};
    if(dyspnea) symptoms.add(Symptom.Dyspnea);
    if(wheezing) symptoms.add(Symptom.Wheezing);
    if(fever) symptoms.add(Symptom.Fever);
    if(absentBreathSounds) symptoms.add(Symptom.AbsentBreathSounds);
    if(pulmonaryEdema) symptoms.add(Symptom.PulmonaryEdema);
    if(chestPain) symptoms.add(Symptom.ChestPain);
    if(arythmia) symptoms.add(Symptom.Arythmia);

    context.read<ProcedureSingleBloc>().add(UpdateSymptoms(symptoms, procedure.id));
  }
}
