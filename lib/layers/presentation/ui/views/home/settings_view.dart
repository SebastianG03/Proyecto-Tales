import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:proyecto_pasantia/config/router/app_routes.dart';
import 'package:proyecto_pasantia/layers/presentation/ui/widgets/custom/custom_components.dart';

import '../../../../aplication/providers/providers.dart';

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
