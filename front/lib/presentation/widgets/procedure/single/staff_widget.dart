import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/bloc/staff_bloc/staff_bloc.dart';

class StaffWidget extends StatefulWidget {
  const StaffWidget({super.key, required this.procedureId});

  final int procedureId;

  @override
  State<StaffWidget> createState() => _StaffWidgetState();
}

class _StaffWidgetState extends State<StaffWidget> {
  @override
  void initState() {
    super.initState();
    context.read<StaffBloc>().add(FetchProcedureStaff(widget.procedureId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StaffBloc, StaffState>(builder: (context, state) {
      if (state is StaffError) {
        return Center(child: Text(state.message));
      }
      if (state is StaffProcedureSuccess) {
        return Padding(
          padding: const EdgeInsets.only(left: 35.0),
          child: Column(children: [
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  "Lekar  ",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  state.staff["doctor"]?? "N/A",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  "Medicinski tehničar  ",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  state.staff["nurse"]?? "N/A",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ]),
        );
      }
      return const Center(child: CircularProgressIndicator());

    });
  }
}
