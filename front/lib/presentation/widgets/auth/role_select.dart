import 'package:flutter/material.dart';
import 'package:front/models/user.dart';

class RoleSelect extends StatefulWidget {
  const RoleSelect({super.key, required this.selectRole, this.error, required this.validate});

  final void Function(Role? role) selectRole;
  final void Function() validate;
  final String? error;

  @override
  State<RoleSelect> createState() => RoleSelectState();
}

class RoleSelectState extends State<RoleSelect> {
  Role? _selectedLicense;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Role>(
      style: Theme.of(context).textTheme.bodyLarge,
      isExpanded: true,
      isDense: true,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.medical_information_outlined),
        prefixIconColor: Colors.blue, 
        labelText: 'Tip licence',
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        errorText: widget.error,
      ),
      value: _selectedLicense,
      items: const [
        DropdownMenuItem(
          value: Role.NURSE,
          child: Text('Medicinski tehničar'),
        ),
        DropdownMenuItem(
          value: Role.DOCTOR,
          child: Text('Lekar',),
        ),
      ],
      onChanged: (value) {
        widget.selectRole(value);
        widget.validate();
        setState(() {
          _selectedLicense = value!;
        });
      },
      hint: const Text('Izaberi tip licence',
      ),
    );
  }
}
