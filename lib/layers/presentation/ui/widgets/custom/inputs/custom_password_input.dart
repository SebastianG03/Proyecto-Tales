import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class PasswordFormsModel extends StatefulWidget {
  final TextInputType textInputType;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String? label;
  final bool obscureText;
  final Function()? tap;
  final TextEditingController? controller;

  const PasswordFormsModel(
      {super.key,
      required this.textInputType,
      required this.label,
      required this.onChanged,
      this.obscureText = true,
      required this.tap,
      this.validator,
      this.controller});

  @override
  State<PasswordFormsModel> createState() => _PasswordFormsModelState();
}

class _PasswordFormsModelState extends State<PasswordFormsModel> {
  @override
  Widget build(BuildContext context) {
    return _passwordFormFieldModel(context);
  }

  Widget _passwordFormFieldModel(BuildContext context) {
    //, String Function(String?) validation,
    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
      child: TextFormField(
        keyboardType: widget.textInputType,
        obscureText: widget.obscureText,
        onChanged: widget.onChanged,
        validator: widget.validator,
        controller: widget.controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          labelText: widget.label,
          errorMaxLines: 2,
          icon: const Icon(LineIcons.lock),
          suffix: GestureDetector(
            onTap: widget.tap,
            child: Icon(
              widget.obscureText ? LineIcons.eye : LineIcons.eyeSlash,
              size: 15.0,
              color: Colors.black,
            ),
          ),
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
