import 'package:flutter/material.dart';
import 'package:front/models/alarm.dart';
import 'package:front/theme.dart';

class Complications extends StatelessWidget {
  const Complications({super.key, required this.alarms});

  final Set<Alarm> alarms;

  @override
  Widget build(BuildContext context) {

    final Set<Symptom> symptoms = alarms.map((alarm) => alarm.symptom).toSet();
    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: 20.0,
        runSpacing: 8.0,
        children: symptoms.map((entry) {
          return Text(
            getSymptomString(entry),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: snackBarColor,
            ),
          );
        }).toList(),
      ),
    );
  }

}