import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_pasantia/layers/presentation/ui/views/tales/tales_details_view.dart';

import '../../../../aplication/providers/providers.dart';

class TaleDetailsScreen extends ConsumerWidget {
  final String taleId;
  const TaleDetailsScreen({super.key, required this.taleId});

  @override
  Widget build(BuildContext context, ref) {
    final taleAsync = ref.watch(taleContentProvider(taleId));

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: taleAsync.when(
          data: (tale) {
            return TaleDetailsView(
                imageUrl: tale.getCoverUrl,
                title: '${tale.title} (${tale.ageLimit}+)',
                abstract: tale.abstract,
                tags: tale.genders);
          },
          error: (_, __) {
            return const Center(
              child: Text('Error al cargar la historia'),
            );
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
