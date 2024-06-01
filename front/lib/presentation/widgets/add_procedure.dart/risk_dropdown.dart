import 'package:flutter/material.dart';
import 'package:front/models/procedure.dart';

class RiskDropdown extends StatefulWidget {
  const RiskDropdown({super.key, required this.selectRisk});

  final void Function(OperationRisk?) selectRisk;

  @override
  State<RiskDropdown> createState() => _RiskDropdownState();
}

class _RiskDropdownState extends State<RiskDropdown> {
  OperationRisk? _selectedRisk;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<OperationRisk>(
      style: Theme.of(context).textTheme.bodyLarge,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.error_outline),
        prefixIconColor: Colors.blue,
        labelText: 'Operativni rizik',
        contentPadding:
            EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        // errorText: widget.error,
      ),
      value: _selectedRisk,
      items: const [
        DropdownMenuItem(
          value: OperationRisk.LOW,
          child: Text('Nizak'),
        ),
        DropdownMenuItem(
          value: OperationRisk.MEDIUM,
          child: Text('Srednji'),
        ),
        DropdownMenuItem(
          value: OperationRisk.HIGH,
          child: Text('Visok'),
        ),
      ],
      onChanged: (value) {
        widget.selectRisk(value);
        // widget.validate();
        setState(() {
          _selectedRisk = value!;
        });
      },
      hint: const Text('Izaberite operativni rizik'),
    );
  }
}
