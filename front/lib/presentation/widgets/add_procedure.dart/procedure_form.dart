import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/bloc/procedure_bloc/procedure_bloc.dart';
import 'package:front/data/procedure/repository/procedure_repository.dart';
import 'package:front/models/patient.dart';
import 'package:front/models/procedure.dart';
import 'package:front/presentation/widgets/add_procedure.dart/risk_dropdown.dart';
import 'package:front/presentation/widgets/add_procedure.dart/urgency_dropdown.dart';
import 'package:front/theme.dart';

class ProcedureForm extends StatefulWidget {
  const ProcedureForm({super.key, required this.patient});

  final Patient patient;

  @override
  State<ProcedureForm> createState() => _ProcedureFormState();
}

class _ProcedureFormState extends State<ProcedureForm> {
  OperationRisk? selectedRisk;
  ProcedureUrgency? selectedUrgency;

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: BlocConsumer<ProcedureBloc, ProcedureState>(
                    listener: (context, state) {
                      if (state is ProcedureSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Operacija uspešno dodata.'),
                            backgroundColor: snackBarColor,
                          ),
                        );
                      } else if (state is ProcedureError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    
                    },
                    builder: (context, state) {
                      return Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Unesite podatke o operaciji',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          const SizedBox(height: 20),
                          UrgencyDropdown(
                            validate: _validate,
                            selectUrgency: _selectUrgency,
                            error: state is ProcedureFormValuesState
                                ? state.urgencyError
                                : null,
                          ),
                          const SizedBox(height: 30),
                          RiskDropdown(
                            validate: _validate,
                            selectRisk: _selectRisk,
                            error: state is ProcedureFormValuesState
                                ? state.riskError
                                : null,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // _validate(context);
                    _addProcedure(context);
                  },
                  child: const Text('Sačuvaj'),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _selectUrgency(ProcedureUrgency? urgency) {
    selectedUrgency = urgency;
  }

  void _selectRisk(OperationRisk? risk) {
    selectedRisk = risk;
  }

  void _validate(BuildContext context){
    
    // BlocProvider.of<ProcedureBloc>(context).add(
    //   ValidateProcedureForm(
    //     selectedUrgency,
    //     selectedRisk,
    //   ),
    // );
  }

  void _addProcedure(BuildContext context) {
    context.read<ProcedureBloc>().add(AddProcedure(widget.patient.id, selectedUrgency!, selectedRisk!));
    
  }
}
