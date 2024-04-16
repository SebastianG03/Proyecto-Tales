import 'package:cuentos_pasantia/layers/presentation/screens/screens.dart';
import 'package:cuentos_pasantia/layers/presentation/widgets/components/tales_grid/tales_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../application/providers/providers.dart';
import '../../../../domain/entities/app/search/enums/enums.dart';

class GridTalesFilters extends ConsumerWidget {
  const GridTalesFilters({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    return ExpansionTile(
      title: const Text('Filtrar'),
      shape: const Border(),
      collapsedShape: const Border(),
      childrenPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      children: [
        FilterExpansionTile(
            searchKey: SearchKeys.genders,
            title: 'Géneros',
            values: GenderTalesHelper.gendersNames),
        FilterExpansionTile(
          searchKey: SearchKeys.ageLimit,
          title: 'Demografía',
          isMultipleSelect: false,
          values: AgeLimit.values.map((e) => e.name).toList(growable: false),
        ),
        FilterExpansionTile(
          searchKey: SearchKeys.accesibility,
          title: 'Tipo de Acceso',
          isMultipleSelect: false,
          values:
              Accessibility.values.map((e) => e.name).toList(growable: false),
        ),
        FilterExpansionTile(
          searchKey: SearchKeys.timeLapse,
          title: 'Ordenar por fecha',
          isMultipleSelect: false,
          values: TimeLapse.values.map((e) => e.name).toList(growable: false),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomTextButton(
          onPressed: () {
            _applyFilters(ref);
          },
          label: 'Aplicar',
        ),
      ],
    );
  }

  void _applyFilters(WidgetRef ref) {
    final actualState = ref.read(searchStateProvider);
    ref.read(searchProvider.notifier).loadTales(actualState);
  }
}
