import 'package:cuentos_pasantia/layers/presentation/widgets/custom/custom_components.dart';
import 'package:flutter/material.dart';

class CoverDetails extends StatelessWidget {
  final String imageUrl;
  final String title;
  const CoverDetails({super.key, required this.imageUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.5,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.all(10),
        title: Text(
          title,
          style: const TextStyle(fontSize: 20, backgroundColor: Colors.black26),
          textAlign: TextAlign.start,
        ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: CustomNetworkImage(url: imageUrl),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.centerRight,
                          stops: [
                    0.0,
                    0.5
                  ],
                          colors: [
                    Colors.black87,
                    Colors.transparent,
                  ]))),
            )
          ],
        ),
      ),
    );
  }
}
