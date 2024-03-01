import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:proyecto_pasantia/layers/aplication/providers/providers.dart';
import 'package:proyecto_pasantia/layers/domain/entities/user/users.dart';
import 'package:proyecto_pasantia/layers/presentation/ui/widgets/custom/alert_dialog.dart';

class LoggedSettingsItems extends ConsumerWidget {
  final UserModel? user;
  const LoggedSettingsItems({super.key, this.user});

  @override
  Widget build(BuildContext context, ref) {
    List<String> items;
    List<IconData> icons;
    List<Function> functions;

    items = ['Modificar Cuenta', 'Ajustes', 'Cerrar Sesión'];
    icons = [LineIcons.userEdit, LineIcons.cog, LineIcons.alternateSignOut];
    functions = [modificarCuenta, ajustesAplicacion, cerrarSesion];

    return SliverFixedExtentList(
      itemExtent: 50,
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return ListTile(
            leading: Icon(icons[index]),
            title: Text(items[index]),
            onTap: () => functions[index](ref, context),
          );
        },
        childCount: items.length,
      ),
    );
  }

  void modificarCuenta(WidgetRef ref, BuildContext context) {}
  void ajustesAplicacion(WidgetRef ref, BuildContext context) {}
  void cerrarSesion(WidgetRef ref, BuildContext context) async {
    final bool isGoogleSigned =
        await ref.read(userDatasourceProvider).isGoogleSigned();
    ref.watch(userSignInProvider.notifier).signOut(isGoogleSigned);
    ref.read(preferencesProvider.notifier).clearUserData();
    CustomAlertDialog.showAlertDialog(
        context, 'Cerrar Sesión', '¿Seguro desea cerrar sesión?', () {
      ref.read(preferencesProvider.notifier).clearUserData();
    }, null);
  }
}
