import 'package:flutter/material.dart';
import 'package:front/models/patient.dart';
import 'package:front/presentation/widgets/procedure/single/chip.dart';
import 'package:front/theme.dart';

class PatientInfo extends StatefulWidget {
  const PatientInfo(
      {super.key, required this.patient, required this.expansionController});

  final Patient patient;
  final ExpansionTileController expansionController;

  @override
  State<PatientInfo> createState() => _PatientInfoState();
}

class _PatientInfoState extends State<PatientInfo> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ExpansionTile(
        controller: widget.expansionController,
        onExpansionChanged: (value) => setState(() {
          isExpanded = value;
        }),
        title: Text(
          "Informacije o pacijentu",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 20,
                color: isExpanded ? seedColor : textColor,
              ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      widget.patient.fullname,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: textColor),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'JMBG ',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      widget.patient.jmbg,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold, color: textColor),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Godine ',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          widget.patient.age.toString(),
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'BMI',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          widget.patient.BMI.toStringAsFixed(2),
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    if (widget.patient.asa != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ASA',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            'ASA ${widget.patient.asa.toString().split(".")[1]}',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: textColor,
                                    ),
                          ),
                        ],
                      ),
                    const SizedBox(width: 50),
                    if (widget.patient.risk != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Stepen rizika',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            getRiskString(widget.patient.risk!),
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: textColor,
                                    ),
                          ),
                        ],
                      ),
                  ],
                ),
                if (_showFirstDivider())
                  const Column(children: [
                    Divider(),
                    SizedBox(height: 8),
                  ]),
                Wrap(
                  // crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.spaceBetween,
                  spacing: 20,
                  runSpacing: 10,
                  runAlignment: WrapAlignment.spaceEvenly,
                  children: [
                    if (widget.patient.hasDiabetes)
                      const CustomChip(label: 'Dijabetes'),
                    if (widget.patient.hasDiabetes &&
                        widget.patient.isDMControlled)
                      const CustomChip(label: 'Kontrolisani dijabetes'),
                    if (widget.patient.hasHypertension)
                      const CustomChip(label: 'Hipertenzija'),
                    if (widget.patient.hasHypertension &&
                        widget.patient.controlledHypertension)
                      const CustomChip(label: 'Kontrolisana hipertenzija'),
                    if (widget.patient.hadHearthAttack)
                      const CustomChip(label: 'Infarkt miokarda'),
                    if (widget.patient.hasHearthFailure)
                      const CustomChip(label: 'Srčana insuficijencija'),
                    if (widget.patient.hadStroke)
                      const CustomChip(label: 'Moždani udar'),
                    if (widget.patient.hasRenalFailure)
                      const CustomChip(label: 'Bubrežna insuficijencija'),
                  ],
                ),
                if (_showSecondDivider())
                  const Column(children: [
                    SizedBox(height: 8),
                    Divider(),
                    SizedBox(height: 8),
                  ]),
                Wrap(
                  children: [
                    if (widget.patient.pregnant)
                      const CustomChip(label: 'Trudnoća'),
                    if (widget.patient.smokerOrAlcoholic)
                      const CustomChip(label: 'Pušač/alkoholičar'),
                    if (widget.patient.addictions)
                      const CustomChip(label: 'Zavisnosti'),
                    if(widget.patient.hasCVSFamilyHistory)
                      const CustomChip(label: 'Porodična istorija KVS bolesti')
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _showFirstDivider() {
    if (widget.patient.hasDiabetes ||
        (widget.patient.hasDiabetes && widget.patient.isDMControlled) ||
        widget.patient.hasHypertension ||
        (widget.patient.hasHypertension &&
            widget.patient.controlledHypertension) ||
        widget.patient.hadHearthAttack ||
        widget.patient.hasHearthFailure ||
        widget.patient.hadStroke ||
        widget.patient.hasRenalFailure) {
      return true;
    }
    return false;
  }

  bool _showSecondDivider() {
    if (widget.patient.pregnant ||
        widget.patient.smokerOrAlcoholic ||
        widget.patient.addictions ||
        widget.patient.hasCVSFamilyHistory) {
      return true;
    }
    return false;
  }
}
