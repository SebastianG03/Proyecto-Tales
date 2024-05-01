import 'package:cuentos_pasantia/layers/domain/entities/tales/tales.dart';
import 'package:cuentos_pasantia/layers/presentation/widgets/custom/images/network_image.dart';
import 'package:flutter/material.dart';

class SearchTalesItemData extends StatelessWidget {
  final Tales tale;
  const SearchTalesItemData({super.key, required this.tale});

  @override
  Widget build(BuildContext context) {
    String accesibility = (tale.premium) ? "Premium" : "Gratis";

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
            child: CustomNetworkImage(
              url: tale.getCoverUrl,
              boxFit: BoxFit.scaleDown,
              borderRadius: 5,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(tale.title,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  maxLines: 2),
              const SizedBox(
                width: 1,
              ),
              Text(accesibility,
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(
                width: 1,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Text(
                  formatText(tale.abstract),
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                  softWrap: true,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  String formatText(String text) {
    // Reemplaza todos los saltos de línea por un espacio
    text = text.replaceAll(RegExp(r'\r?\n'), ' ');
    // Reemplaza múltiples espacios en blanco por un solo espacio
    text = text.replaceAll(RegExp(r'\s+'), ' ');
    text = text.trim();

    return text;
  }
}
