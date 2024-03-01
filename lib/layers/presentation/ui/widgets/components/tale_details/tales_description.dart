import 'package:flutter/material.dart';
import 'package:proyecto_pasantia/layers/presentation/ui/widgets/components/tale_details/tales_details.dart';

import '../../../../../domain/entities/tales/tales_exports.dart';

class TaleDescription extends StatelessWidget {
  final List<Gender> taleGenders;
  final String abstract;
  const TaleDescription(
      {super.key, required this.abstract, required this.taleGenders});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme.titleMedium;
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.65,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DetailsActions(),
            const SizedBox(
              height: 20,
            ),
            Text("Resumen", style: textStyle),
            const SizedBox(
              height: 10,
            ),
            DetailsText(text: abstract),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Géneros',
              style: textStyle,
            ),
            const SizedBox(
              height: 10,
            ),
            DetailsGenders(taleGenders: taleGenders),
          ],
        ),
      ),
    );
  }
}
