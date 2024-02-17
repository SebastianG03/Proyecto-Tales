import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LibraryView extends ConsumerWidget {
  final int id;
  const LibraryView({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Text('Library View');
  }
}
