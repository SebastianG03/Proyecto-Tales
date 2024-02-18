import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:proyecto_pasantia/layers/presentation/ui/widgets/custom/inputs/inputs.dart';

class SignInForm extends ConsumerStatefulWidget {
  final Map<String, dynamic> data;
  const SignInForm({super.key, required this.data});

  @override
  SignInFormState createState() => SignInFormState();
}

class SignInFormState extends ConsumerState<SignInForm> {
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormsModel(
          textInputType: TextInputType.emailAddress,
          labelText: "Email",
          icon: LineIcons.at,
          validator: (value) {
            return null;
          },
          onChanged: (value) {
            widget.data["email"] = value;
          },
        ),
        const SizedBox(
          height: 10,
        ),
        PasswordFormsModel(
          textInputType: TextInputType.visiblePassword,
          label: "Contraseña",
          onChanged: (value) {
            widget.data["password"] = value;
          },
          validator: (value) {
            return null;
          },
          obscureText: obscurePassword,
          tap: _obscurePassword,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  void _obscurePassword() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }
}
