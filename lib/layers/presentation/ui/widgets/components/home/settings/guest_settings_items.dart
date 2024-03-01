import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:proyecto_pasantia/config/router/app_routes.dart';
import 'package:proyecto_pasantia/layers/aplication/providers/providers.dart';

class GuestSettingsItems extends ConsumerWidget {
  const GuestSettingsItems({super.key});

  @override
  Widget build(BuildContext context, ref) {
    List<String> items;
    List<IconData> icons;
    List<Function> functions;

    items = ['Iniciar Sesión', 'Crear Cuenta', 'Ajustes'];
    icons = [LineIcons.alternateSignIn, LineIcons.userPlus, LineIcons.cog];
    functions = [signIn, register, (WidgetRef ref) {}];

    return SliverFixedExtentList(
      itemExtent: 50,
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return ListTile(
            leading: Icon(icons[index]),
            title: Text(items[index]),
            onTap: () => functions[index](ref),
          );
        },
        childCount: items.length,
      ),
    );
  }

  void signIn(WidgetRef ref) =>
      ref.read(routerProvider).router.goNamed(AppRoutes.signInView);
  void register(WidgetRef ref) =>
      ref.read(routerProvider).router.goNamed(AppRoutes.registerView);
}
