import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import 'package:proyecto_pasantia/config/router/app_routes.dart';
import 'package:proyecto_pasantia/layers/aplication/providers/providers.dart';
import 'package:proyecto_pasantia/layers/domain/entities/user/users.dart';

class SettingsItems extends ConsumerWidget {
  final bool logged;
  final UserModel? user;
  const SettingsItems({super.key, required this.logged, this.user});

  @override
  Widget build(BuildContext context, ref) {
    List<String> items;
    List<IconData> icons;
    List<Function> functions;

    if (logged) {
      items = ['Modificar Cuenta', 'Ajustes', 'Cerrar Sesión'];
      icons = [LineIcons.userEdit, LineIcons.cog, LineIcons.alternateSignOut];
      functions = [
        (BuildContext context) {},
        (BuildContext context) {},
        (BuildContext context) {
          ref.watch(userDatasourceProvider).signOut(false);
        }
      ];
    } else {
      items = ['Iniciar Sesión', 'Crear Cuenta', 'Ajustes'];
      icons = [LineIcons.alternateSignIn, LineIcons.userPlus, LineIcons.cog];
      functions = [signIn, register, (BuildContext context) {}];
    }

    return SliverFixedExtentList(
      itemExtent: 50,
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return ListTile(
            leading: Icon(icons[index]),
            title: Text(items[index]),
            onTap: () => functions[index](context),
          );
        },
        childCount: items.length,
      ),
    );
  }

  void signIn(BuildContext context) => context.goNamed(AppRoutes.signInView);
  void register(BuildContext context) =>
      context.goNamed(AppRoutes.registerView);
}
