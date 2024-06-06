import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  @override
  void initState() {
    super.initState();

    if (!widget.isPassword) {
      _controller.text = widget.value!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    children: [
                      TextFormField(
                        obscureText: widget.isPassword,
                        controller: _controller,
                        decoration: InputDecoration(
                          labelText: widget.label,
                          prefixIcon: Icon(
                            widget.icon,
                            color: seedColor,
                          ),
                        ),

                        keyboardType: widget.label.contains("Broj") ? TextInputType.number : TextInputType.text,
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
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(25),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Sačuvaj'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
