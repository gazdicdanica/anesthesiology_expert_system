import 'package:flutter/material.dart';
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
  late Procedure procedure;

  final expansionController = ExpansionTileController();

  @override
  void initState() {
    super.initState();

    BlocProvider.of<ProcedureSingleBloc>(context)
        .add(FetchProcedurePatient(widget.procedure.id));

    procedure = widget.procedure;
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
          child: BlocConsumer<ProcedureSingleBloc, ProcedureSingleState>(
            listener: (context, state) {
              if (state is ProcedureSingleError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is ProcedureSingleLoading) {
                return const LoadingWidget();
              }
              if (state is UpdateAndSuccess) {
                patient = state.patient;
                if (state.procedure != null) {
                  procedure = state.procedure!;
                  _openInfo();
                }

                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: [
                              PatientInfo(patient: patient, expansionController: expansionController,),
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        procedure.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    ),
                                    RiskUrgency(procedure: procedure),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              // const Divider(),
                              PreoperativeForm(
                                procedure: procedure,
                                patient: patient,
                              ),

                              // if(state.procedure?. )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }

              // return const SizedBox();
              return const LoadingWidget();
            },
          ),
        ),
      ),
    );
  }

  void _openInfo(){
    expansionController.expand();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
