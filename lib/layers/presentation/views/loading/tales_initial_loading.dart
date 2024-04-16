import 'package:flutter/material.dart';

class TalesScreenLoader extends StatelessWidget {
  const TalesScreenLoader({super.key});

  Stream<String> getLoadingMessages() {
    final messages = <String>[
      'Cargando cuentos',
      'Preparando el escenario',
      'Cargando etiquetas',
      'Llamando a los protagonistas',
      'Ya mismo...',
      'Esto está tardando más de lo esperado...',
      'Aún estás aquí?'
    ];

    return Stream.periodic(const Duration(milliseconds: 3000), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Espere por favor'),
          const SizedBox(height: 10),
          const CircularProgressIndicator(strokeWidth: 2),
          const SizedBox(height: 10),
          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('Cargando...');

              return Text(snapshot.data!);
            },
          ),
        ],
      ),
    );
  }
}
