import 'package:flutter/material.dart';
import 'package:front/models/procedure.dart';

class UrgencyDropdown extends StatefulWidget{
  const UrgencyDropdown({super.key, required this.selectUrgency, this.error, required this.validate});

  final void Function(ProcedureUrgency?) selectUrgency;
  final void Function(BuildContext context) validate;
  final String? error;

  @override
  State<UrgencyDropdown> createState() => _UrgencyDropdownState();
}

class _UrgencyDropdownState extends State<UrgencyDropdown> {
  ProcedureUrgency? _selectedUrgency;

  @override
  Widget build(BuildContext context) {

    return DropdownButtonFormField<ProcedureUrgency>(
      style: Theme.of(context).textTheme.bodyLarge,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.access_time),
        prefixIconColor: Colors.blue,
        labelText: 'Hitnost operacije',
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        errorText: widget.error,
      ),
      value: _selectedUrgency,
      items: const [
        DropdownMenuItem(
          value: ProcedureUrgency.ELECTIVE,
          child: Text('Elektivna operacija'),
        ),
        DropdownMenuItem(
          value: ProcedureUrgency.TIME_SENSITIVE,
          child: Text('Vremenski zavisna operacija'),
        ),
        DropdownMenuItem(
          value: ProcedureUrgency.IMMEDIATE,
          child: Text('Urgentna operacija'),
        ),
        DropdownMenuItem(
          value: ProcedureUrgency.URGENT,
          child: Text('Neposredna operacija'),
        ),
      ],
      onChanged: (value) {
        widget.selectUrgency(value);
        widget.validate(context);
        setState(() {
          _selectedUrgency = value!;
        });
      },
      hint: const Text('Izaberite hitnost'),
    );
  }
}