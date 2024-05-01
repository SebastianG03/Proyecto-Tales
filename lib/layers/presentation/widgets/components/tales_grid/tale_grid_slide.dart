import 'package:cuentos_pasantia/layers/presentation/widgets/custom/custom_components.dart';
import 'package:flutter/material.dart';

class TaleGridSlide extends StatelessWidget {
  final String imageUrl;
  final String title;
  final bool premium;
  const TaleGridSlide(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.premium});

  @override
  Widget build(BuildContext context) {
    String accesibility = (premium) ? "Premium" : "Gratis";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 120,
          width: double.infinity,
          child: CustomNetworkImage(
            url: imageUrl,
            boxFit: BoxFit.scaleDown,
          ),
        ),
        Text(title,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
            maxLines: 2),
        const SizedBox(
          width: 1,
        ),
        Text(accesibility,
            style: const TextStyle(fontSize: 12, color: Colors.grey))
      ],
    );
  }
}
