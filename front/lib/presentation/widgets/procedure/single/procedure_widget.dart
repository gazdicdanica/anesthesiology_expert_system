import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/bloc/patient_bloc/patient_bloc.dart';
import 'package:front/bloc/procedure_bloc/procedure_bloc.dart';
import 'package:front/bloc/procedure_single_bloc/procedure_single_bloc.dart';
import 'package:front/models/patient.dart';
import 'package:front/models/procedure.dart';
import 'package:front/presentation/widgets/loading_widget.dart';
import 'package:front/presentation/widgets/procedure/risk_and_urgency.dart';
import 'package:front/presentation/widgets/procedure/single/patient_info.dart';
import 'package:front/presentation/widgets/procedure/single/preoperative_form.dart';

class ProcedureWidget extends StatefulWidget {
  const ProcedureWidget({super.key, required this.procedure});

  final Procedure procedure;

  @override
  State<ProcedureWidget> createState() => _ProcedureWidgetState();
}

class _ProcedureWidgetState extends State<ProcedureWidget> {
  late Patient patient;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<ProcedureSingleBloc>(context)
        .add(FetchProcedurePatient(widget.procedure.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            BlocProvider.of<PatientBloc>(context).add(ResetForm());
            BlocProvider.of<ProcedureBloc>(context).add(const CloseProcedure());
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: BlocBuilder<ProcedureSingleBloc, ProcedureSingleState>(
            builder: (context, state) {
              if (state is ProcedureSingleLoading) {
                return const LoadingWidget();
              }
              if (state is ProcedurePatientSuccess) {
                patient = state.patient;
                return CustomScrollView(slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            PatientInfo(patient: patient),
                            const SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      widget.procedure.name,
                                      style:
                                          Theme.of(context).textTheme.titleMedium,
                                    ),
                                  ),
                                  RiskUrgency(procedure: widget.procedure),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            // const Divider(),
                            const PreoperativeForm(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]);
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
