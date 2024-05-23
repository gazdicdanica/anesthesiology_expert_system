import 'package:flutter/material.dart';
import 'package:front/models/user.dart';

class RoleSelect extends StatefulWidget {
  const RoleSelect({super.key});

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
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.medical_information_outlined),
        prefixIconColor: Colors.blue, // Adjust the color as needed
        labelText: 'Tip licence',
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      ),
      value: _selectedLicense,
      items: const [
        DropdownMenuItem(
          value: Role.nurse,
          child: Text('Medicinski tehničar'),
        ),
        DropdownMenuItem(
          value: Role.doctor,
          child: Text('Lekar',),
        ),
      ],
      onChanged: (value) {
        setState(() {
          _selectedLicense = value!;
        });
      },
      hint: const Text('Izaberi tip licence',
      ),
    );
  }
}
