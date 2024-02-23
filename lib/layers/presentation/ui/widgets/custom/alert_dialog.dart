import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class CustomAlertDialog {
  static void showAlertDialog(
      BuildContext context, String title, String message) {
    showPlatformDialog(
      context: context,
      builder: (_) => PlatformAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          PlatformDialogAction(
            child: PlatformText('Aceptar'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
