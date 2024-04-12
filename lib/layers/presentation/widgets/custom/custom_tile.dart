import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomTile extends ConsumerWidget {
  final String title;
  final IconData icon;
  final VoidCallback action;
  final Color textColor;
  final Color iconColor;
  final FontWeight fontWeight;
  const CustomTile({
    super.key,
    required this.title,
    required this.icon,
    required this.action,
    this.textColor = Colors.black,
    this.fontWeight = FontWeight.normal,
    this.iconColor = Colors.black,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        splashColor: Colors.transparent,
        trailing: Icon(
          PlatformIcons(context).forward,
          color: iconColor,
        ),
        title: Text(
          title,
          style:
              TextStyle(color: textColor, fontWeight: fontWeight, fontSize: 16) ,
        ),
        leading: Icon(icon),
        onTap: () => action(),
      ),
    );
  }
}
