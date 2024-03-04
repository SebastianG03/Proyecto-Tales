import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import 'package:proyecto_pasantia/layers/presentation/ui/widgets/custom/custom_components.dart';

class ForgotPasswordAlert {
  static void showAlertDialog(BuildContext context, String title,
      void Function(String email) function) {
    String email = "";
    showPlatformDialog(
      context: context,
      builder: (_) => PlatformAlertDialog(
        title: Text(title),
        content: TextFormsModel(
          textInputType: TextInputType.emailAddress,
          labelText: "Email",
          icon: LineIcons.at,
          validator: (value) {
            return null;
          },
          onChanged: (value) => email = value,
        ),
        actions: <Widget>[
          PlatformDialogAction(
            child: PlatformText('Enviar'),
            onPressed: () {
              function(email);
              CustomSnackbar.showSnackBar(context,
                  "Se ha enviado un correo para reestablecer su contraseña.");
            },
          ),
          PlatformDialogAction(
            child: PlatformText('Cancelar'),
            onPressed: () => context.pop(),
          )
        ],
      ),
    );
  }
}
