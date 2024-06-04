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
import 'package:front/theme.dart';

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
    print(procedure);
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
                BlocProvider.of<PatientBloc>(context).add(ResetForm());
                BlocProvider.of<ProcedureBloc>(context)
                    .add(const CloseProcedure());
              }
              if (state is ProcedurePatientSuccess) {
                if(state.procedure != null && state.procedure!.preOperative.bnpValue != 0.0){
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showMessageDialog(
                      context,
                      'Rezultati',
                      patient.hasHearthFailure ? 'Testom je utvrdjeno da pacijent ima srčanu insuficijenciju. Dati odgovarajuću terapiju.' : 'Testom je utvrdjeno da pacijent nema srčanu insuficijenciju. Nastaviti sa predviđenom terapijom radi stabilizovanja zdravstvenog stanja.',
                    );
                  });
                }
                else if (state.procedure != null && !state.procedure!.preOperative.shouldContinueProcedure) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showMessageDialog(
                      context,
                      'Odložite operaciju',
                      procedure.preOperative.postponeReason ??
                          'Potrebno je odložiti operaciju.',
                    );
                  });
                }
              }
            },
            builder: (context, state) {
              if (state is ProcedureSingleLoading) {
                return const LoadingWidget();
              }
              if (state is UpdateAndSuccess) {
                patient = state.patient;
                if (state.procedure != null && state.procedure!.id == procedure.id) {
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
                              PatientInfo(
                                patient: patient,
                                expansionController: expansionController,
                              ),
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

                              if (patient.risk != null &&
                                  procedure
                                      .preOperative.shouldContinueProcedure &&
                                  procedure.preOperative.SIB != 0.0)
                                Container(
                                  padding: const EdgeInsets.only(top: 20),
                                  width: double.infinity,
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: ElevatedButton.icon(
                                      onPressed: () {},
                                      icon: const Icon(Icons.arrow_back),
                                      label: const Text('Dalje'),
                                    ),
                                  ),
                                )
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

  void showMessageDialog(BuildContext context, String title, String content) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: seedColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          content,
          style: const TextStyle(
            fontSize: 16,
            color: textColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: seedColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            ),
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

  void _openInfo() {
    try{
      expansionController.expand();
    }
    catch(e){
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
