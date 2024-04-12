import 'package:flutter/material.dart';

class CustomTextButtonWithIcon extends StatefulWidget {
  final VoidCallback onPressed;
  final String label;
  final IconData iconData;
  const CustomTextButtonWithIcon({
    super.key,
    required this.onPressed,
    required this.label,
    required this.iconData,
  });

  @override
  State<CustomTextButtonWithIcon> createState() =>
      _CustomTextButtonWithIconState();
}

class _CustomTextButtonWithIconState extends State<CustomTextButtonWithIcon> {
  @override
  Widget build(BuildContext context) {
    final buttonStyle = ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.blue.shade100),
      foregroundColor: MaterialStateColor.resolveWith((states) => Colors.black),
    );

    return TextButton.icon(
      onPressed: () {
        widget.onPressed();
      },
      icon: Icon(widget.iconData),
      style: buttonStyle,
      label: Text(widget.label),
    );
  }
}
