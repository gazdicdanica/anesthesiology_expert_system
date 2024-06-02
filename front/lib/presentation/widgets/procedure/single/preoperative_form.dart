import 'package:flutter/material.dart';

class PreoperativeForm extends StatelessWidget {
  const PreoperativeForm({super.key});

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
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "ŠUK",
                            suffix: Text("mmol",
                                style: Theme.of(context).textTheme.labelMedium),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "HbA1c",
                            suffix: Text("%",
                                style: Theme.of(context).textTheme.labelMedium),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Kreatinin",
                            suffix: Text("mg/dl",
                                style: Theme.of(context).textTheme.labelMedium),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "SAP",
                            suffix: Text("mmHg",
                                style: Theme.of(context).textTheme.labelMedium),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Sačuvaj'),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ]);
  }
}
