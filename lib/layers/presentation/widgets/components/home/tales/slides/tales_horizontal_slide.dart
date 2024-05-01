import 'package:cuentos_pasantia/layers/presentation/widgets/custom/custom_components.dart';
import 'package:flutter/material.dart';

class TaleHorizontalSlide extends StatelessWidget {
  final String imageUrl;
  final String title;
  final bool? premium;
  const TaleHorizontalSlide({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.premium,
  });

  @override
  Widget build(BuildContext context) {
    String accesibility = (premium == null)
        ? ""
        : (premium!)
            ? "Premium"
            : "Gratis";
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Colors.black45,
          blurRadius: 3,
          offset: Offset(0, 0),
        )
      ],
    );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        DecoratedBox(
          decoration: decoration,
          child: SizedBox(
            height: 200,
            width: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CustomNetworkImage(
                url: imageUrl,
                borderRadius: 0,
              ),
            ),
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
        Visibility(
          visible: accesibility.isNotEmpty,
          child: Text(accesibility,
              style: const TextStyle(fontSize: 12, color: Colors.grey)),
        )
      ]),
    );
  }
}
