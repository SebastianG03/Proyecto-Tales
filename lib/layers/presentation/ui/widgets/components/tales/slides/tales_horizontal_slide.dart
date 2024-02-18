import 'package:flutter/material.dart';

class TaleHorizontalSlide extends StatelessWidget {
  final String imageUrl;
  final String title;
  final bool premium;
  const TaleHorizontalSlide(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.premium});

  @override
  Widget build(BuildContext context) {
    String accesibility = (premium) ? "Premium" : "Gratis";

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 200,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image(fit: BoxFit.cover, image: AssetImage(imageUrl)),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            maxLines: 2),
        const SizedBox(
          width: 1,
        ),
        Text(accesibility,
            style: const TextStyle(fontSize: 12, color: Colors.grey))
      ]),
    );
  }
}
