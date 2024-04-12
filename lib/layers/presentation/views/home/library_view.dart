import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/providers/providers.dart';
import '../library/library.dart';

class LibraryView extends ConsumerWidget {
  const LibraryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStream = ref.watch(authUserProvider);

    return userStream.when(data: (user) {
      if (user != null) {
        return LoggedLibrary(userId: user.uid);
      } else {
        return const LogOutLibrary();
      }
    }, error: (error, stack) {
      return const Text('Error al cargar el usuario');
    }, loading: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
