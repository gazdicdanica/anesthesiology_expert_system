import 'package:flutter/material.dart';
import 'package:front/models/procedure.dart';

class PostOperativeWidget extends StatelessWidget {
  const PostOperativeWidget({super.key, required this.procedure});

  final Procedure procedure;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        'Postoperativni oporavak',
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: 20,
            ),
      ),
      childrenPadding: const EdgeInsets.symmetric(horizontal: 10),
      children: [
        const SizedBox(height: 10),
      ],
    );
  }
}
