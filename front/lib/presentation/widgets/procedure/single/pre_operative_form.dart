import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/bloc/procedure_single_bloc/procedure_single_bloc.dart';
import 'package:front/models/patient.dart';
import 'package:front/models/procedure.dart';

class PreoperativeForm extends StatefulWidget {
  const PreoperativeForm(
      {super.key, required this.procedure, required this.patient});

  final Procedure procedure;
  final Patient patient;

  @override
  State<PreoperativeForm> createState() => _PreoperativeFormState();
}

class _PreoperativeFormState extends State<PreoperativeForm> {
  final sibController = TextEditingController();
  final hba1cController = TextEditingController();
  final creatinineController = TextEditingController();
  final sapController = TextEditingController();

  final bnpController = TextEditingController();

  late Procedure procedure;
  late Patient patient;

  @override
  void initState() {
    super.initState();
    procedure = widget.procedure;
    patient = widget.patient;

    if (widget.procedure.preOperative.SIB != 0.0) {
      sibController.text = widget.procedure.preOperative.SIB.toString();
      hba1cController.text = widget.procedure.preOperative.HBA1C.toString();
      creatinineController.text =
          widget.procedure.preOperative.creatinine.toString();
      sapController.text = widget.patient.basalSAP.toString();
    }
    if(widget.procedure.preOperative.bnpValue != 0.0) {
      bnpController.text = widget.procedure.preOperative.bnpValue.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        'Preoperativna priprema',
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: 20,
            ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Form(
            child: BlocBuilder<ProcedureSingleBloc, ProcedureSingleState>(
              builder: (context, state) {
                if (state is ProcedurePatientSuccess) {
                  patient = state.patient;
                  procedure = state.procedure ?? procedure;
                }
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: sibController,
                            keyboardType: TextInputType.number,
                            enabled: procedure.preOperative.SIB == 0.0,
                            decoration: InputDecoration(
                              labelText: "ŠUK",
                              suffix: Text("mmol",
                                  style:
                                      Theme.of(context).textTheme.labelMedium),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: hba1cController,
                            keyboardType: TextInputType.number,
                            enabled: procedure.preOperative.HBA1C == 0.0,
                            decoration: InputDecoration(
                              labelText: "HbA1c",
                              suffix: Text("%",
                                  style:
                                      Theme.of(context).textTheme.labelMedium),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: creatinineController,
                            keyboardType: TextInputType.number,
                            enabled: procedure.preOperative.creatinine == 0.0,
                            decoration: InputDecoration(
                              labelText: "Kreatinin",
                              suffix: Text("mg/dl",
                                  style:
                                      Theme.of(context).textTheme.labelMedium),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: sapController,
                            keyboardType: TextInputType.number,
                            enabled: procedure.preOperative.creatinine == 0.0,
                            decoration: InputDecoration(
                              labelText: "SAP",
                              suffix: Text("mmHg",
                                  style:
                                      Theme.of(context).textTheme.labelMedium),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (!procedure.preOperative.doBnp && procedure.preOperative.bnpValue == 0.0)
                      const SizedBox(height: 30),
                    if (procedure.preOperative.SIB == 0.0)
                      Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: state is ProcedureUpdateLoading
                                  ? () {}
                                  : () {
                                      _update(context);
                                    },
                              child: state is ProcedureUpdateLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text('Sačuvaj'),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    if (procedure.preOperative.doBnp || procedure.preOperative.bnpValue != 0.0)
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: bnpController,
                                  enabled:
                                      procedure.preOperative.bnpValue == 0.0,
                                  decoration: InputDecoration(
                                    labelText: "BNP",
                                    suffix: Text("pg/ml",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Expanded(child: SizedBox()),
                            ],
                          ),
                          const SizedBox(height: 30),
                          if (procedure.preOperative.bnpValue == 0.0)
                            Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: state is ProcedureUpdateLoading
                                        ? () {}
                                        : () {
                                            _updateBnp(context);
                                          },
                                    child: state is ProcedureUpdateLoading
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : const Text('Sačuvaj'),
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                        ],
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void _update(BuildContext context) {
    final sib = double.tryParse(sibController.text.trim());
    final hba1C = double.tryParse(hba1cController.text.trim());
    final creatinine = double.tryParse(creatinineController.text.trim());
    final sap = int.tryParse(sapController.text.trim());
    context
        .read<ProcedureSingleBloc>()
        .add(UpdatePreoperative(sib!, hba1C!, creatinine!, sap!, procedure.id));
  }

  void _updateBnp(BuildContext context) {
    final bnp = double.tryParse(bnpController.text.trim());
    context.read<ProcedureSingleBloc>().add(UpdateBnp(bnp!, procedure.id));
  }

  @override
  void dispose() {
    sibController.dispose();
    hba1cController.dispose();
    creatinineController.dispose();
    sapController.dispose();
    super.dispose();
  }
}
