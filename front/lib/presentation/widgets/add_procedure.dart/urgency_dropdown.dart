import 'package:flutter/material.dart';
import 'package:front/models/procedure.dart';

class UrgencyDropdown extends StatefulWidget{
  const UrgencyDropdown({super.key, required this.selectUrgency});

  final void Function(ProcedureUrgency?) selectUrgency;

  @override
  State<UrgencyDropdown> createState() => _UrgencyDropdownState();
}

class _UrgencyDropdownState extends State<UrgencyDropdown> {
  ProcedureUrgency? _selectedUrgency;

  @override
  Widget build(BuildContext context) {

    return DropdownButtonFormField<ProcedureUrgency>(
      style: Theme.of(context).textTheme.bodyLarge,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.access_time),
        prefixIconColor: Colors.blue,
        labelText: 'Hitnost operacije',
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        // errorText: widget.error,
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
        // widget.validate();
        setState(() {
          _selectedUrgency = value!;
        });
      },
      hint: const Text('Izaberite hitnost'),
    );
  }
}