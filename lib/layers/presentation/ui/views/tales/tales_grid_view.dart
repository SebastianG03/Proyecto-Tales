import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_pasantia/layers/presentation/ui/widgets/components/tales/tales_components.dart';

class TalesGridView extends ConsumerWidget {
  final String tag;
  const TalesGridView({super.key, required this.tag});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> imageUrl = getUrls();
    List<String> titles = getTitles();
    List<bool> premium = [true, false, true, false, true, false];

    return GridView.builder(
        itemCount: 20,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            mainAxisExtent: 145),
        itemBuilder: (context, index) {
          Random random = Random();
          index = random.nextInt(6);
          return TaleGridSlide(
              imageUrl: imageUrl[index],
              title: titles[index],
              premium: premium[index]);
        });
  }

  List<String> getUrls() {
    return [
      'assets/tales_sample/portada1.jpg',
      'assets/tales_sample/portada2.jpg',
      'assets/tales_sample/portada3.jpg',
      'assets/tales_sample/portada4.jpg',
      'assets/tales_sample/portada2.jpg',
      'assets/tales_sample/portada1.jpg',
    ];
  }

  List<String> getTitles() {
    return [
      'Tale 1',
      'Tale 2',
      'Tale 3',
      'Tale 4',
      'Tale 5',
      'Tale 6',
    ];
  }
}

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
          height: 100,
          child: Image(fit: BoxFit.cover, image: AssetImage(imageUrl)),
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
