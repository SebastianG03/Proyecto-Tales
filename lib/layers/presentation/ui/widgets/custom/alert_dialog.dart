import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAlertDialog {
  static void showAlertDialog(
      BuildContext context,      
      String title,
      String message,
      VoidCallback? onPressedAccepted,
      VoidCallback? onPressedCancel) async {
    await showPlatformDialog(
      context: context,
      builder: (_) => PlatformAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          PlatformDialogAction(
            child: PlatformText('Cancelar'),
            onPressed: () {
              onPressedCancel;
              context.pop(context);
            },
          ),
          PlatformDialogAction(
            child: PlatformText('Aceptar'),
            onPressed: () {
              onPressedAccepted;
              context.pop();
            },
          ),
        ],
      ),
    );
  }
}
