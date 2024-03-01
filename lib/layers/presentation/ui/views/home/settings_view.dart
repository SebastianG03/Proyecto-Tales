import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_pasantia/layers/domain/entities/user/user.dart';

import '../../../../aplication/providers/providers.dart';
import '../../widgets/components/home/settings/settings_components.dart';

class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({super.key});

  @override
  ConsumerState<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerState<SettingsView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    UserModel? user = ref.watch(preferencesProvider).user;
    bool logged = (user != null);

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: UserCard(
              user: user,
            ),
          ),
          (logged)
              ? LoggedSettingsItems(user: user)
              : const GuestSettingsItems(),
        ],
      ),
    );
  }
}
