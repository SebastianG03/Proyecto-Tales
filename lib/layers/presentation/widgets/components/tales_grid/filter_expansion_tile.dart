import 'package:cuentos_pasantia/layers/application/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/app/search/enums/enums.dart';

class FilterExpansionTile extends ConsumerStatefulWidget {
  final SearchKeys searchKey;
  final String title;
  final List<String> values;
  final bool isMultipleSelect;
  const FilterExpansionTile({
    super.key,
    required this.searchKey,
    required this.title,
    required this.values,
    this.isMultipleSelect = true,
  });

  @override
  ConsumerState<FilterExpansionTile> createState() =>
      _FilterExpansionTileState();
}

class _FilterExpansionTileState extends ConsumerState<FilterExpansionTile> {
  List<bool> isSelected = [];
  List<String> selectedValues = [];

  @override
  void initState() {
    super.initState();
    isSelected = List.filled(widget.values.length, false, growable: false);
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedShape: const Border(),
      shape: const Border(),
      title: Text(widget.title),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.end,
            direction: Axis.horizontal,
            textDirection: TextDirection.ltr,
            runAlignment: WrapAlignment.start,
            verticalDirection: VerticalDirection.down,
            spacing: 10.0,
            runSpacing: 5.0,
            children: widget.values
                .map(
                  (e) => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ChoiceChip.elevated(
                        pressElevation: 1.0,
                        labelPadding: const EdgeInsets.all(5.0),
                        label: Text(e),
                        selected: isSelected[widget.values.indexOf(e)],
                        selectedColor: const Color.fromARGB(255, 151, 187, 205),
                        onSelected: (value) =>
                            _onSelected(value, widget.values.indexOf(e)),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        )
      ],
    );
  }

  ///Si es de seleccion multiple, se agrega o elimina el valor seleccionado en la lista de valores
  ///y actualiza el estado de la busqueda. Caso contrario únicamente se modifica el estado de la busqueda.
  void _onSelected(bool value, int index) {
    setState(() {
      if (widget.isMultipleSelect) {
        (isSelected[index])
            ? selectedValues.add(widget.values[index])
            : selectedValues.remove(widget.values[index]);
        _updateSearchState(isSelected[index], widget.searchKey, selectedValues);
      } else {
        _updateSearchState(
            isSelected[index], widget.searchKey, widget.values[index]);
      }
    });
  }

  void _updateSearchState(bool isSelected, SearchKeys key, dynamic value) {
    ref.read(gridTalesStateProvider.notifier).update((state) {
      if (isSelected || widget.isMultipleSelect) {
        return state.updateByKey(key, value);
      } else {
        return state.resetKeyValue(key);
      }
    });
  }
}
