import 'package:flutter/material.dart';
import 'package:front/models/patient.dart';
import 'package:front/theme.dart';

class PatientInfo extends StatefulWidget {
  const PatientInfo({super.key, required this.patient});

  final Patient patient;

  @override
  State<PatientInfo> createState() => _PatientInfoState();
}

class _PatientInfoState extends State<PatientInfo> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ExpansionTile(
        onExpansionChanged: (value) => setState(() {
          isExpanded = value;
        }),
        title: Text(
          "Informacije o pacijentu",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 20,
                color: isExpanded ? seedColor : textColor,
              ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      widget.patient.fullname,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: textColor),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'JMBG ',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      widget.patient.jmbg,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold, color: textColor),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Godine ',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          widget.patient.age.toString(),
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'BMI',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          widget.patient.BMI.toStringAsFixed(2),
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
