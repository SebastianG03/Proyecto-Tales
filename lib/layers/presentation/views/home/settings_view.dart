import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';

import '../../../../config/router/app_routes.dart';
import '../../../application/providers/providers.dart';
import '../../widgets/custom/custom_components.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            sliver: SliverList.list(
              children: <Widget>[
                CustomTile(
                  title: 'Cuenta',
                  icon: Icons.person,
                  action: () {
                    ref
                        .read(routerProvider)
                        .router
                        .pushNamed(AppRoutes.accountView);
                    // ref.watch(preferencesProvider).user;
                  },
                ),
                const Divider(
                  thickness: 1,
                  indent: 0,
                ),
                CustomTile(
                  title: 'Configuración',
                  icon: Icons.settings,
                  action: () {},
                ),
                const Divider(
                  thickness: 1,
                  indent: 0,
                ),
                CustomTile(
                  title: 'Ayuda',
                  icon: LineIcons.infoCircle,
                  action: () {},
                ),
                const Divider(
                  thickness: 1,
                  indent: 0,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
