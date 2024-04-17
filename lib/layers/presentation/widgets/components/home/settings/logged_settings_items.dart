import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';

import '../../../../../../config/router/app_routes.dart';
import '../../../../../application/providers/providers.dart';
import '../../../custom/custom_components.dart';

class LoggedSettingsItems extends ConsumerWidget {
  final String userId;
  const LoggedSettingsItems({super.key, required this.userId});

  @override
  Widget build(BuildContext context, ref) {
    return CustomScrollView(
      slivers: [
        SliverList.list(
          children: [
            CustomTile(
                title: 'Información del Perfil',
                icon: LineIcons.userCircle,
                action: () async {
                  final prefs = await ref.read(preferencesProvider);
                  final user = prefs.getUserData()!.toJson();
                  ref.read(routerProvider).router.pushNamed(
                      AppRoutes.updateAccountView,
                      pathParameters: {'user': jsonEncode(user)});
                }),
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
        await ref.read(authRepositoryProvider).isGoogleSigned();
    ref.read(userSignInProvider.notifier).signOut(isGoogleSigned);
    final prefs = await ref.read(preferencesProvider);
    prefs.clearUserData();
    if (context.mounted) {
      CustomSnackbar.showSnackBar(context, 'Su sesión ha finalizado.');
    }
  }
}
