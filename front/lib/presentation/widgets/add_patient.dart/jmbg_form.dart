import 'package:flutter/material.dart';

class JmbgForm extends StatefulWidget {
  const JmbgForm({super.key});

  @override
  State<JmbgForm> createState() => _JmbgFormState();
}

class _JmbgFormState extends State<JmbgForm> {

  final _formKey = GlobalKey<FormState>();
  final _jmbgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Unesite JMBG pacijenta',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _jmbgController,
                            decoration: const InputDecoration(
                              labelText: 'JMBG',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 25.0, left: 25.0, right: 25.0),
                  width: double.infinity,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: ElevatedButton.icon(
                      onPressed: () {
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Dalje'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _jmbgController.dispose();
    super.dispose();
  }
}
