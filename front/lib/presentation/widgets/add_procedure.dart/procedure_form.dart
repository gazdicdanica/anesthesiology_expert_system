import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/data/procedure/repository/procedure_repository.dart';
import 'package:front/models/patient.dart';
import 'package:front/models/procedure.dart';
import 'package:front/presentation/widgets/add_procedure.dart/risk_dropdown.dart';
import 'package:front/presentation/widgets/add_procedure.dart/urgency_dropdown.dart';

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
  Widget build(BuildContext context) {
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
                  child: Column(
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
                        selectUrgency: _selectUrgency,
                      ),
                      const SizedBox(height: 30),
                      RiskDropdown(
                        selectRisk: _selectRisk,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
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

  void _addProcedure(BuildContext context) {
    context
        .read<ProcedureRepository>()
        .addProcedure(
          widget.patient.id,
          selectedRisk!,
          selectedUrgency!,
        )
        .then(
          (value) => print(value),
        );
  }
}
