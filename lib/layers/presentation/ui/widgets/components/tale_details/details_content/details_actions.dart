import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class DetailsActions extends StatelessWidget {
  const DetailsActions({super.key});

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.blue.shade100),
      foregroundColor: MaterialStateColor.resolveWith((states) => Colors.black),
    );
    return Row(
      children: [
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(LineIcons.play),
          style: buttonStyle,
          label: const Text('Iniciar'),
        ),
        const SizedBox(
          width: 5,
        ),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(LineIcons.backward),
          label: const Text('Reiniciar'),
          style: buttonStyle,
        ),
        const SizedBox(
          width: 5,
        ),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(LineIcons.plus),
          label: const Text('Seguir'),
          style: buttonStyle,
        ),
      ],
    );
  }
}
