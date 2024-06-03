import 'package:flutter/material.dart';
import 'package:front/models/procedure.dart';
import 'package:front/theme.dart';

class RiskUrgency extends StatelessWidget {
  const RiskUrgency({super.key, required this.procedure});

  final Procedure procedure;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 8),
      Row(
        children: [
          const Icon(
            Icons.access_time,
            color: seedColor,
          ),
          const SizedBox(width: 8),
          Text(
            "Operativni rizik  ",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            getRiskString(procedure.risk),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: snackBarColor,
                ),
          ),
        ],
      ),
      const SizedBox(height: 8),
      Row(
        children: [
          const Icon(Icons.priority_high, color: seedColor),
          const SizedBox(width: 8),
          Text(
            "Urgentnost  ",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            getUrgencyString(procedure.urgency),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: seedColor,
                ),
          ),
        ],
      ),
    ]);
  }
}
