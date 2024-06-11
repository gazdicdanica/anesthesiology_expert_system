import 'package:flutter/material.dart';
import 'package:front/presentation/screens/edit_profile_screen.dart';
import 'package:front/theme.dart';

class FieldWidget extends StatelessWidget {
  const FieldWidget(
      {super.key,
      required this.label,
      required this.value,
      required this.icon, required this.isPassword});

  final String label;
  final String value;
  final IconData icon;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push( MaterialPageRoute(builder: (context) =>  EditProfileScreen(icon: icon, label: isPassword ? "Stara lozinka" : label, value: isPassword ? null : value, isPassword: isPassword)));
      },
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: seedColor),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(
                    icon,
                    size: 35,
                    color: seedColor,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: seedColor, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        value,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: textColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
