import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/bloc/staff_bloc/staff_bloc.dart';
import 'package:front/data/shared_pref/repository/shared_pref_repository.dart';
import 'package:front/models/user.dart';

class StaffDropdown extends StatefulWidget {
  const StaffDropdown({super.key, required this.selectStaff});

  final void Function(User?) selectStaff;
  @override
  State<StaffDropdown> createState() => _StaffDropdownState();
}

class _StaffDropdownState extends State<StaffDropdown> {
  late SharedPrefRepository _sharedPrefRepository;
  late String roleText;

  @override
  void initState() {
    super.initState();

    context.read<StaffBloc>().add(const FetchStaff());
    _sharedPrefRepository = context.read<SharedPrefRepository>();

    getRoleText();
  }

  getRoleText() async {
    String? role = await _sharedPrefRepository.getRole();
    if (role == "DOCTOR") {
      roleText = "Medicinski tehničar";
    } else {
      roleText = "Doktor";
    }
  }

  @override
  Widget build(BuildContext context) {
    User? selectedStaff;

    return BlocBuilder<StaffBloc, StaffState>(
      builder: (context, state) {
        if (state is StaffLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is StaffSuccess) {
          return DropdownButtonFormField<User>(
              itemHeight: null,
              isExpanded: true,
              style: Theme.of(context).textTheme.bodyLarge,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.medical_services),
                prefixIconColor: Colors.blue,
                labelText: roleText,
                errorText: null,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              ),
              value: selectedStaff,
              hint: const Text("Izaberite osoblje"),
              items: state.staff.map((staff) {
                return DropdownMenuItem(
                  value: staff,
                  child: Text(staff.fullname),
                );
              }).toList(),
              onChanged: (User? value) {
                widget.selectStaff(value);
                setState(() {
                  selectedStaff = value;
                });
              });
        } else {
          return Container();
        }
      },
    );
  }
}
