import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/providers/providers.dart';
import '../../views/views.dart';

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
              tags: tale.genders,
              taleId: tale.id,
            );
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
