import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:proyecto_pasantia/config/router/app_routes.dart';
import 'package:proyecto_pasantia/layers/aplication/providers/providers.dart';

import '../../../custom/custom_components.dart';

class GuestSettingsItems extends ConsumerWidget {
  const GuestSettingsItems({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return CustomScrollView(
      slivers: [
        SliverList.list(
          children: [
            CustomTile(
              title: 'Iniciar Sesión',
              icon: LineIcons.alternateSignIn,
              action: () => signIn(ref),
            ),
            const Divider(
              thickness: 1,
              indent: 0,
            ),
            CustomTile(
              title: 'Registrarse',
              icon: LineIcons.userPlus,
              action: () => register(ref),
            ),
          ],
        )
      ],
    );
  }

  void signIn(WidgetRef ref) =>
      ref.read(routerProvider).router.goNamed(AppRoutes.signInView);
  void register(WidgetRef ref) =>
      ref.read(routerProvider).router.goNamed(AppRoutes.registerView);
}
