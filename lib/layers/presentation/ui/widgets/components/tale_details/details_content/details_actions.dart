import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:proyecto_pasantia/config/configurations.dart';

import '../../../../../../aplication/providers/providers.dart';

class DetailsActions extends ConsumerWidget {
  const DetailsActions({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final buttonStyle = ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.blue.shade100),
      foregroundColor: MaterialStateColor.resolveWith((states) => Colors.black),
    );
    return Row(
      children: [
        TextButton.icon(
          onPressed: () => ref
              .read(routerProvider)
              .router
              .pushNamed(AppRoutes.readerView, pathParameters: {
            'taleId': ref.read(actualTaleProvider.notifier).state
          }),
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
