import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/bloc/auth_bloc/auth_bloc.dart';
import 'package:front/presentation/widgets/loading_widget.dart';
import 'package:front/theme.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen(
      {super.key,
      required this.label,
      required this.icon,
      required this.isPassword,
      this.value});

  final String label;
  final IconData icon;
  final String? value;
  final bool isPassword;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _controller = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (!widget.isPassword) {
      _controller.text = widget.value!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
            backgroundColor: Colors.red,
          ));
        } else if (state is UserSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Uspešna izmena naloga'),
            backgroundColor: snackBarColor,
          ));
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {

                    if(state is AuthLoading){
                      return const LoadingWidget();
                    }

                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            children: [
                              TextFormField(
                                obscureText: widget.isPassword,
                                controller: _controller,
                                decoration: InputDecoration(
                                  errorText: state is AuthValidationFailure
                                      ? state.passwordError
                                      : null,
                                  suffixIcon: state is AuthValidationFailure
                                      ? const Icon(Icons.error,
                                          color: Colors.red)
                                      : null,
                                  labelText: widget.label,
                                  prefixIcon: Icon(
                                    widget.icon,
                                    color: seedColor,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Polje je obavezno';
                                  }
                                  if (widget.label.contains('Broj')) {
                                    if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                                      return 'Broj licence nije ispravnog formata';
                                    }
                                  }
                                  return null;
                                },
                                keyboardType: widget.label.contains("Broj")
                                    ? TextInputType.number
                                    : TextInputType.text,
                              ),
                              const SizedBox(height: 20),
                              if (widget.isPassword)
                                Column(
                                  children: [
                                    TextFormField(
                                      obscureText: widget.isPassword,
                                      controller: _passwordController,
                                      decoration: const InputDecoration(
                                        labelText: 'Nova lozinka',
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          color: seedColor,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Polje je obavezno';
                                        } else if (value.length < 6) {
                                          return 'Lozinka mora imati najmanje 6 karaktera';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 20),
                                    TextFormField(
                                      obscureText: widget.isPassword,
                                      decoration: const InputDecoration(
                                        labelText: 'Potvrdite lozinku',
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          color: seedColor,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Polje je obavezno';
                                        } else if (value !=
                                            _passwordController.text) {
                                          return 'Lozinke se ne poklapaju';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(25),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final fullname = widget.label.contains('Ime')
                          ? _controller.text
                          : null;
                      final licenseNumber = widget.label.contains('Broj')
                          ? _controller.text
                          : null;
                      final oldPassword = widget.isPassword
                          ? _controller.text
                          : null;
                      final newPassword = widget.isPassword
                          ? _passwordController.text
                          : null;
                    context.read<AuthBloc>().add(UpdateEvent(fullname, licenseNumber, oldPassword, newPassword));

                    }
                  },
                  child: const Text('Sačuvaj'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
