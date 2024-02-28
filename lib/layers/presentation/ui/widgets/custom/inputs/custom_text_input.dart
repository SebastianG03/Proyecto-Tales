import 'package:flutter/material.dart';

class TextFormsModel extends StatelessWidget {
  final TextInputType textInputType;
  final String labelText;
  final IconData icon;
  final String? errorMessage;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const TextFormsModel(
      {super.key,
      required this.textInputType,
      required this.labelText,
      required this.icon,
      required this.onChanged,
      this.validator,
      this.controller,
      this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        keyboardType: textInputType,
        controller: controller,
        onChanged: onChanged,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          labelText: labelText,
          errorMaxLines: 2,
          errorText: errorMessage,
          icon: Icon(icon),
        ),
        style: _textStyle(),
      ),
    );
  }

  TextStyle _textStyle() {
    return const TextStyle(
      fontFamily: 'WorkSansSemiBold',
      fontSize: 16.0,
      color: Colors.black,
    );
  }
}
