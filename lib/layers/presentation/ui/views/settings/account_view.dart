import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_pasantia/layers/aplication/providers/providers.dart';
import '../../widgets/components/home/settings/settings_components.dart';

class AccountView extends ConsumerWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final userStream = ref.watch(authUserProvider);
    return userStream.when(data: (user) {
      if (user != null) {
        final userModel = ref.watch(preferencesProvider).user;
        return LoggedSettingsItems(user: userModel!);
      } else {
        return const GuestSettingsItems();
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
