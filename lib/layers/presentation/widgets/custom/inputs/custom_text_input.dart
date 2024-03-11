import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class TextFormsModel extends StatelessWidget {
  final TextInputType textInputType;
  final String labelText;
  final IconData icon;
  final String? errorMessage;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String? initialValue;
  final bool isReadOnly;

  const TextFormsModel({
    super.key,
    required this.textInputType,
    required this.labelText,
    required this.icon,
    required this.onChanged,
    this.validator,
    this.controller,
    this.errorMessage,
    this.initialValue,
    this.isReadOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: PlatformTextFormField(
        keyboardType: textInputType,
        controller: controller,
        onChanged: onChanged,
        validator: validator,
        initialValue: initialValue,
        readOnly: isReadOnly,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        cupertino: (context, platform) => CupertinoTextFormFieldData(
          placeholder: labelText,
          prefix: Icon(icon),
        ),
        material: (context, platform) => MaterialTextFormFieldData(
          decoration: InputDecoration(
            labelText: labelText,
            errorMaxLines: 2,
            errorText: errorMessage,
            icon: Icon(icon),
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
