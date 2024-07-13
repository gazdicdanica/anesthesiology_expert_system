import 'package:flutter/material.dart';
import 'package:front/models/procedure.dart';

class RiskDropdown extends StatefulWidget {
  const RiskDropdown({
    super.key,
    required this.selectRisk,
    required this.validate,
    this.error,
  });

  final void Function(OperationRisk?) selectRisk;
  final void Function(BuildContext context) validate;
  final String? error;

  @override
  State<RiskDropdown> createState() => _RiskDropdownState();
}

class _RiskDropdownState extends State<RiskDropdown> {

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<OperationRisk>(
      width: MediaQuery.of(context).size.width - 50,

      inputDecorationTheme: const InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIconColor: Colors.blue,
      ),
      errorText: widget.error,
      label: const Text('Operativni rizik'),
      leadingIcon: const Icon(Icons.priority_high),

       onSelected: (value) {
        widget.selectRisk(value);
        widget.validate(context);
      },
      hintText: 'Izaberite operativni rizik',
      textStyle: Theme.of(context).textTheme.bodyLarge,
      dropdownMenuEntries: const [
        DropdownMenuEntry(value: OperationRisk.LOW, label: 'Nizak'),
        DropdownMenuEntry(value: OperationRisk.MEDIUM, label: 'Srednji'),
        DropdownMenuEntry(value: OperationRisk.HIGH, label: 'Visok'),
      ],
    );
  }
}
