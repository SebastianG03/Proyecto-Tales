import 'dart:async';

import 'package:cuentos_pasantia/layers/domain/entities/tales/tales.dart';
import 'package:cuentos_pasantia/layers/presentation/widgets/components/search/tales_list_view.dart';
import 'package:flutter/material.dart';

class BuildResultsAndSuggestions extends StatelessWidget {
  final List<Tales> initialTales;
  final StreamController<List<Tales>> debounceTales;
  final void Function(BuildContext, Tales) onClose;

  const BuildResultsAndSuggestions(
      {super.key,
      required this.initialTales,
      required this.debounceTales,
      required this.onClose});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return StreamBuilder(
        initialData: initialTales,
        stream: debounceTales.stream,
        builder: (context, snapshot) {
          List<Tales> tales = snapshot.data ?? [];

          return TalesListView(
            scrollController: scrollController,
            tales: tales,
            onClose: (context, tale) {
              onClose(context, tale);
            },
          );
        });
  }
}
