import 'package:flutter/material.dart';
import 'package:front/models/procedure.dart';
import 'package:front/theme.dart';

class IntraOperativeWidget extends StatelessWidget {
  const IntraOperativeWidget({super.key, required this.procedure});

  final Procedure procedure;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        'Operacija',
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: 20,
            ),
      ),
      childrenPadding: const EdgeInsets.symmetric(horizontal: 10),
      children: [
        const SizedBox(height: 10),
        Wrap(
          runSpacing: 6.0,
          children: [
            const Icon(
              Icons.monitor_heart,
              color: seedColor,
            ),
            const SizedBox(width: 8),
            Text(
              "Monitoring  ",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              getMonitoringString(procedure.intraOperative!.monitoring),
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: snackBarColor,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
