import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../../../domain/entities/tales/tales_exports.dart';
import 'tales_details.dart';

class TaleDescription extends StatelessWidget {
  final List<Gender> taleGenders;
  final String abstract;
  final String imageUrl;
  final String title;

  const TaleDescription({
    super.key,
    required this.abstract,
    required this.taleGenders,
    required this.imageUrl,
    required this.title,
  });

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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildButton(
                    icon: Icons.play_arrow_rounded,
                    label: "Iniciar",
                    onTap: () {}),
                const SizedBox(
                  width: 10,
                ),
                _buildButton(
                    icon: Icons.fast_rewind_rounded,
                    label: "Reiniciar",
                    onTap: () {}),
              ],
            ),
            //Text(
            //  'Géneros',
            //  style: textStyle,
            //),
            //const SizedBox(
            //  height: 10,
            //),
            //DetailsGenders(taleGenders: taleGenders),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    required String label,
    required void Function() onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.blue.shade100,
          borderRadius: BorderRadius.circular(10.5),
          gradient: LinearGradient(
            colors: [
              Colors.blueAccent.shade100,
              Colors.blue.shade100,
              Colors.blue.shade200,
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            tileMode: TileMode.decal,
            transform: const GradientRotation(3.14),
            stops: const [0.15, 1, 0.1],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              spreadRadius: 2.5,
              blurRadius: 0.5,
              offset: const Offset(2.5, 2), // changes position of shadow
            ),
          ]),
      child: GestureDetector(
        onTap: () => onTap(),
        child: Column(
          children: [
            Icon(
              icon,
              color: Colors.white,
              fill: 1,
            ),
            Text(
              label,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
