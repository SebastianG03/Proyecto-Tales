import 'package:cuentos_pasantia/layers/domain/entities/tales/tales.dart';
import 'package:cuentos_pasantia/layers/presentation/widgets/custom/custom_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TalesListView extends ConsumerWidget {
  final ScrollController _scrollController;
  final List<Tales> tales;
  final void Function(BuildContext context, Tales tale) onClose;

  const TalesListView({
    super.key,
    required ScrollController scrollController,
    required this.tales,
    required this.onClose,
  }) : _scrollController = scrollController;

  @override
  Widget build(BuildContext context, ref) {
    if (tales.isEmpty) {
      return const Center(child: Text('No hay cuentos en esta sección'));
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      controller: _scrollController,
      itemCount: tales.length,
      itemBuilder: (context, index) {
        String accesibility = (tales[index].premium) ? "Premium" : "Gratis";

        return GestureDetector(
          onTap: () {
            onClose(context, tales[index]);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
                child: CustomNetworkImage(
                  url: tales[index].getCoverUrl,
                  boxFit: BoxFit.scaleDown,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(tales[index].title,
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
                      formatText(tales[index].abstract),
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black87),
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
      },
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
