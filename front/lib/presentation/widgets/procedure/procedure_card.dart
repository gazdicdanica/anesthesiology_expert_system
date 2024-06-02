import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/bloc/procedure_bloc/procedure_bloc.dart';
import 'package:front/models/procedure.dart';
import 'package:front/theme.dart';

class ProcedureCard extends StatelessWidget {
  const ProcedureCard({super.key, required this.procedure});

  final Procedure procedure;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.read<ProcedureBloc>().add(OpenProcedure(procedure)),
      borderRadius: BorderRadius.circular(10),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                procedure.name,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    color: seedColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Operativni rizik: ",
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
                    "Urgentnost: ",
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
            ],
          ),
        ),
      ),
    );
  }

}
