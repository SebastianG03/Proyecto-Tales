import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_pasantia/layers/domain/entities/user/user.dart';

import '../../../../aplication/providers/providers.dart';
import '../../widgets/components/settings/settings_components.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserModel? user = ref.read(preferencesProvider.notifier).getUserData();
    bool logged = (user != null);

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: UserCard(
              user: user,
            ),
          ),
          SettingsItems(logged: logged, user: user),
        ],
      ),
    );
  }
}
