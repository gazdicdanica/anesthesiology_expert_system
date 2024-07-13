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

  Future<void> getRoleText() async {
    String? role = await _sharedPrefRepository.getRole();
    if (role == "DOCTOR") {
      setState(() {
        roleText = "Medicinski tehničar";
      });
    } else {
      setState(() {
        roleText = "Doktor";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StaffBloc, StaffState>(
      builder: (context, state) {
        if (state is StaffLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is StaffSuccess) {

          return DropdownMenu<User>(
              width: MediaQuery.of(context).size.width -50,
              inputDecorationTheme: const InputDecorationTheme(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                prefixIconColor: Colors.blue,
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                
              ),
              label: Text(roleText),
              enableFilter: true,
              requestFocusOnTap: true,
              onSelected: (value) => widget.selectStaff(value),
              // width: double.infinity,
              hintText: "Izaberite osoblje",
              textStyle: Theme.of(context).textTheme.bodyLarge,
              leadingIcon: const Icon(Icons.medical_services),
                dropdownMenuEntries: state.staff.map<DropdownMenuEntry<User>>(
              (User user) {
                return DropdownMenuEntry(value: user, label: user.fullname, );
              },
            ).toList());
          
        } else {
          return Container();
        }
      },
    );
  }
}
