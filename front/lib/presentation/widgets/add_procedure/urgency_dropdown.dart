import 'package:flutter/material.dart';
import 'package:front/models/procedure.dart';

class UrgencyDropdown extends StatefulWidget {
  const UrgencyDropdown(
      {super.key,
      required this.selectUrgency,
      this.error,
      required this.validate});

  final void Function(ProcedureUrgency?) selectUrgency;
  final void Function(BuildContext context) validate;
  final String? error;

  @override
  State<UrgencyDropdown> createState() => _UrgencyDropdownState();
}

class _UrgencyDropdownState extends State<UrgencyDropdown> {

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<ProcedureUrgency>(
      width: MediaQuery.of(context).size.width - 50,
      inputDecorationTheme: const InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIconColor: Colors.blue,
      ),
      errorText: widget.error,
      label: const Text('Hitnost operacije'),
      leadingIcon: const Icon(Icons.access_time),
      onSelected: (value) {
        widget.selectUrgency(value);
        widget.validate(context);
      },
      hintText: 'Izaberite hitnost',
      textStyle: Theme.of(context).textTheme.bodyLarge,
      dropdownMenuEntries: const [
        DropdownMenuEntry(
          value: ProcedureUrgency.ELECTIVE,
          label: 'Elektivna operacija',
        ),
        DropdownMenuEntry(
          value: ProcedureUrgency.TIME_SENSITIVE,
          label: 'Vremenski zavisna operacija',
        ),
        DropdownMenuEntry(
          value: ProcedureUrgency.URGENT,
          label: 'Urgentna operacija',
        ),
        DropdownMenuEntry(
          value: ProcedureUrgency.IMMEDIATE,
          label: 'Neposredna operacija',
        ),
      ],
    );
  }
}
