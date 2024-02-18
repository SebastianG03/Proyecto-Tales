import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';

import '../../widgets/components/settings/settings_components.dart';

class SettingsView extends ConsumerWidget {
  final int id;
  const SettingsView({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: UserCard(),
          ),
          SettingsItems(logged: true)
        ],
      ),
    );
  }
}
