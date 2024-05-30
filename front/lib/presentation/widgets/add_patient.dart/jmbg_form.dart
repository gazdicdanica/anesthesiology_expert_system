import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/bloc/patient_bloc/patient_bloc.dart';
import 'package:front/theme.dart';

class JmbgForm extends StatefulWidget {
  const JmbgForm({super.key, required this.setJmbg, this.jmbg});

  final void Function(String) setJmbg;
  final String? jmbg;

  @override
  State<JmbgForm> createState() => _JmbgFormState();
}

class _JmbgFormState extends State<JmbgForm> {
  final _formKey = GlobalKey<FormState>();
  final _jmbgController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _jmbgController.text = widget.jmbg ?? '';
  }

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
                          BlocBuilder<PatientBloc, PatientState>(
                            builder: (context, state) {
                              return TextFormField(
                                controller: _jmbgController,
                                decoration: InputDecoration(
                                  labelText: 'JMBG',
                                  prefixIcon: const Icon(Icons.contact_page, color: seedColor,),
                                  errorText: (state is PatientJmbgValidationFailure)
                                      ? state.error
                                      : null,
                                  suffixIcon: (state is PatientJmbgValidationFailure)
                                      ? const Icon(Icons.error, color: Colors.red)
                                      : null,
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: (value) => _validate(context),
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      bottom: 25.0, left: 25.0, right: 25.0),
                  width: double.infinity,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _validate(context);
                        _fetchPatient(context);
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

  void _validate(BuildContext context) {
    BlocProvider.of<PatientBloc>(context).add(
      ValidateJmbg(
        _jmbgController.text.trim(),
      ),
    );
  }

  void _fetchPatient(BuildContext context) {
    final state = context.read<PatientBloc>().state;
    if (state is PatientValidationSuccess) {
      widget.setJmbg(_jmbgController.text.trim());
      BlocProvider.of<PatientBloc>(context).add(
        FetchPatient(
          _jmbgController.text.trim(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _jmbgController.dispose();
    super.dispose();
  }
}
