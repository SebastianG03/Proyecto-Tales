import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_pasantia/layers/domain/entities/app/search/enums/enums.dart';

class CustomChoiceChip extends ConsumerStatefulWidget {
  final SearchKeys searchKey;
  final String label;
  const CustomChoiceChip(
      {super.key, required this.searchKey, required this.label});
  @override
  ConsumerState<CustomChoiceChip> createState() => _CustomChoiceChipState();
}

class _CustomChoiceChipState extends ConsumerState<CustomChoiceChip> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip.elevated(
      pressElevation: 1.0,
      labelPadding: const EdgeInsets.all(5.0),
      label: Text(widget.label),
      selected: isSelected,
      selectedColor: const Color.fromARGB(255, 151, 187, 205),
      onSelected: (value) => _onSelected(value),
    );
  }

  void _onSelected(bool value) {
    setState(() {
      isSelected = value;
    });
  }
}
