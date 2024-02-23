import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:proyecto_pasantia/layers/aplication/providers/providers.dart';
import 'package:proyecto_pasantia/layers/presentation/ui/widgets/custom/inputs/inputs.dart';

class UserRegisterForm extends ConsumerStatefulWidget {
  const UserRegisterForm({super.key});

  @override
  UserRegisterFormState createState() => UserRegisterFormState();
}

class UserRegisterFormState extends ConsumerState<UserRegisterForm> {
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormsModel(
          textInputType: TextInputType.name,
          labelText: "Nombre de usuario",
          icon: LineIcons.user,
          validator: (value) {
            return null;
          },
          onChanged: (value) {
            ref.read(usernameProvider.notifier).update((state) => value.trim());
          },
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormsModel(
          textInputType: TextInputType.number,
          labelText: "Edad",
          icon: LineIcons.calendar,
          validator: (value) {
            return null;
          },
          onChanged: (value) {
            ref
                .read(ageProvider.notifier)
                .update((state) => int.tryParse(value.trim()) ?? 0);
          },
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormsModel(
          textInputType: TextInputType.emailAddress,
          labelText: "Email",
          icon: LineIcons.at,
          validator: (value) {
            return null;
          },
          onChanged: (value) {
            ref.read(emailProvider.notifier).update((state) => value.trim());
          },
        ),
        const SizedBox(
          height: 10,
        ),
        PasswordFormsModel(
          textInputType: TextInputType.visiblePassword,
          label: "Contraseña",
          onChanged: (value) {
            ref.read(passwordProvider.notifier).update((state) => value.trim());
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
