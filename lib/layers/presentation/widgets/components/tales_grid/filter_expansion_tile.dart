import 'package:flutter/material.dart';

import '../../../../domain/entities/app/search/enums/enums.dart';

class FilterExpansionTile extends StatefulWidget {
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
  State<FilterExpansionTile> createState() => _FilterExpansionTileState();
}

class _FilterExpansionTileState extends State<FilterExpansionTile> {
  List<bool> isSelected = [];

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
                        onSelected: (value) => _onSelected(value, widget.values.indexOf(e)),
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

  void _onSelected(bool value, int index) {
    if(widget.isMultipleSelect) {
      setState(() {
        isSelected[index] = value;
      });
    } else {
      setState(() {
        isSelected = List.filled(widget.values.length, false, growable: false);
        isSelected[index] = value;
      });
    }
    
  }
}
