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
          height: 50,
          child: Image.network(imageUrl, fit: BoxFit.cover),
        ),
        const SizedBox(
          height: 5,
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
