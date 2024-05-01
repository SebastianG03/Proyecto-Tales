import 'package:cuentos_pasantia/layers/domain/entities/tales/tales.dart';
import 'package:cuentos_pasantia/layers/presentation/widgets/components/search/search_tales_item_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchTalesListView extends ConsumerWidget {
  final ScrollController _scrollController;
  final List<Tales> tales;
  final void Function(BuildContext context, Tales tale) onClose;

  const SearchTalesListView({
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
      padding: const EdgeInsets.only(top: 15, bottom: 10),
      controller: _scrollController,
      itemCount: tales.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => onClose(context, tales[index]),
          child: SearchTalesItemData(tale: tales[index]),
        );
      },
    );
  }
}
