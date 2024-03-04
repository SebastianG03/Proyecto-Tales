import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:proyecto_pasantia/layers/aplication/providers/providers.dart';
import 'package:proyecto_pasantia/layers/domain/entities/user/users.dart';

import '../../../custom/custom_components.dart';

class LoggedSettingsItems extends ConsumerWidget {
  final UserModel? user;
  const LoggedSettingsItems({super.key, this.user});

  @override
  Widget build(BuildContext context, ref) {
    return CustomScrollView(
      slivers: [
        SliverList.list(
          children: [
            CustomTile(
              title: 'Información del Perfil',
              icon: LineIcons.userCircle,
              action: () {},
            ),
            const Divider(
              thickness: 1,
              indent: 0,
            ),
            CustomTile(
              title: 'Cerrar Sesión',
              icon: Icons.logout_outlined,
              fontWeight: FontWeight.w500,
              action: () => cerrarSesion(ref, context),
            ),
          ],
        )
      ],
    );
  }

  void cerrarSesion(WidgetRef ref, BuildContext context) async {
    final bool isGoogleSigned =
        await ref.read(userDatasourceProvider).isGoogleSigned();
    ref.read(userSignInProvider.notifier).signOut(isGoogleSigned);
    ref.read(preferencesProvider.notifier).clearUserData();
    CustomSnackbar.showSnackBar(context, 'Su sesión ha finalizado.');
  }
}
