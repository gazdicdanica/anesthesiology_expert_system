import 'package:flutter/material.dart';
import 'package:front/theme.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: snackBarColor,
        // borderRadius: BorderRadius.circular(),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: Colors.white,
        )
      ),
    );
  }

}