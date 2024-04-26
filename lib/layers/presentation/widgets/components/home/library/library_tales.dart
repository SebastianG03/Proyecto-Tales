import 'package:cuentos_pasantia/layers/presentation/widgets/custom/custom_components.dart';
import 'package:flutter/material.dart';

class LibraryTale extends StatelessWidget {
  final String urlImage;
  final String title;
  final String chapter;
  final String lastRead;
  const LibraryTale({
    super.key,
    required this.title,
    required this.chapter,
    required this.lastRead,
    required this.urlImage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 120,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 15),
          child: Row(
            children: [
              CustomNetworkImage(
                url: urlImage,
                boxFit: BoxFit.scaleDown,
                borderRadius: 5,
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.length > 24 ? "${title.substring(0, 24)}..." : title,
                    style: const TextStyle(fontSize: 16),
                    softWrap: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(chapter,
                      style:
                          TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(lastRead,
                      style:
                          TextStyle(fontSize: 12, color: Colors.grey.shade600))
                ],
              ),
            ],
          )),
    );
  }
}
