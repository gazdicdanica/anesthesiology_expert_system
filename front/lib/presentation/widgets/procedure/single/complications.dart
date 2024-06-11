import 'package:flutter/material.dart';
import 'package:front/models/alarm.dart';
import 'package:front/theme.dart';

class Complications extends StatelessWidget {
  const Complications({super.key, required this.alarms});

  final Set<Alarm> alarms;

  @override
  Widget build(BuildContext context) {
    final Map<Symptom, int> symptomCounts = {};
    for (var alarm in alarms) {
      symptomCounts.update(alarm.symptom, (count) => count + 1, ifAbsent: () => 1);
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: 15.0,
        runSpacing: 8.0,
        children: symptomCounts.entries.map((entry) {
          return Text(
            '${getSymptomString(entry.key)} (${entry.value})',
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